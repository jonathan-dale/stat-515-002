#### Example 1:

aptitude = c(95,85,80,70,60)
math = c(85,95,70,65,70)

plot(math~aptitude)

cor(aptitude,math) #correlation coefficient


fit1 = lm(math~aptitude) #fitting a linear model
fit1

plot(math~aptitude)
abline(fit1)

plot(math~aptitude)
abline(fit1)

#### Example 2:

set.seed(10)

x = runif(100) #generating data
y = rnorm(x)

data= data.frame(x,y)

plot(y~x)

cor(x,y) # correlation

cor.test(x,y, alternative = 'two.sided')
fit2 = lm(y~x) #regression fit
summary(fit2)



plot(y~x)
abline(fit2)


## Example: Boston Housing Data


library(MASS)

?Boston
data(Boston)

plot(Boston$medv~Boston$lstat)
abline(fit)

cor(Boston$medv,Boston$lstat) #correlation coefficient

fit = lm(medv~., data=Boston);
fit

summary(fit)

confint(fit) # by default 95% CI

confint(fit, level =0.99 ) # 99% CI

library(ggplot2)

(ggplot(Boston,aes(x = lstat,y = medv)) +
    geom_point(shape = 21,fill = "red",
               color = "black",size = 2) +
    stat_smooth(method = lm,
                color = "blue",fill = "cyan") +
    labs(
      x = "Lower Status Percent of Population",
      y = "Median House Value ($1000)",
      title = "Boston Housing Data"))


###############
x <- c(95,85,80,70,60)
y <- c(85,95,70,65,70)

cor(x,y) # correlation

m1 = lm(y~x)
summary(m1)

cor(x,y)^2 #squared correlation
##############################

## Example: Boston Housing Data: Cts...

### calculating errors

rss = sum(fit$residuals^2) # residual sum of squares

rse = sqrt(rss/fit$df.residual) # residual standard error

mse = mean(fit$residuals^2) # mean square error

rmse = sqrt(mse) # root mean square error


rbind(paste0('RSS=',round(rss,4)),
      paste0('RSE=',round(rse,4)),
      paste0('MSE=',round(mse,4)),
      paste0('RMSE=',round(rmse,4)))


predict(fit, data.frame(lstat=c(5,10,15)))

#Confidence Interval
predict(fit, data.frame(lstat=c(5,10,15)), interval="confidence")

#Prediction Interval
predict(fit, data.frame(lstat=c(5,10,15)), interval="prediction")


## Example: Advertising data

ad = read.csv("Week 8/Advertising.csv")
ad = ad[-1]

pairs(ad)

cor(ad$Sales,ad$TV)
cor(ad$Sales,ad$Radio)

m1 = lm(Sales~TV, data =ad)
m2 = lm(Sales~Radio, data =ad)

summary(m1)
summary(m2)
