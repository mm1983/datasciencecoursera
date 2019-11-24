gdp <- read.csv("data.csv",skip = 5,header = F)
edu <- read.csv("edu.csv")
gdp_cleaned <- gdp %>% filter(!(V1=="")) %>% mutate(V2=as.numeric(as.character(V2))) %>% arrange(desc(V2))
gdp_cleaned[13,4]
sum(sapply(gdp_cleaned$V1[1:214],function(X) X %in% edu$CountryCode))
joined <- inner_join(gdp_cleaned,edu,by=c("V1" = "CountryCode"))
group_by(joined,Income.Group) %>% summarise(avg = mean(V2,na.rm=T)) %>% print
edu_filtered <- edu %>% filter(Income.Group == "Lower middle income")
gdp_cleaned <- gdp_cleaned %>% arrange(V2)
sum(sapply(gdp_cleaned$V1[1:38],function(X) X %in% edu_filtered$CountryCode))