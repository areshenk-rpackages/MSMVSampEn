#include <RcppArmadillo.h>
// [[Rcpp::depends("RcppArmadillo")]]

using namespace Rcpp;

// [[Rcpp::export]]
NumericMatrix vectorEmbed(NumericMatrix mat, NumericVector M, NumericVector tau) {

    int m = mat.nrow(),
        n = mat.ncol();

    NumericMatrix A(n - max(M)*max(tau), sum(M));
    int offset = 0;

    for (int j = 0; j < m; j++) {
        for (int i = 0; i < n - max(M)*max(tau); i++) {
            for (int k = 0; k < M(j); k++){
                A(i,offset + k) = mat(j, i + k * tau(j));
            }
        }
        offset = offset + M(j);
   }
    return A;
}
