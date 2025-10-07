import std/tables
import ../assets/logos

const logoTable: Table[string, string] = {
  "arch": archLogo,
  "artix": artixLogo,
  "cachyos": cachyosLogo,
  "centos": centosLogo,
  "debian": debianLogo,
  "endeavouros": endeavourosLogo,
  "fedora": fedoraLogo,
  "gentoo": gentooLogo,
  "manjaro": manjaroLogo,
  "linuxmint": mintLogo,
  "opensuse": opensuseLogo,
  "pop": poposLogo,
  "redhat": redhatLogo,
  "slackware": slackwareLogo,
  "ubuntu": ubuntuLogo,
  "void": voidLogo,
  "Zorin OS": zorinLogo,
}.toTable

func getLogo*(distroId: string): string =
  result = logoTable.getOrDefault(distroId, nitchLogo)
