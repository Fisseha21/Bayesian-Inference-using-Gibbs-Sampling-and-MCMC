#Problem 1 and 2
Y <- 15
alpha <- 0.2
beta <- 4
a <- 0.5
b <- 2
k <- 20000
T <- 10000 # burn in


N <- 35

my_mat <- matrix(data = (k*3)*NA, nrow = k, ncol = 3)
colnames(my_mat) <-  c("p", "lambda", "N")

for (i in 1:k) {
  p <- rbeta(1, shape1 = Y + alpha, shape2 = N - Y + beta)
  l <- rgamma(1, shape = N + a, rate = b + 1)
  N <- rpois(1, l*(1-p)) + Y
  
  
  my_mat[i, ] <- c(p,l,N)
  
}

iter_p <- my_mat[, 1][-(1:T)]
iter_l <- my_mat[, 2][-(1:T)]
iter_N <- my_mat[, 3][-(1:T)]


pander(matrix(data = c(round(mean(iter_p), 3), round(mean(iter_l), 3), as.integer(mean(iter_N))),
              nrow = 1, ncol = 3, dimnames = list("Bayes Estimate", c("p", "lambda", "N"))))

par(mfrow = c(3,1))
trace.plot(t(my_mat), BurnIn = 10000)

par(mfrow = c(1, 3))
hist(iter_p, xlab = 'Samples', main = 'Histogram of p')
hist(iter_l, xlab = 'Samples', main = 'Histogram of l')
hist(iter_N, xlab = 'Samples', main = 'Histogram of N')

#Problem 3
samp_p <- c() # empty vector for p
samp_l <- c() # empty vector for lambda
samp_N <- c() # empty vector for N

for (i in 1:1000) { # get lagged samples by 10
  samp_p[i] <- iter_p[10*i] 
  samp_l[i] <- iter_l[10*i]
  samp_N[i] <- iter_N[10*i]
}

w_bayes <- function(theta){ # function for wighted loss estimates
  1/(sum(1/theta)/length(theta))
}

w_p <- w_bayes(samp_p) # p
w_l <- w_bayes(samp_l) # lambda
w_N <- w_bayes(samp_N) # N

pander(matrix(data = c(round(w_p, 3), round(w_l, 3), as.integer(w_N)),
              nrow = 1, ncol = 3, dimnames = list("Weighted Bayes Estimate", c("p", "lambda", "N"))))


#Problem 4
Y_prime <- 4

N <- 10
k <- 20000

my_mat2 <- matrix(data = (k*3)*NA, nrow = k, ncol = 3)
colnames(my_mat2) <-  c("p", "lambda", "N")

for (i in 1:k) {
  p <- rbeta(1, shape1 = Y_prime + alpha, shape2 = N - Y_prime + beta)
  l <- rgamma(1, shape = N + a, rate = b + 1)
  N <- rpois(1, l*(1-p)) + Y_prime
  
  
  my_mat2[i, ] <- c(p,l,N)
  
}

iter_p2 <- my_mat2[, 1][-(1:T)]
iter_l2 <- my_mat2[, 2][-(1:T)]
iter_N2 <- my_mat2[, 3][-(1:T)]

samp_p2 <- c()
samp_l2 <- c()
samp_N2 <- c()

for (i in 1:1000) {
  samp_p2[i] <- iter_p2[10*i]
  samp_l2[i] <- iter_l2[10*i]
  samp_N2[i] <- iter_N2[10*i]
}

I <- c()

for (i in 1:1000) {
  if(samp_p[i] > sqrt(samp_p2[i])){
    I[i] <- 1
  } else {
    I[i] <- 0
  }
}

prob <- sum(I)/length(I)

trace.plot(t(my_mat2), BurnIn = 10000)

par(mfrow = c(1, 3))
hist(iter_p2, xlab = 'Samples', main = 'Histogram of p`')
hist(iter_l2, xlab = 'Samples', main = 'Histogram of lambda`')
hist(iter_N2, xlab = 'Samples', main = 'Histogram of N`')