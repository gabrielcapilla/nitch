import std/[os, osproc, times, strformat, monotimes]

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
    let startTime = getMonoTime()
    discard execCmd(exe & " > /dev/null 2>&1")
    let endTime = getMonoTime()
    times[i] = float((endTime - startTime).inNanoseconds) / 1_000_000_000.0

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
  stdout.write &"{name:<20} | {result.totalTime:>10.6f}s | {result.avgTime*1000000:>9.2f}μs | {result.minTime*1000000:>9.2f}μs | {result.maxTime*1000000:>9.2f}μs\n"

proc main() =
  for f in ["nitch", "nitch_debug", "nitch_standard", "nitch_optimized"]:
    try:
      removeFile(f)
    except OSError:
      discard

  stdout.write "[1/3] Compiling Debug version (nimble build)...\n"
  if execCmd("nimble build > /dev/null 2>&1") != 0:
    quit("Error compiling debug version")
  moveFile("nitch", "nitch_debug")

  stdout.write "[2/3] Compiling Standard version (nimble build -d:release)...\n"
  if execCmd("nimble build -d:release > /dev/null 2>&1") != 0:
    quit("Error compiling standard release version")
  moveFile("nitch", "nitch_standard")

  stdout.write "[3/3] Compiling Optimized version (nimble release)...\n"
  if execCmd("nimble release > /dev/null 2>&1") != 0:
    quit("Error compiling optimized release version")
  moveFile("nitch", "nitch_optimized")

  stdout.write "\nRunning benchmark\n\n"

  const iterations: int = 50
  let
    resDebug = timeExecution("./nitch_debug", iterations)
    resStandard = timeExecution("./nitch_standard", iterations)
    resOptimized = timeExecution("./nitch_optimized", iterations)

  stdout.write "Variant              | Total Time  | Average     | Min         | Max       \n"
  stdout.write "---------------------|-------------|-------------|-------------|-----------\n"

  printResult("Debug", resDebug)
  printResult("Standard (-d:release)", resStandard)
  printResult("Optimized (Custom)", resOptimized)

  stdout.write "\n"

  var results: array[0 .. 2, (string, float)] = [
    ("debug", resDebug.avgTime),
    ("standard", resStandard.avgTime),
    ("optimized", resOptimized.avgTime),
  ]

  var
    fastest = results[0]
    slowest = results[0]

  for r in results:
    if r[1] < fastest[1]:
      fastest = r
    if r[1] > slowest[1]:
      slowest = r

  stdout.write &"Fastest variant: {fastest[0]} (avg: {fastest[1]*1000000:.2f}μs)\n"
  stdout.write &"Slowest variant: {slowest[0]} (avg: {slowest[1]*1000000:.2f}μs)\n"
  stdout.write &"Improvement: {(slowest[1]/fastest[1])*100.0:.2f}% faster\n"

  stdout.write "\nBinary sizes:\n"
  let sizes: array[0 .. 2, (string, BiggestInt)] = [
    ("debug", getFileSize("nitch_debug")),
    ("standard", getFileSize("nitch_standard")),
    ("optimized", getFileSize("nitch_optimized")),
  ]
  for (name, size) in sizes:
    stdout.write &"{name:<10}: {size:>7} bytes\n"

  stdout.write "\nSystem optimization...\n"
  stdout.write "Cleaning up...\n"

  for (name, _) in sizes:
    let filename = &"nitch_{name}"
    if name != fastest[0]:
      try:
        removeFile(filename)
        stdout.write &"  - Removed: {filename}\n"
      except OSError:
        stdout.write &"  - Error removing {filename}\n"
    else:
      moveFile(filename, "nitch")
      stdout.write &"  - Kept: nitch (renamed from {filename})\n"

  stdout.write "\nDone! The 'nitch' binary is now the fastest version.\n"

when isMainModule:
  main()
