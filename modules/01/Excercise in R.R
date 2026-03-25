########### Example 1 ##################

#Write functions to evaluate following mathematical formulas
#a) y = 5e^(-x)
#b) z = sqrt(x^2+y^2)

######## Example 2 #####################

# a) Read in the "Cereal" dataset, look at the first few rows with head and 
#inspect the data types of the variables in the dataframe with str 

## Read in the data and view the first little
cereals_data = read.csv("01/Cereals.csv")
View(cereals_data)
head(cereals_data)

## View the structure of the data frame
str(cereals_data)


# b) Add a new variable to the dataset called ’totalcarb’, 
#which is the sum of ’carbo’ and ’sugars'

## First extract the carbs and sugars variables, add together
## Then set the result as anew variable named totlacarb

totalcarb <- cereals_data$carbo + cereals_data$sugars

cereals_data$totalcarb = totalcarb
str(cereals_data)




# c) How many cereals in the dataframe are ’hot’ cereals? 

## List the value with the table
table(cereals_data$Cold.or.Hot)

## OR do it programatically
hot_cereals = subset(cereals_data, Cold.or.Hot == "H")
nrow(hot_cereals)




# d) How many unique suppliers are included in the dataset?

## Get the actual value with table but not exactly the way we want it to be.
table(cereals_data$Supplier)

## Use the length() function to calculate the unique values
length(table(cereals_data$Supplier))


# Can also use the unique() function, wrapped in the length function
length(unique(cereals_data$Supplier))


# e) Take a subset of the dataframe with only the
# supplier ’K’ (Kellogg’s)

## creaate the new vector when supplier == "K"
kellogs <- subset(cereals_data, Supplier == "K")

## Also can use the index 
kellogs2 <- cereals_data[cereals_data$Supplier == "K", ]


# f) Take a subset of the dataframe of all cereals that
#have less than 80 calories, 
#AND have more than 20 units of vitamins.

## Using the indexing with the conditions
f_cereals_1 <- cereals_data[cereals_data$calories < 80 & cereals_data$vitamins > 20,]

## Using subset function matching the conditions
f_cereals_2 <- subset(cereals_data, calories < 80 & vitamins >20)




# g) Take a subset of the dataframe containing cereals that 
#contain at least 1 unit of sugar, 
#and keep only the variables ’Cereal.name’, 
#’calories’ and ’vitamins’. 
#Then inspect the first few rows of the dataframe with head.


## Using subset
g_cereals <- subset(cereals_data, sugars >= 1, select = c("Cereal.name", "calories", "vitamins"))

## Using indexing 
g_cereals_2 <- cereals_data[cereals_data$sugars>=1, c("Cereal.name", "calories", "vitamins")]

## NOTE: the g_cereals and g_cereals_2 are NOT the same!!!!!
# This is due to missing values in the original data set in the potass column.
table(is.na(cereals_data)) # We can see that we have some N/A values

## Create a new clean data set by removing the N/A values
cereals_data_clean = na.omit(cereals_data)

## Now we recreate the g_cereals variables using the new clean data set and see they are both the same
g_cereasl_celan <- subset(cereals_data_clean, sugars >= 1, select = c("Cereal.name", "calories", "vitamins"))

g_cereasl_celan_2 <- cereals_data_clean[cereals_data_clean$sugars>=1, c("Cereal.name", "calories", "vitamins")]



# h) For one the above subset, write to a new CSV file

## Use the write.csv() function
write.csv(g_cereals_clean, "temp_cereals.csv") ## This will leave the row number as the 1st column

## To remove the row column
write.csv(g_cereals_clean, "temp_cereals-no-row.csv", row.names = F)



# i) Rename the column ’Supplier’ to ’Producer’

## Use the name() function to see the current column names
names(cereals_data)

## Then use indexing to update the name 
# names(cereals_data)[2] = "Producer" ## THIS WORKS BUT NOT IDEAL!!

names(cereals_data)[names(cereals_data)=="Supplier"] = "Producer"

# confirm it worked 
names(cereals_data)

# j)  change hot.or cold into a factor variable

## A factor is not a unique value, like calories, fat, Hot.or.Cold, 
## But the Cereal.name is unique. It is not duplicated in any other rows. (or UUID, user_id)

str(cereals_data) ## Note that the original data set dose not include factors.

cereals_data$Cold.or.Hot = factor(cereals_data$Cold.or.Hot)
str(cereals_data) # Verify that the Cold.or.Hot updated to a factor

cereals_data$Producer = factor(cereals_data$Producer)
str(cereals_data)


