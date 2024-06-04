import ../assets/logos

func getLogo*(distroId: string): string =
  case distroId:
  of "arch": archLogo
  of "artix": artixLogo
  of "cachyos": cachyosLogo
  of "centos": centosLogo
  of "debian": debianLogo
  of "endeavouros": endeavourosLogo
  of "fedora": fedoraLogo
  of "gentoo": gentooLogo
  of "manjaro": manjaroLogo
  of "linuxmint": mintLogo
  of "opensuse": opensuseLogo
  of "pop": poposLogo
  of "redhat": redhatLogo
  of "slackware": slackwareLogo
  of "ubuntu": ubuntuLogo
  of "void": voidLogo
  of "Zorin OS": zorinLogo
  else: nitchLogo