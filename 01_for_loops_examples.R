
mean(iris$Sepal.Length)
mean(iris$Sepal.Width)


# For loops ---------------------------------------------------------------
# If a function or set of function has to be repeatedly called with different (or same) parameters
# we can use for loops to avoid manual duplication of code

# Example
# compute mean of every numeric column in the iris data frame

iris_numeric <- subset(iris, select = -Species) # select all variables except Species

column_means <- vector(mode = "numeric", length = 4) # empty vector that will hold the results
                                                     # (always create an empty vector like this for
                                                     # speed and efficiency)


for (i in seq_along(iris_numeric)) {   
  column_means[i] <- mean(iris[[i]])
}

# Apply functions ---------------------------------------------------------
# for loops work fine, but the code takes a lot of space.
# The functions of apply (apply, lapply, sapply, etc.) family are wrappers
# around a for loop that makes the code more readable.

# Example
# compute mean for every numeric variable in the iris data frame

iris_numeric <- iris[, -5] # select all variables except Species

apply(iris_numeric, dim = 2, mean) # apply function mean() for every element of the 2nd dimension (i.e. every column)
                             # of the iris_numeric data frame. It is also not necessary to create an empty vector,
                             # apply() handles it by itself

# apply() returns a vector
# lapply() returns a list (useful when each outcoming element is a lm object or something like that)
# sapply() returns the most simple type of object possible, i.e. vector, if not possible than array, if not possible than list

# Example of lapply

lapply(iris_numeric, mean) # note that it returns a list and doesn't require dim argument (always takes columns)

lapply(iris_numeric, function(x) round(mean(x)))

average_and_round <- function(x) {
  round(mean(x))
}

lapply(iris_numeric, average_and_round)

# Map functions -----------------------------------------------------------
# Tidyverse's package purrr has its own family of iterating functions, called map (e.g. map(), map2(), map_dbl(), etc.)
# Works mostly the same like apply, but allow for lambda notation, i.e. functional code

purrr::map(iris_numeric, mean) # equivalent to lapply()
purrr::map_dbl(iris_numeric, mean) # like sapply(), but also check if the result is a numeric vector (double, hence dbl)

# lambda notation alows to specify which argument to iterate over. Usefl when you are specifying multiple arguments

purrr::map_dbl(iris_numeric, ~mean(., na.rm = TRUE)) # the dot (.) denotes where is the iterated elemement placed.
                                                     # Note the tilde (~) at the beginning of the function name,
                                                     # it has to be present.
