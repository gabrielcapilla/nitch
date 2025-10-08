import ./drawing
import ../assets/assets

proc showFetch*() =
  drawInfo(showLogo = true)

proc showHelp*() =
  stdout.write(helpMsg)

proc showVersion*() =
  stdout.write(programVersion)

proc showFetchNoLogo*() =
  drawInfo(showLogo = false)
