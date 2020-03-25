rm(list=ls())
if(!require(rvest)) {
  install.packages("rvest")
  library(rvest)
} #load / install+load rvest

#爬PTT看板最新一頁的資訊
getBoradData <- function (board, extra_title_data){
  final = c()
  for(b in board){
    # 要爬的網頁
    doc <- read_html(paste("https://www.ptt.cc/bbs/",b,"/index.html",sep='')) 
    # 標題資訊
    title <- doc %>% html_nodes(".title a") %>% html_text() 
    df = data.frame(title)
    # 額外資訊
    for (ex in extra_title_data){
      df[[ex]]<-doc %>% html_nodes(paste(".",ex,sep='')) %>% html_text()
    }
    final = c(final,list(board=b,content=df))
  }
  return (final)
}

result<-getBoradData(c("graduate","Soft_Job"),c("date","author"))
#結果輸出
result


