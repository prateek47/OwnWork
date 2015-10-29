# Working on Twitter Data

library(tm)
#install.packages('twitteR') 
library(twitteR)

# Register your credentials: setup_twitter_oauth()
consumerKey <- "vhVfq9KxWKV6szepWr09sQwG8"
consumerSecret <- "iyVzy5pvpKmkQ7y8t4vFPCbgIbdYiC10oxTYXz6J2YoKKdtSBw"
accessToken <- "2597552101-1cajqP4TLnoc9ehDxtZRwwY5WJGKQ5hD2kOaVJU"
accessTokenSecret <- "v7i2gjHC0FAAXh31uxrbeyjZoBh5OhIpE0aR61F3IxXvD"
# Create an OAuth authentication handshake with Twitter
setup_twitter_oauth(consumerKey, consumerSecret, accessToken, accessTokenSecret)

# If you have problem with this authentication process, install this and re-open R/RStudio
install.packages("base64enc") 

# ______________________________________________________________________________________
# 
# oAuth: "An open protocol to allow secure authorization in a simple and standard method 
# from web, mobile and desktop applications."
# for more info, visit: http://oauth.net/
# Also, http://commandlinefanatic.com/cgi-bin/showarticle.cgi?article=art014
# ______________________________________________________________________________________

# Search Twitter and download tweets based on a search string;
# permitted 350 requests per hour, limited to 1500 results each time; 

DStweets <- searchTwitter('#datascience', n=1000, lang = "en")

# Convert the Tweets in a dataframe
DSDF <- do.call(rbind, lapply(DStweets, as.data.frame))

# The tweets data frame description

# text: The text of the status (i.e., the tweet)
# favorited: Whether this status has been favorited
# favoriteCount: the number of times this status has been favorited
# replyToSN: Screen name of the user this was in reply to
# created: When this status was created
# truncated: Whether this status was truncated
# replyToSID: ID of the status this was in reply to
# id: ID of this status
# replyToUID: ID of the user this was in reply to
# statusSource: Source user agent for this tweet
# screenName: Screen name of the user who posted this status
# retweetCount: The number of times this status has been retweeted
# isRetweet: TRUE if the status itself was a retweet of someone else's status
# retweeted: TRUE if this status has been retweeted
# longitude & latitude: the location the status was made from
#

# Start Analyzing the tweets
# removing special cahracters from the tweets

DSDF$text <- gsub("[^[:alnum:]]", " ", DSDF$text) # removing the alpha numeric character

# extract the tweets in a vector
tweets <- as.vector(DSDF$text)

# get the source names
getSources()

# Create a Corpus
DS__Corpus <- Corpus(VectorSource(tweets))

str(DS_Corpus)      # display the structure of the corpus object
inspect(DS_corpus)  # display the corpus

# create document term matrix applying some transformations
tdm <- TermDocumentMatrix(DS__Corpus,
                          control = list(stopwords = c("http", stopwords("english")),
                                         removeNumbers = TRUE, tolower = TRUE))

# Converting it to a matrix
tweet.matrix <- as.matrix(tdm)
