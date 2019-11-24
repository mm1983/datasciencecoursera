library(httr)
library(XML)

oauth_endpoints("github")
myapp <- oauth_app("github",
                   key = "8d370aa43fb21ba0a6a2",
                   secret = "cba23fabdfdaa467e01a6eae337df53d9119d5c2"
)

github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
stop_for_status(req)
doc <- content(req)
summary <- cbind(sapply(doc,function(X) X$name), sapply(doc,function(X) X$created_at))
# summary <- sapply(doc, "[", c("name","created_at"))
summary[names=="datasharing",2]
# doc <- htmlParse(content(req,as="text"),asText = T)
# root <- xmlRoot(doc)
# a <- xpathSApply(parsedHTML,"//id",xmlName)