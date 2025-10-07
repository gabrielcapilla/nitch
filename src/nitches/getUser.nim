import std/os

func getUser*(): string =
  try:
    let user: string = getEnv("USER")
    result = if user.len > 0: user else: "unknown"
  except:
    result = "unknown"
