Rprof(tmp <- tempfile())
best("WA", "heart attack")
Rprof()
summaryRprof(tmp)
unlink(tmp)


