---
layout: default
title: "About"
---

`MSMVSampEn` is an R package for computing multiscale, multivariate sample entropy of biological signals. A more in-depth discussion of MSMV sample entropy can be found in Ahmed and Mandic (2011), and the the package is a relatively faithfull translation of the author's Matlab code, although several changes have been made for speed and efficiency. 

- The embedding function has been rewritten in C++, for a substantial speedup. 
- The authors estimate B<sup>m</sup>(r) by computing the full distance matrix
for the embedded delay vectors, which can easily exhaust system RAM for even
moderately sized datasets. Instead, MSMVSampEn simply tally the number of vectors lying
within the distance threshold r, sidestepping the distance matrix calculation
entirely. This, too, is implemented in C++.

MSMVSampEn is capable of computing sample entropy for univariate or multivariate signals at arbitrary time scales. Currently, it only implements the coarsegraining procedure described by Ahmed and Mandic, although, as Humeau-Heurtier (2015) points out, this method has serious shortcomings. In the future, I hope to implement more sophisticated methods of extracting informations at larger timescales. 

The package allows for the specification of an arbitrary summary statistic to be used during coarsegraining by passing a function argument to MSMVSampEn(). This function is applied to each bin during coarsegraining. When this function in the mean (default), this gives the usual sample entropy, though, as Humeau-Heurtier mentions, other statistics (such as higher moments), are occasionally interesting.

Ahmed, M. U., & Mandic, D. P. (2011). Multivariate multiscale entropy: A tool for complexity analysis of multichannel data. Physical Review E, 84(6), 061918.

Humeau-Heurtier, A. (2015). The multiscale entropy algorithm and its variants: A review. Entropy, 17(5), 3110-3123.

## Installation
The package can be installed directly from the Gitlab repository using the `devtools` package with

```r
devtools::install_git('https://github.com/areshenk/MSMVSampEn')
```

Alternately, the repository can be cloned to a local machine and installed through the terminal by running

```
R CMD INSTALL MSMVSampEn
```
in the directory containing the folder.
