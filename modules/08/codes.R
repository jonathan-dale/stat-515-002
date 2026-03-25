### Example: Boston Data set cts...

library(MASS)
data(Boston)

library(psych)

pairs.panels(Boston)

fit = lm(medv~., data=Boston)

summary(fit)


##################
### Example: Advertising Data set Cts...

ad = read.csv("Advertising.csv")
ad = ad[-1]

fit1 = lm(Sales~TV, data=ad);
fit2 = lm(Sales~TV+Radio+Newspaper, data=ad);
anova(fit1, fit2)


##############
### Example: Carseats dataset

library(ISLR2)
data(Carseats)

m1 = lm(Sales~US, data= Carseats)
summary(m1)

m2 = lm(Sales~ShelveLoc, data=Carseats)
summary(m2)

contrasts(Carseats$ShelveLoc)

############################
### Example: Advertising Data set Cts...

fit1 = lm(Sales~TV+Radio, data=ad);summary(fit1)

#Method 1 (add all variables manually)
fit2 = lm(Sales~TV+Radio+TV*Radio, data=ad);summary(fit2)

#Method 2 (Only include the interaction term)
fit3 = lm(Sales~TV:Radio, data=ad);summary(fit3)

#Method 3 (includes main effects and interaction)
fit4 = lm(Sales~TV*Radio, data=ad);summary(fit4)

###############
### Example: Boston Data set Cts...

fit1 = lm(medv~lstat, data=Boston); summary(fit1);

#model with quadratic term
fit2 = lm(medv~lstat+I(lstat^2), data=Boston); summary(fit2);

#since these are nested model we can perform a partial F-test

anova(fit1, fit2) #fit2 is better than fit1 and also check with the Adj. R^2

fit3 = lm(medv~poly(lstat, 5), data=Boston); summary(fit3);
anova(fit2,fit3)

fit4 = lm(medv~log(lstat), data=Boston); summary(fit4)

### Example: Boston Data set Cts...

fit = lm(medv~., data=Boston)
summary(fit)

par(mfrow=c(2,2))
plot(fit)

library(car)
vif(fit)


fit = lm(medv~.-rad, data=Boston)
summary(fit)

vif(fit)



















