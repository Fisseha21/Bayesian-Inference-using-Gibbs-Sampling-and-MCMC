# Bayesian-Inference-using-Gibbs-sampling-and-MCMC

An experiment consists of performing independent Bernoulli($p$) trials. Suppose the trials yield
$Y$ successes , but the experimenter lost track of the number $N$ of the trials performed. Assume
that $p$ has a Beta($\alpha$, $\beta$) prior distribution, $N|\lambda$ has a Poisson($\lambda$) prior distribution, and $\lambda$ has a Gamma($a$, $b$) hyperprior distribution.
  
1. Write down fully conditional distributions for $p$, $N$, and $\lambda$ and write an **R** code for implementing Gibbs sampling to compute the posterior distributions of these parameters.  
  
2. With $Y = 15$, $\alpha = .2$, $\beta = 4$, $a = .5$, $b = 2$, estimate these parameters using squared error loss function.    
    
3. Repeat the above estimation with loss function  
  
 <div align="center">
    ${1 \over \theta} (\theta - d)^2$
 </div>
 
  
4. A second experiment consisting of independent Bernoulli trials was performed under different
conditions. If $p^{0}\prime$ is the probability of success under these new conditions and $Y^{\prime} = 4$, but the experimenter again failed to record the number of trials, calculate the posterior probability that $p > \sqrt{p^{\prime}}$.
