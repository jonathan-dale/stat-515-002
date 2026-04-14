############### R Lab: subset selection, ridge ###############
### The Hitters data will be used in this lab #####

# We wish to predict a baseball players Salary on the basis of
# various statistics associated with performance in the previous year.


library(ISLR)
names(Hitters)

data("Hitters")
View(Hitters)
?Hitters # description about the dataset

# First of all, we note that the Salary variable is missing for 
#some of the players

sum(is.na(Hitters$Salary))
Hitters=na.omit(Hitters) # removing rows with missing values

sum(is.na(Hitters))
n = nrow(Hitters); n; # sample size



################### Subset Selection #######################
######### Best Subset Selection ########

# The regsubsets() function (part of the leaps library) performs best subset selection
# by identifying the best model that contains a given number of predictors,
# where best is quantified using RSS.

library(leaps)

regfit.full=regsubsets(Salary~.,Hitters) 
summary(regfit.full)
# An asterisk indicates that a given variable is included in the corresponding model
# by default regsubsets() only do up to best 8-variable model


# the nvmax option can be used in order to return as many variables as are desired.
regfit.full=regsubsets(Salary~.,data=Hitters ,nvmax=19)
(reg.summary=summary(regfit.full))

names(reg.summary)# returns R2, RSS, adjusted R2, Cp, and BIC.


# We can examine these to try to select the best overall model
reg.summary$rsq # R2 statistic increases monotonically as more variables are included.
which.max(reg.summary$rsq)


which.min(reg.summary$rss) ## identify the location of the minimum RSS

which.max(reg.summary$adjr2) ## identify the location of the maximum Adj. R_sq

which.min(reg.summary$cp) ## identify the location of the minimum Cp
which.min(reg.summary$bic) ## identify the location of the minimum BIC

# Plot RSS, adjusted R2, Cp, and BIC for all of the models at once

par(mfrow=c(2,2)) # dividing the plot in to 4 parts

plot(reg.summary$rss ,xlab="Number of Variables ",ylab="RSS",
     type="l")
points(which.min(reg.summary$rss),min(reg.summary$rss), col="red",cex=2,pch=20)


plot(reg.summary$adjr2 ,xlab="Number of Variables ",
     ylab="Adjusted RSq",type="l")
points(which.max(reg.summary$adjr2),max(reg.summary$adjr2), col="red",cex=2,pch=20)



plot(reg.summary$cp ,xlab="Number of Variables ",ylab="Cp", type="l")
points(which.min(reg.summary$cp ),min(reg.summary$cp),col="red",cex=2,pch=20)



plot(reg.summary$bic ,xlab="Number of Variables ",ylab="BIC",type="l")
points(which.min(reg.summary$bic),min(reg.summary$bic),col="red",cex=2,pch=20)

# The regsubsets() function has a built-in plot() command which can be used
# to display the selected variables for the best model with a given number
# of predictors, ranked according to the BIC, Cp, adjusted R2, or AIC.
# To find out more about this function, type ?plot.regsubsets.

plot(regfit.full,scale="r2")
plot(regfit.full,scale="adjr2")
plot(regfit.full,scale="Cp")
plot(regfit.full,scale="bic")


# The top row of each plot contains a black square for each variable
# selected according to the optimal model associated with that statistic.
dev.off() # clear the plot space

#According to lowest BIC it selects the model with 6 parameters
coef(regfit.full ,10) #see the coefficient estimates for the 6-variable model




####### Forward and Backward Stepwise Selection #######

# using the argument method="forward" or method="backward".
regfit.fwd=regsubsets(Salary~.,data=Hitters,nvmax=19, method ="forward")
summary(regfit.fwd)
# we see that using forward stepwise selection, the best one-variable model
# contains only CRBI, and the best two-variable model additionally includes Hits.
# seqrep for mixed selection

regfit.bwd=regsubsets(Salary~.,data=Hitters,nvmax=19, method ="backward")
summary(regfit.bwd)

# For this data, the best one-variable through six-variable models
# are each identical for best subset and forward selection.

# However, they have different best seven-variable models.
coef(regfit.full ,7)
coef(regfit.fwd ,7)
coef(regfit.bwd ,7)




## Choosing Among Models Using the Validation Set Approach and Cross-Validation

##up-to this point we used full data set to fit the model. Now we divide the data into training and testing data sets.



######### Validation Set Approach: ########

set.seed (1) # reproducibility 

train=sample(c(TRUE,FALSE), nrow(Hitters),rep=TRUE)
test=(!train);

# apply best subset selection to the training set 
regfit.best=regsubsets(Salary~.,data=Hitters[train,], nvmax =19)
summary(regfit.best)
# make a model matrix from the test data.
# The model.matrix() function is used in many regression packages for building an 'X' matrix from data. 
test.mat=model.matrix(Salary~.,data=Hitters[test,])


# Now we run a loop, and for each size i, we extract the coefficients 
# from regfit.best for the best model of that size,
# multiply them into the appropriate columns of the test model matrix 
# to form the predictions, and compute the test MSE. 

(val.errors=rep(NA,19)) # Creating a place holder

for(i in 1:19){
  coefi=coef(regfit.best,id=i)
  pred=test.mat[,names(coefi)]%*%coefi
  val.errors[i]=mean((Hitters$Salary[test]-pred)^2)
}
# The best model is the one that contains 7 variables.
val.errors; which.min(val.errors);
coef(regfit.best ,10); # This is based on testing data.


# there is no predict() method for regsubsets().
# Since we will be using this function again,
# we can capture our steps above and write our own predict method.

predict.regsubsets = function(object, newdata, id, ...){
  form=as.formula(object$call[[2]])
  mat=model.matrix(form, newdata)
  coefi=coef(object, id=id)
  xvars=names(coefi)
  mat[,xvars]%*%coefi
}

# We will demonstrate how we use this function below, when we do cross-validation.

# Obtain the final model using the full data.
# the best 7-variable model on the full data set might have different set of variables
# than the best 7-variable model on the training set.
regfit.best=regsubsets(Salary~.,data=Hitters ,nvmax=19)
coef(regfit.best, 7)



######### Cross-Validation Approach ########
# create a vector that allocates each observation to one of k = 10 folds,
# and we create a matrix in which we will store the results.

k=10 #10- fold cross validation

set.seed(1)

(folds=sample(1:k,nrow(Hitters),replace=TRUE))
cv.errors=matrix(NA,k,19, dimnames=list(NULL, paste(1:19))) # Place holder for errors

# write a for loop that performs cross-validation
for(j in 1:k){
  best.fit=regsubsets(Salary~., data=Hitters[folds!=j,], nvmax=19)
  
  for(i in 1:19){
    pred = predict(best.fit, Hitters[folds==j,], id=i)
    cv.errors[j,i] = mean( (Hitters$Salary[folds==j]-pred)^2 )
  }
}


# This has given us a 10x19 matrix, of which the (i,j)th element corresponds
# to the test MSE for the ith cross-validation fold for the best j-variable model.

mean.cv.errors=apply(cv.errors, 2, mean)# Column average
which.min(mean.cv.errors)

par(mfrow=c(1,1))
plot(mean.cv.errors ,type="b") #it selects an 10-variable model

# We now perform best subset selection on the full data set to obtain the 10-variable model.
reg.best=regsubsets (Salary~.,data=Hitters , nvmax=19)
coef(reg.best ,10) ## full data set.

# salary = 162.53 - 2.16atbat +6.91hits







