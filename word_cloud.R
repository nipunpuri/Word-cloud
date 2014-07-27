setwd("C:/Users/user/OneDrive/Office/quaterly")
x <- read.csv("topics.csv" , stringsAsFactors = F)
View(x)
search <- x$Search.Keywords

searchSplit <- strsplit(search , "--> [0-9],")
searchSplitVector <- unlist(searchSplit)

searchSplit1 <- strsplit(searchSplitVector , "[0-9] ")
searchSplitVector1 <- unlist(searchSplit1)
searchSplitVector1 <- removeWords(searchSplitVector1 , c("-->"))
tbl <- table(searchSplitVector1)
sort(tbl)

##searchSplit2 <- strsplit(searchSplitVector , "-->")
##searchSplitVector2 <- unlist(searchSplit1)

wordsDf <- as.data.frame(searchSplitVector1 , stringsAsFactor = F)

library("tm", lib.loc="C:/Users/user/Documents/R/win-library/3.0")
library("wordcloud", lib.loc="C:/Users/user/Documents/R/win-library/3.0")
library("SnowballC", lib.loc="C:/Users/user/Documents/R/win-library/3.0")


words <- Corpus(DataframeSource(data.frame(x[, "Search.Keywords"])))



words <- tm_map(words , stripWhitespace)
words <- tm_map(words, removePunctuation)
words <- tm_map(words, removeNumbers)
words <- tm_map(words, tolower)
words <- tm_map(words, removeWords, stopwords("english"))
words <- tm_map(words, removeWords ,c("-->" , "krrish" , "dhoom" )) 
words <- tm_map(words, stemDocument)

wordcloud(words, scale=c(6,1.5), max.words=100, random.order= F, rot.per=0.35, use.r.layout=F, colors=brewer.pal(8, "Dark2"))
