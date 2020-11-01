#' Multivariate sample entropy
#'
#' Function computes the multivariate sample entropy of a signal
#'
#' @param mat A pxn numeric matrix containing a p-variate time series.
#' @param M A vector of length p specifying the embedding dimension.
#' @param tau A vector of length p specifying the time lag parameter.
#' @param r The similarity threshold.
#' @param scale If TRUE (default), standardizes the rows of mat.
#' @export

MVSampEn <- function(mat, M, tau, r, scale = TRUE){

  # Error Handling
  if (!is.matrix(mat))
    stop('mat must be a matrix')

  if (!(is.numeric(M) && length(M) == nrows(mat) || length(M) == 1))
    stop('M must be a scalar, or a vector of length equal to the rows of mat')
  if (length(M) == 1)
    M <- rep(M, nrows(mat))

  if (any(M <= 0))
    stop('M must be positive')

  if (!(is.numeric(tau) && length(tau) == nrows(mat) || length(tau) == 1))
    stop('tau must be a scalar, or a vector of length equal to the rows of mat')
  if (length(tau) == 1)
    tau <- rep(tau, nrows(mat))

  if (any(tau <= 0))
    stop('tau must be positive')

  # Scale data if necessary
  if (scale) mat <- t(scale(t(mat)))

  nVariables <- dim(mat)[1]
  nSamples   <- dim(mat)[2]

  MMax   <- max(M)
  tauMax <- max(tau)
  nn     <- MMax * tauMax

  # Count the number of match templates of length m closed within
  # the tolerance r.
  N  <- nSamples - nn
  A  <- vectorEmbed(mat, M, tau)
  v1 <- similarityCount(A, r)
  p1 <- 2 * v1 / (N * (N-1))

  # Error checking
  if (p1 == 0)
    return(NA)

  I  <- diag(rep(1, nVariables))
  M2 <- matrix(rep(M, nVariables), nrow = nVariables, byrow = T) + I
  B <- do.call(rbind, lapply(1:nVariables, function(i)
    vectorEmbed(mat, M2[i,], tau)))

  v2 <- similarityCount(B, r)
  p2 <- 2 * v2 / (nVariables * N * (nVariables * N-1))

  # Error checking
  if (p2 == 0)
    return(NA)

  return(log(p1) - log(p2))

}
