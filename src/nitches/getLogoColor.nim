import std/terminal

func getLogoColor*(distroId: string): ForegroundColor =
  case distroId:
  of "pop": fgCyan
  of "centos": fgYellow
  of "gentoo": fgMagenta
  of "ubuntu", "debian", "redhat": fgRed
  of "arch", "fedora", "Zorin OS", "slackware": fgBlue
  of "linuxmint", "manjaro", "opensuse", "cachyos": fgGreen
  else: fgRed