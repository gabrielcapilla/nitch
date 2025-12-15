# Package

version = "0.2.1"
author = "gabrielcapilla"
description = "System fetch in nim lang"
license = "MIT"
srcDir = "src"
bin = @["nitch"]

# Dependencies

requires "nim >= 2.2.6"

# Tasks

task release, "Build optimized for maximum speed (Danger + LTO + Strip)":
  exec "nim c -d:release -d:danger --panics:on -d:lto --opt:speed --passC:-O3 --passC:-march=native --passC:-fno-plt --passC:-ffast-math --passL:-s --mm:orc --tlsEmulation:off -o:nitch src/nitch.nim"

task benchmark, "Run performance benchmark":
  exec "nim r tools/benchmark.nim"
