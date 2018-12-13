# acknowledge Roger Peng's lecture:
# https://www.youtube.com/watch?v=tvv4IA8PEzw
# for much of this material

# you can, and it's worthwhile!

# rnorm() - draw samples from specific probability distributions
# pnorm()
# qnorm()
# dnorm()

# r_, p_, q_, and d_ functions for variety of distributions
# eg. rpois(), dgamma() etc.

rnorm(10)

# set.seed() ensures reproducibility of this process
# generates the same set of pseudo-random numbers

rnorm(10)

set.seed(1)
rnorm(10)
set.seed(1)
rnorm(10)

# for poisson variables mean roughly equal to weight
rpois(10, 1)
rpois(10, 2)
rpois(10, 20)

# let's now simulate a linear model
# y = B0 + B1x + e

B0 <- 0.5
B1 <- 2
x <- rnorm(100) # rain
e <- rnorm(100, 0, 2)
y <- B0 + B1*x + e
summary(y)
plot(x, y)

fit <- lm (y ~ x)
fit

# maybe x is binary
x <- rbinom(100, 1, .5)
y <- B0 + B1*x + e
summary(y)
plot(x, y)

fit <- lm (y ~ x)
fit

# maybe glm with poisson distribution
# y ~ Poisson(mu)
# log(mu) = B0 + B1x
# counts of chenopods

B0 <- .5
B1 <- .3
x <- rnorm(100)
log.mu <- B0 + B1*x
y <- rpois(100, exp(log.mu))
summary(y)
plot(x, y)

fit <- glm (y ~ x)
fit
# wait these don't match! let's look again, we have to exp(B0)

# let's try bringing two variables into our model

B0 <- 0.5
B1 <- 2
B2 <- 3

x1 <- rnorm(120)
x2 <- rbinom(120, 1, .5)
e <- rnorm(120, 0, 2)
y <- B0 + B1*x1 + B2*x2 + e
summary(y)
par(mfrow = c(1, 2))
plot(x1, y)
plot(x2, y)

# write out model 
fit <- lm (y ~ x1 + x2)
fit

# Bayesian!
library(greta)
B0 <- normal(0.5, 2)
B1 <- normal(2, 3)
B2 <- normal(3, 3)
e <- lognormal(0, 3)

mean <- B0 + B1*x1 + B2*x2
distribution(y) <- normal(mean, e)
m <- model(B0, B1, B2, e)
