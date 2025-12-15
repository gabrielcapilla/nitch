import std/terminal
import
  ../nitches/[
    getUser, getHostname, getDistro, getKernel, getUptime, getShell, getPkgs, getRam,
    getLogo, getLogoColor, getDistroId,
  ]

const
  Reset = "\e[0m"
  Bold = "\e[1m"

func colorCode(c: ForegroundColor): string =
  case c
  of fgRed: "\e[31m"
  of fgGreen: "\e[32m"
  of fgYellow: "\e[33m"
  of fgBlue: "\e[34m"
  of fgMagenta: "\e[35m"
  of fgCyan: "\e[36m"
  of fgWhite: "\e[37m"
  of fgBlack: "\e[30m"
  else: "\e[39m"

proc drawInfo*(showLogo: bool = true) =
  let distroId: string = getDistroId()
  let mainColor: string = colorCode(getLogoColor(distroId))
  let rawLogo: string =
    if showLogo:
      getLogo(distroId)
    else:
      ""

  let
    userInfo = getUser()
    hostnameInfo = getHostname()
    distroInfo = getDistro()
    kernelInfo = getKernel()
    uptimeInfo = getUptime()
    shellInfo = getShell()
    pkgsInfo = getPkgs(distroId)
    ramInfo = getRam()

  let
    c1 = "\e[31m" # Red
    c2 = "\e[33m" # Yellow
    c3 = "\e[32m" # Green
    c4 = "\e[36m" # Cyan
    c5 = "\e[34m" # Blue
    c6 = "\e[35m" # Magenta
    c7 = "\e[37m" # White
    c8 = "\e[30m" # Black/Grey

  const
    iUser = "󰀄 "
    iHname = "󰁥 "
    iDistro = "󰌽 "
    iKernel = "󰌢 "
    iUptime = "󰅐 "
    iShell = "󰆍 "
    iPkgs = "󰏖 "
    iRam = "󰍛 "
    iColors = "󱥚 "
    dot = ""

    lUser = " user   │ "
    lHname = " hname  │ "
    lDistro = " distro │ "
    lKernel = " kernel │ "
    lUptime = " uptime │ "
    lShell = " shell  │ "
    lPkgs = " pkgs   │ "
    lRam = " memory │ "
    lColors = " colors │ "

  var buf = newStringOfCap(2048)

  if showLogo:
    buf.add(Bold & mainColor & rawLogo & Reset)
    # Borde superior
    buf.add(Reset & Bold & "  ╭───────────╮\n")
  else:
    buf.add(Reset & Bold & "  ╭───────────╮\n")

  buf.add(
    Reset & Bold & "  │ " & c1 & iUser & Reset & Bold & lUser & c1 & userInfo & "\n"
  )
  buf.add(
    Reset & Bold & "  │ " & c2 & iHname & Reset & Bold & lHname & c2 & hostnameInfo &
      "\n"
  )
  buf.add(
    Reset & Bold & "  │ " & c3 & iDistro & Reset & Bold & lDistro & c3 & distroInfo &
      "\n"
  )
  buf.add(
    Reset & Bold & "  │ " & c4 & iKernel & Reset & Bold & lKernel & c4 & kernelInfo &
      "\n"
  )
  buf.add(
    Reset & Bold & "  │ " & c5 & iUptime & Reset & Bold & lUptime & c5 & uptimeInfo &
      "\n"
  )
  buf.add(
    Reset & Bold & "  │ " & c6 & iShell & Reset & Bold & lShell & c6 & shellInfo & "\n"
  )
  buf.add(
    Reset & Bold & "  │ " & c1 & iPkgs & Reset & Bold & lPkgs & c1 & pkgsInfo & "\n"
  )
  buf.add(
    Reset & Bold & "  │ " & c2 & iRam & Reset & Bold & lRam & c2 & ramInfo & "\n"
  )

  buf.add(Reset & Bold & "  ├───────────┤\n")

  buf.add(Reset & Bold & "  │ " & c7 & iColors & Reset & Bold & lColors)
  buf.add(
    c7 & dot & " " & c1 & dot & " " & c2 & dot & " " & c3 & dot & " " & c4 & dot & " " &
      c5 & dot & " " & c6 & dot & " " & c8 & dot & "\n"
  )

  buf.add(Reset & Bold & "  ╰───────────╯\n\n" & Reset)

  stdout.write(buf)
