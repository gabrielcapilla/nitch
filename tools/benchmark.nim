import std/[os, osproc, times, strformat]

type BenchmarkResult = object
  totalTime: float
  avgTime: float
  minTime: float
  maxTime: float
  iterations: int

proc timeExecution*(exe: string, iterations: int): BenchmarkResult =
  var times: seq[float] = @[]
  times.setLen(iterations)

  for i in 0 ..< iterations:
    let startTime: float = cpuTime()
    discard execCmd(exe & " > /dev/null 2>&1")
    let endTime: float = cpuTime()
    times[i] = endTime - startTime

  result.totalTime = 0.0
  result.minTime = float.high
  result.maxTime = float.low

  for t in times:
    result.totalTime += t
    if t < result.minTime:
      result.minTime = t
    if t > result.maxTime:
      result.maxTime = t

  result.avgTime = result.totalTime / float(iterations)
  result.iterations = iterations

proc printResult(name: string, result: BenchmarkResult) =
  stdout.write &"{name:<12} | {result.totalTime:>10.6f}s | {result.avgTime*1000000:>9.2f}μs | {result.minTime*1000000:>9.2f}μs | {result.maxTime*1000000:>9.2f}μs\n"

proc main() =
  stdout.write "Performance benchmark for different nitch compilation versions\n"
  stdout.write "=============================================================\n\n"

  stdout.write "Cleaning previous files...\n"
  try:
    removeFile("nitch")
  except OSError:
    discard

  stdout.write "Compiling versions...\n"

  if execCmd("nimble build > /dev/null 2>&1") != 0:
    quit("Error compiling normal version")
  moveFile("nitch", "nitch_normal")

  try:
    removeFile("nitch")
  except OSError:
    discard
  if execCmd("nimble build -d:release > /dev/null 2>&1") != 0:
    quit("Error compiling release version")
  moveFile("nitch", "nitch_release")

  try:
    removeFile("nitch")
  except OSError:
    discard
  if execCmd("nimble opt > /dev/null 2>&1") != 0:
    quit("Error compiling opt version")
  moveFile("nitch", "nitch_opt")

  try:
    removeFile("nitch")
  except OSError:
    discard
  if execCmd("nimble ult > /dev/null 2>&1") != 0:
    quit("Error compiling ult version")
  moveFile("nitch", "nitch_ult")

  stdout.write "Running benchmarks (50 iterations each)...\n\n"

  const iterations: int = 50
  let
    normalResult: BenchmarkResult = timeExecution("./nitch_normal", iterations)
    releaseResult: BenchmarkResult = timeExecution("./nitch_release", iterations)
    optResult: BenchmarkResult = timeExecution("./nitch_opt", iterations)
    ultResult: BenchmarkResult = timeExecution("./nitch_ult", iterations)

  stdout.write "Version      | Total Time  | Average     | Min         | Max       \n"
  stdout.write "-------------|-------------|-------------|-------------|-----------\n"

  printResult("normal", normalResult)
  printResult("release", releaseResult)
  printResult("opt", optResult)
  printResult("ult", ultResult)

  stdout.write "\n"

  var results: array[0 .. 3, (string, float)] = [
    ("normal", normalResult.avgTime),
    ("release", releaseResult.avgTime),
    ("opt", optResult.avgTime),
    ("ult", ultResult.avgTime),
  ]

  var
    fastest: (string, float) = results[0]
    slowest: (string, float) = results[0]

  for r in results:
    if r[1] < fastest[1]:
      fastest = r
    if r[1] > slowest[1]:
      slowest = r

  stdout.write &"Fastest version: {fastest[0]} (average: {fastest[1]*1000000:.2f}μs)\n"
  stdout.write &"Slowest version: {slowest[0]} (average: {slowest[1]*1000000:.2f}μs)\n"
  stdout.write &"Improvement from {slowest[0]} to {fastest[0]}: {(slowest[1]/fastest[1])*100.0:.2f}% faster\n"

  stdout.write "\nBinary sizes:\n"
  let sizes: array[0 .. 3, (string, BiggestInt)] = [
    ("normal", getFileSize("nitch_normal")),
    ("release", getFileSize("nitch_release")),
    ("opt", getFileSize("nitch_opt")),
    ("ult", getFileSize("nitch_ult")),
  ]
  for (name, size) in sizes:
    stdout.write &"{name:<11}: {size:>7} bytes\n"

  stdout.write "\nSystem optimization...\n"
  stdout.write "Removing slower versions...\n"

  for (name, _) in sizes:
    if name != fastest[0]:
      let filename: string = &"nitch_{name}"
      try:
        removeFile(filename)
        stdout.write &"  - Removed: {filename}\n"
      except OSError:
        stdout.write &"  - Could not remove {filename} (possibly already removed)\n"

  let finalName: string = &"nitch_{fastest[0]}"
  moveFile(finalName, "nitch")
  stdout.write &"  - Kept: nitch (from {finalName})\n"
  stdout.write "\nOptimization completed! The system now contains only the fastest version.\n"

when isMainModule:
  main()
