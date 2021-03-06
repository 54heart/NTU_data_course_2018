library(NLP)
library(tm)
library(jiebaRD)
library(jiebaR)
library(RColorBrewer)
library(wordcloud)
library(wordcloud2)
rm(list=ls(all.names = TRUE))
trump<-read.csv("trump_title", stringsAsFactors = F)
docs <- Corpus(VectorSource(trump))
toSpace <- content_transformer(function(x, pattern) {
  return (gsub(pattern, " ", x))
}
)
docs <- tm_map(docs, toSpace, "川普")
docs <- tm_map(docs, toSpace, "‧")
docs <- tm_map(docs, removePunctuation)
docs <- tm_map(docs, removeNumbers)
docs <- tm_map(docs, stripWhitespace)
mixseg = worker()

jieba_tokenizer=function(d){
  unlist(segment(d[[1]],mixseg))
}
seg = lapply(docs, jieba_tokenizer)
freqFrame = as.data.frame(table(unlist(seg)))
freqFrame_ordered<- freqFrame[order(freqFrame$Freq, decreasing = T),]
freqFrame_f<-freqFrame_ordered[-which(nchar(as.character(freqFrame_ordered$Var1))==1),]

trump_word <- barplot(freqFrame_f$Freq[1:30], names.arg = freqFrame_f$Var1[1:30],
        col ="lightblue", main ="Trump-Most frequent words", las = 2,
        ylab = "Word frequencies")

trump_cloud <- wordcloud2(freqFrame_f[1:30,], size = 0.7)


trump_cloud <- wordcloud2(freqFrame_a_clean[1:30,], size = 0.7)
print(trump_cloud)

wordcloud(freqFrame_f$Var1[2:30],freqFrame_f$Freq[2:30],
          scale=c(5,0.1),min.freq=5,max.words=150,
          random.order=FALSE, random.color=FALSE, 
          rot.per=0, colors=brewer.pal(8, "Dark2"),
          ordered.colors=FALSE,use.r.layout=FALSE,
          fixed.asp=TRUE)



