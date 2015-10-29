
# scraping data from a json file format
library(RJSONIO)

foomarketraw <- fromJSON('https://data.ny.gov/api/views/9a8c-vfzj/rows.json?accessType=DOWNLOAD')

# If you type str(foodMarketsRaw) you'll notice that the data has been read as an R list.
# So we will use double brackets to extract the data node:
foodmarket <- foomarketraw[['data']]
foodmarket[[1]][14] # checking the names in that list
#
# extracting the names in the list using an sapply
fmNames <- sapply(foodmarket, function(x){x[[14]]})
head(fmNames) # checking the list
#
# we can do this 23 times and create 23 lists and join them in a dataframe
# or we can do it programmitically,
# Approach 1: we can create 2 nested sapply, but can run into problem if there are 
# empty values
# Approach 2: we can create 2 functions, one gives true/false if has value ir not, second 
# will perform the sapply
library(gdata)
removena <- function(x, var){
  if(!is.null(x[[var]])){
    return(trim(x[[var]]))
  }else {
    return(NA)
  }
}

grabdata <- function(var){
  print(paste("variable", var, sep = ''))
  sapply(foodmarket, function(x){removena(x, var)})
}

fmData <- data.frame(sapply((1:22), grabdata), stringsAsFactors = FALSE)
# checking the 23rd element, which is a list within a list within a list
foodmarket[[1]][[23]]
# for the sublist in list 
grabgeoinfo <- function(val1){
  l <- length(foodmarket[[1]][[val1]])
  lapply(1:l,function(y){
    sapply(foodmarket, function(z){
      if(!is.null(z[[val1]][[y]])){
        return(trim(z[[val1]][[y]]))
      }else{
        return(NA)
      }
    })
  })
}

fmdatageo <- grabgeoinfo(23)
# converting it in data frame
fmdatageo <- data.frame(do.call("cbind", fmdatageo), stringsAsFactors = FALSE)
fmData <- cbind(fmData, fmdatageo)
# getting the column name
columns <- foomarketraw[['meta']][['view']][['columns']]
fnNames1 <- sapply(1:22, function(x){columns[[x]]$name})
fnNames2 <- columns[[23]]$subColumnTypes
fmNames <- c(fnNames1, fnNames2)
names(fmData) <- fmNames
# checking the data
head(fmData)
# converting the longitude and latitude in numeric format
fmData$latitude <- as.numeric(fmData$latitude)
fmData$longitude <- as.numeric(fmData$longitude)
