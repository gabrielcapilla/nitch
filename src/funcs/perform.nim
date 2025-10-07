import ./drawing
import ../assets/assets

proc arg0*() =
  drawInfo(showLogo = true)

proc arg3*() =
  drawInfo(showLogo = false)

proc arg1*() =
  stdout.write(helpMsg)

proc arg2*() =
  stdout.write(programVersion)
