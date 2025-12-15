import std/os

proc getPortagePkgs*(): string =
  const dbPath = "/var/db/pkg"
  if not dirExists(dbPath):
    return "0"

  var count = 0
  try:
    for kind, path in walkDir(dbPath, relative = true):
      if kind == pcDir:
        let catPath = dbPath / path
        for k, _ in walkDir(catPath, relative = true):
          if k == pcDir:
            inc count
  except CatchableError:
    return "0"

  return $count
