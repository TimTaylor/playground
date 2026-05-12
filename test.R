f <- tempfile()
if (!dir.create(f))
    stop("Unable to create temporary directory for integration test")
files <- list.files("tests", full.names = TRUE)
if (!all(file.copy(files, f)))
    stop("Copying test files failed.")
expected <- readRDS("tests/out.rds")

od <- setwd(f)
tryCatch(
    expr = {
        source("out.R")
        if (!isTRUE(all.equal(out, 1))) {
            stop("Integration test failed.")
        }
    },
    finally = setwd(od)
)


