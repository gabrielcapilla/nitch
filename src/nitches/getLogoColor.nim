import std/[tables, terminal]

const colorTable: Table[string, terminal.ForegroundColor] = {
  "pop": fgCyan,
  "centos": fgYellow,
  "gentoo": fgMagenta,
  "ubuntu": fgRed,
  "debian": fgRed,
  "redhat": fgRed,
  "arch": fgBlue,
  "fedora": fgBlue,
  "Zorin OS": fgBlue,
  "slackware": fgBlue,
  "linuxmint": fgGreen,
  "manjaro": fgGreen,
  "opensuse": fgGreen,
  "cachyos": fgGreen,
}.toTable

func getLogoColor*(distroId: string): ForegroundColor =
  result = colorTable.getOrDefault(distroId, fgRed)
