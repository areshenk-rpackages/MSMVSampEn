---
layout: page
title: "Theory and computation"
category: doc
date: 2020-10-30 12:57:18
mathjax: true
order: 1
---

Sample entropy, like its predecessor, approximate entropy, attempts to provide a computationally tractable quantification of the complexity of a time series. Loosely, it attempts to measure the "unpredictability" of a signal, defined as the degree to which future values of the signal can be predicted from past observations.

The general idea behind the approach is like this: We have a time series $\mathbf{X}$ (often a biological signal -- say, scalp voltage), which we assume is the result of some underlying nonlinear dynamical system (brain activity). This system is high dimensional, but we only observe some unidimensional result of the system (the voltage at a single location). This is clearly not enough to reconstruct the system, but we can, in some sense, "extract" additional dimensions from $\mathbf{X}$ by looking at the change in $\mathbf{X}$ at different time lags, and then "projecting" the result into a higher dimension.

## Sample entropy (SampEn)

For example, the voltage $$x_t$$ at a single time point is 1-dimensional, but we if we take $$m$$ samples at lag $$\tau$$, then we get the $$m$$-dimensional vector $$y^t_{\tau,m} = (x_t,x_{t+\tau},x_{t+2\tau},\dots,x_{t+m\tau})$$. The value $$m$$ is called the embedding dimension, and $$\tau$$ the time lag. We can then ask the question: if two points are similar in embedding dimension $$m$$ (that is, closer than some distance $$r$$), what is the probability that they will remain similar in dimension $$m+1$$? Letting $$A^m(x)$$ be the probability that two points are similar in dimension $$m+1$$, and $$B^m(x)$$ be the probability that two points are similar in dimension $m$, SampEn estimates

$$
\text{SampEn}_{m,\tau,r} = -\ln{\frac{A^m(x)}{B^m(x)}}
$$
    
As an intuition aid, a constant or strictly periodic signal has zero entropy, whereas a signal with no correlation structure (such as white noise) has maximum entropy (what "maximum entropy" is, exactly, depends on the sample size and the parameters of the algorithm). SampEn thus provides a measure of the complexity of the signal.

## Multiscale entropy

Multiscale sample entropy (MSSampEn) is an extension of SampEn that examines the complexity of a time series at different time scales. The most common approach is straightforward: we partition $$\mathbf{X}$$ into bins of length $$\epsilon$$, and then compute the mean of $$\mathbf{X}$$ within each bin, giving a new time series of length $$N/\epsilon$$ (this procedure is called coarse-graining). SampEn can then be computed for various value of $$\epsilon$$, estimating the complexity of $$\mathbf{X}$$ at increasing time scales. Time series which are "locally" unpredictable, but which exhibit "low frequency" structure, might then be expected to show increasing entropy at longer time scales. Conversely, white noise is "scale invariant" in some sense, and so would show constant entropy at any time scale. This is easy to show by setting the similarity threshold $$r$$ at some constant percentage of signal variance, which we can accomplish by scaling the series to have unit variance after coarse-graining. If the raw series is

$$ 
x_t \sim \mathrm{N}(0,1) 
$$

the the coarse-grained series $$\mathbf{y}$$ is

$$
y_t \sim \mathrm{N}\left (0,\frac{1}{\epsilon}\right) 
$$

but after scaling, this is just more white noise, so SampEn is the same. If the series is not scaled after coarse-graining (or $$r$$ is not adapted), then, because coarse-graining reduces signal variance, entropy will decrease monotonically as $$\epsilon$$ increases.

Ahmed, M. U., & Mandic, D. P. (2011). Multivariate multiscale entropy: A tool for complexity analysis of multichannel data. Physical Review E, 84(6), 061918.
