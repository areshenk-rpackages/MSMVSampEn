#' Multiscale multivariate sample entropy
#'
#' Wrapper for MVSampEn that allows the user to specify an integer scale
#' parameter eps. The time series is coarsegrained, and then the entropy is
#' computed for the specified time scale. Currently being tested, and is not exported.
#'
#' @param mat A pxn numeric matrix containing a p-variate time series.
#' @param M A vector of length p specifying the embedding dimension.
#' @param tau A vector of length p specifying the time lag parameter.
#' @param r The similarity threshold.
#' @param eps An integer specifying the time scale.
#' @param scale If TRUE (default), standardizes the rows of mat.
#' @param fun Function applied to each bin, passed to coarsegrain (default = mean).
#' @param ... Other arguments passed to fun.

MSMVDiffEn = function(mat, M, tau, eps = 1, breaks = 100,
                      scaleMat = TRUE, fun = mean, ...){

    X <- coarsegrainMultivariate(mat, eps, fun, ...)
    return(MVDiffEn(X, M, tau, breaks, scaleMat))
}
