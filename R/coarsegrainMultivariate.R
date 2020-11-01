#' Coarsegrain a multivariate signal
#'
#' Function coarsegrains a multivariate signal by partitioning the signal into bins
#' of length eps, and then applying a function (by default, the mean) to each bin.
#'
#' @param x A numeric matrix with dimensions source x time.
#' @param eps The bin size.
#' @param fun The function to apply to each bun (default = mean).
#' @param ... Other arguments passed to fun.
#' @export

coarsegrainMultivariate = function(mat, eps, fun = mean, ...){
    return(t(apply(mat, 1, function(x) coarsegrainUnivariate(x, eps, fun, ...))))
}
