# Package

version       = "0.2.0"
author        = "gabrielcapilla"
description   = "System fetch in nim lang"
license       = "MIT"
srcDir        = "src"
bin           = @["nitch"]

# Dependencies

requires "nim >= 2.2.4"

# Tasks

task opt, "Build optimized for speed":
  exec "nim c -d:release --opt:speed --passC:-O3 --passC:-march=native --passC:-flto --passL:-flto --mm:orc --tlsEmulation:off -o:nitch src/nitch.nim"

task ult, "Build optimized for maximum speed":
  exec "nim c -d:release -d:danger --opt:speed --passC:-O3 --passC:-march=native --passC:-flto --passL:-flto --passC:-ffast-math --mm:orc --tlsEmulation:off -o:nitch src/nitch.nim"

task benchmark, "Run performance benchmark":
  exec "nim r tools/benchmark.nim"
