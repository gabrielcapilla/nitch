import
  ../funcs/packages/
    [getXbpsPkgs, getRpmPkgs, getPortagePkgs, getDpkgPkgs, getPacmanPkgs]

proc getPkgs*(distroId: string): string =
  case distroId
  of "void":
    getXbpsPkgs()
  of "fedora":
    getRpmPkgs()
  of "gentoo":
    getPortagePkgs()
  of "debian", "pop", "ubuntu":
    getDpkgPkgs()
  of "arch", "archcraft", "manjaro", "cachyos":
    getPacmanPkgs()
  else:
    ">3"
