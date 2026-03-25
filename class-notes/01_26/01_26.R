

## Normal devision
17/3 ## returns 5.666667

## Just get the quotient, no remainder
17%/%3 ## returns 5

## Just return the remainder
17%%3 ## returns 2

## Round up or down using the floor or ceiling functions..
floor(17/3) ## returns 5
ceiling(17/3) ## returns 6


# variables
## Set a variable
x <- 5
## Call the variable
x


## Also can use the assign function
assign('z', 6)
z



## Checking the data type of variables
a = 5
b = 7
c = 6.7
d = "Apple"

class(a)
class(b)
class(c)
class(d)

## We discussed some reasons to assign integer vs numerical, memory management. 
## Integers require little less memory than numeric.
## i.e. game development, all the extra memory will add up

e = as.integer(b) # sets e to the value of b but casts it as integer
e # prints 7
class(e) # integer

## Next covered the logical or Boolean operators. true / false. True = 1, false = 0.
TRUE * 7
FALSE * 7

class(TRUE)
class(FALSE)


# Using these logical operators we can  binary comparisons


## Moving on to vectors
x = c(1,2,3,4,5,6,7)

y = c("alpha", "beta", "gamma", "delta")

class(x)
class(y)

length(x)
length(y)

xx = c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20)
class(xx)
length(xx)



## combining vectors 
first = c(1,2,3,4,5,6)
last = c(7,8,9,10)
both = c(first, last)
both


character_vector = c("a", "b", "c", "d")
integer_vector = c(1,2,3,4,5)

character_vector
integer_vector

new_vector = c(character_vector, integer_vector)
new_vector
class(new_vector)
## new_vector has converted integer_vector to characters.


## Automatically setting values

one_hund = c(1:100)
one_hund

minus_2 = -2:100
minus_2


minus_ten = 100:-10
minus_ten



# seq(-2,10,by=0.05) ## long vector
seq(-2,10,by=0.5) ## shorter this way!






## Data frames
x = 12:4
y = 8:0
z = c("a","b","c","d","e","f","g","h","i")
dat = data.frame(x,y,z)
dat
class(dat)
dim(dat)
str(dat)

ncol(dat)
nrow(dat)
dat$x
dat$y
dat$z
typeof(dat)
head(dat)
tail(dat)


## only display the first or last 3 rows...
head(dat, 3)
tail(dat, 3)


class(dat$x)
class(dat$y)
class(dat$z)

## Structure of the data frame.
# Compactly display the internal structure of an R object using the structure function str(obj)
# Shows variable names, and the first few of items...
str(dat)




# Create a one dim vector
s = c("aa","bb","cc","dd")

# find the 3rd value of the 's' vector.
s[3]
s[15]

# include everything except the 4th element
s[-4]

# only include the first 3 elements
s[1:3]










