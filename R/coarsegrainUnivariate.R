#' Coarsegrain a univariate signal
#'
#' Function coarsegrains a univariate signal by partitioning the signal into bins
#' of length eps, and then applying a function (by default, the mean) to each bin.
#'
#' @param x A numeric vector.
#' @param eps The bin size.
#' @param fun The function to apply to each bun (default = mean).
#' @param ... Other arguments passed to fun.
#' @importFrom zoo rollapply
#' @export

coarsegrainUnivariate <- function(x, eps, fun = mean, ...){
    n <- length(x)
    r <- n %% eps
    x <- x[1:(n-r)]
    return(rollapply(x, width = eps, FUN = fun, ..., by = eps))
}
