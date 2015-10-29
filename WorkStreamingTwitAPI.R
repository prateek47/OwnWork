# how to use Streamming API
# streamR is the package to capture streaming API
library(streamR)
# load the authentication key, you only need to do it once,
load("my_oauth.RData")

### fitering out tweets based on track parameter, which tracks specific keywords
filterStream("tweets.json", # format
             track = c("Obama", "Biden"), # keywords to track, comma separated, any number of words can be added
             timeout = 10, # how long the twitter streamming will be open
             oauth = my_oauth) # use the authentication key
tweets.df1 <- parseTweets("tweets.json", simplify = TRUE)

# finding the number of tweets each type keywords are
c( length(grep("obama", tweets.df1$text, ignore.case = TRUE)),
   length(grep("biden", tweets.df1$text, ignore.case = TRUE)) )
#
#
#
#
#### filtering tweets according to the 'location' parameter.
filterStream("tweetsUS.json", 
             locations = c(-125, 25, -66, 50), # the location( boundry box) from which tweets need to be captured
             timeout = 300, # the time duration of the tweets
             oauth = my_oauth) # my authentication
tweets.df2 <- parseTweets("tweetsUS.json", verbose = FALSE)
# using ggplot to plot the tweets in the map
library(ggplot2)
library(grid)
# install.packages("maps")
library(maps)
map.data <- map_data("state")
# creating a dataframe of the location of the tweets
points <- data.frame(x = as.numeric(tweets.df2$lon), y = as.numeric(tweets.df2$lat))

points <- points[points$y > 25, ]
# plotting the tweets
ggplot(map.data) +
  geom_map(aes(map_id = region), map = map.data, fill = "white", color = "grey20", size = 0.25) + 
  expand_limits(x = map.data$long, y = map.data$lat) + 
  theme(axis.line = element_blank(), axis.text = element_blank(), axis.ticks = element_blank(), 
        axis.title = element_blank(), panel.background = element_blank(), panel.border = element_blank(), 
        panel.grid.major = element_blank(), plot.background = element_blank(), 
        plot.margin = unit(0 * c(-1.5, -1.5, -1.5, -1.5), "lines")) + geom_point(data = points, 
                                                                                 aes(x = x, y = y),
                                                                                 size = 1, alpha = 1/5,
                                                                                 color = "darkblue")

