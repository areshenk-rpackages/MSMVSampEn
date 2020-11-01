#include <RcppArmadillo.h>
// [[Rcpp::depends(RcppArmadillo)]]

using namespace Rcpp;

// [[Rcpp::export]]
int similarityCount(NumericMatrix mat, double r) {

    int m = mat.nrow(),
        n = mat.ncol();

    // Initialize count
    int count = 0;

    for (int i = 0; i < m; i++) {
       for (int j = 0; j < i; j++) {
           NumericVector diff = abs(mat.row(i) - mat.row(j));
           if (max(diff) < r)
                count++;
       }
   }
    return count;
}
