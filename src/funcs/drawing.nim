import std/terminal
import
  ../nitches/[
    getUser, getHostname, getDistro, getKernel, getUptime, getShell, getPkgs, getRam,
    getLogo, getLogoColor, getDistroId,
  ]

proc drawInfo*(showLogo: bool = true) =
  let distroId: string = getDistroId()

  let
    logoColor: ForegroundColor = getLogoColor(distroId)
    defaultLogo: string =
      if showLogo:
        getLogo(distroId)
      else:
        ""

  const
    userIcon: string = "󰀄 "
    hnameIcon: string = "󰁥 "
    distroIcon: string = "󰌽 "
    kernelIcon: string = "󰌢 "
    uptimeIcon: string = "󰅐 "
    shellIcon: string = "󰆍 "
    pkgsIcon: string = "󰏖 "
    ramIcon: string = "󰍛 "
    colorsIcon: string = "󱥚 "
    dotIcon: string = ""

    userCat: string = " user   │ "
    hnameCat: string = " hname  │ "
    distroCat: string = " distro │ "
    kernelCat: string = " kernel │ "
    uptimeCat: string = " uptime │ "
    shellCat: string = " shell  │ "
    pkgsCat: string = " pkgs   │ "
    ramCat: string = " memory │ "
    colorsCat: string = " colors │ "

    color1: ForegroundColor = fgRed
    color2: ForegroundColor = fgYellow
    color3: ForegroundColor = fgGreen
    color4: ForegroundColor = fgCyan
    color5: ForegroundColor = fgBlue
    color6: ForegroundColor = fgMagenta
    color7: ForegroundColor = fgWhite
    color8: ForegroundColor = fgBlack
    color0: ForegroundColor = fgDefault

  let
    userInfo: string = getUser()
    hostnameInfo: string = getHostname()
    distroInfo: string = getDistro()
    kernelInfo: string = getKernel()
    uptimeInfo: string = getUptime()
    shellInfo: string = getShell()
    pkgsInfo: string = getPkgs(distroId)
    ramInfo: string = getRam()

  if showLogo:
    stdout.styledWrite(styleBright, logoColor, defaultLogo)
    stdout.styledWrite(styleBright, "  ╭───────────╮\n")
  else:
    stdout.styledWrite(styleBright, "  ╭───────────╮\n")

  stdout.styledWrite(
    styleBright, "  │ ", color1, userIcon, color0, userCat, color1, userInfo, "\n"
  )
  stdout.styledWrite(
    styleBright, "  │ ", color2, hnameIcon, color0, hnameCat, color2, hostnameInfo,
    "\n",
  )
  stdout.styledWrite(
    styleBright, "  │ ", color3, distroIcon, color0, distroCat, color3, distroInfo,
    "\n",
  )
  stdout.styledWrite(
    styleBright, "  │ ", color4, kernelIcon, color0, kernelCat, color4, kernelInfo,
    "\n",
  )
  stdout.styledWrite(
    styleBright, "  │ ", color5, uptimeIcon, color0, uptimeCat, color5, uptimeInfo,
    "\n",
  )
  stdout.styledWrite(
    styleBright, "  │ ", color6, shellIcon, color0, shellCat, color6, shellInfo, "\n"
  )
  stdout.styledWrite(
    styleBright, "  │ ", color1, pkgsIcon, color0, pkgsCat, color1, pkgsInfo, "\n"
  )
  stdout.styledWrite(
    styleBright, "  │ ", color2, ramIcon, color0, ramCat, fgYellow, ramInfo, "\n"
  )
  stdout.styledWrite(styleBright, "  ├───────────┤\n")
  stdout.styledWrite(
    styleBright, "  │ ", color7, colorsIcon, color0, colorsCat, color7, dotIcon, " ",
    color1, dotIcon, " ", color2, dotIcon, " ", color3, dotIcon, " ", color4, dotIcon,
    " ", color5, dotIcon, " ", color6, dotIcon, " ", color8, dotIcon, "\n",
  )
  stdout.styledWrite(styleBright, "  ╰───────────╯\n\n")
