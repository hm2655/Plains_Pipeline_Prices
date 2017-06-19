library(httr)
library(rvest)
proxy.string<-use_proxy("http://prox-hou-pri.woodmac.com", port=8080)
url<-"https://www.plainsallamerican.com/customer-center/crude-oil-bulletins"
session<-html_session(url, proxy.string)
link_list<-read_html(session) %>% html_nodes("a") %>% html_attr("href")
a<-matrix(nrow = length(link_list), ncol=1)
for(i in 1:length(link_list))
{
  if(!grepl(".pdf", link_list[i]))
  {
    a[i]<-"true"
  } else 
  {
    a[i]<-link_list[i]
  }
}

a<-a[a[,1]!="true"]


for(i in 1:length(a))
{
  link<-paste("https://www.plainsallamerican.com",a[i], sep="")
  print(link)
  dest<-paste(i,".pdf", sep="")
  download.file(link, destfile = dest, mode = "wb")
}


