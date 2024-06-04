func argParser*(args: seq[string], argCount: int): int =
  const argsList: array[0..3, string] = ["-h", "--help", "-v", "--version"]

  if argCount == 0:
    return 0
  elif args[0] in argsList[0 .. 1]:
    return 1
  elif args[0] in argsList[2 .. 3]:
    return 2
  else:
    return 0