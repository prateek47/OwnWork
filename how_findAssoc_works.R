Here is some code to illustrate how the correlations are calculated. 

> data <-  c("word1", "word1 word2","word1 word2 word3","word1 word2 word3 word4","word1 word2 word3 word4 word5") 
> frame <-  data.frame(data) 
> frame 
data 
1                         word1 
2                   word1 word2 
3             word1 word2 word3 
4       word1 word2 word3 word4 
5 word1 word2 word3 word4 word5 
> test <-  Corpus(DataframeSource(frame, encoding = "UTF-8")) 
> dtm <-  DocumentTermMatrix(test) 
> as.matrix(dtm) 
Terms 
Docs word1 word2 word3 word4 word5 
1     1     0     0     0     0 
2     1     1     0     0     0 
3     1     1     1     0     0 
4     1     1     1     1     0 
5     1     1     1     1     1 
> 
  > findAssocs(dtm, "word2", 0.1) 
word2 word3 word4 word5 
1.00  0.61  0.41  0.25 
> # Correlation word2 with word3 
  > cor(c(0,1,1,1,1),c(0,0,1,1,1)) 
[1] 0.6123724 
> # Correlation word2 with word4 
  > cor(c(0,1,1,1,1),c(0,0,0,1,1)) 
[1] 0.4082483 
> # Correlation word2 with word5 
  > cor(c(0,1,1,1,1),c(0,0,0,0,1)) 
[1] 0.25 
