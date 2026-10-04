import QtQuick
import Quickshell
import Quickshell.Io

// Keep Omarchy's existing lock IPC while Hyprlock owns the session lock.
Item {
  id: root

  property var shell: null
  readonly property string home: Quickshell.env("HOME")
  property bool passwordPamConfigured: false
  property bool requested: false
  property bool sessionLocked: false
  property int recoveryAttempts: 0
  property string lastEvent: "init"
  property string lastEventAt: ""
  readonly property bool locked: sessionLocked
  readonly property bool secure: sessionLocked
  readonly property bool pending: requested && !secure

  function record(event) {
    lastEvent = event
    lastEventAt = new Date().toISOString()
  }

  function probe() {
    if (!sessionProbe.running) sessionProbe.running = true
  }

  function beginLock() {
    if (!passwordPamConfigured) return "missing-pam"
    if (secure || requested || locker.running) return "ok"
    recoveryAttempts = 0
    requested = true
    record("hyprlock-requested")
    locker.running = true
    probe()
    return "ok"
  }

  FileView {
    path: "/etc/pam.d/hyprlock"
    printErrors: false
    onLoaded: root.passwordPamConfigured = true
    onLoadFailed: root.passwordPamConfigured = false
  }

  Process {
    id: locker
    command: ["bash", root.home + "/.config/hypr/hyprlock/scripts/launch.sh"]
    stdout: SplitParser {
      onRead: function(line) { console.info("Hyprlock:", line) }
    }
    stderr: SplitParser {
      onRead: function(line) { console.warn("Hyprlock:", line) }
    }
    onExited: function(exitCode, exitStatus) {
      var wasSecure = root.sessionLocked
      root.requested = false
      root.sessionLocked = false
      root.record(exitCode === 0 ? "hyprlock-unlocked" : "hyprlock-exited-" + exitCode)
      // A crashed lock client can leave Hyprland's lock failsafe active.
      // Relaunch to restore its password prompt rather than abandon the lock.
      if (exitCode !== 0 && wasSecure && root.recoveryAttempts < 3) {
        root.recoveryAttempts++
        recoveryTimer.restart()
      }
      root.probe()
    }
  }

  Process {
    id: sessionProbe
    command: ["bash", "-c",
      "pgrep -u \"$UID\" -x hyprlock >/dev/null && omarchy-hyprland-session-locked"]
    onExited: function(exitCode, exitStatus) {
      var nowSecure = exitCode === 0
      if (nowSecure !== root.sessionLocked)
        root.record(nowSecure ? "hyprlock-secure" : "hyprlock-unlocked")
      root.sessionLocked = nowSecure
    }
  }

  Timer {
    interval: root.pending ? 100 : 1000
    running: true
    repeat: true
    onTriggered: root.probe()
  }

  Timer {
    id: recoveryTimer
    interval: 250
    onTriggered: {
      root.requested = true
      root.record("hyprlock-recovering")
      locker.running = true
    }
  }

  Component.onCompleted: probe()

  IpcHandler {
    target: "lock"

    function lock(): string { return root.beginLock() }
    function isLocked(): string { return root.locked || root.requested ? "true" : "false" }
    function status(): string {
      return JSON.stringify({
        locked: root.locked,
        requested: root.requested,
        pending: root.pending,
        sessionLocked: root.sessionLocked,
        secure: root.secure,
        realScreens: Quickshell.screens.length,
        passwordPam: root.passwordPamConfigured,
        fingerprint: false,
        authenticating: false,
        backend: "hyprlock",
        lastEvent: root.lastEvent,
        lastEventAt: root.lastEventAt
      })
    }
  }
}
