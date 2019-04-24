
## Part 2 

##### explanation...explanation, explanation, explanation
```{r}
breaks <- fivenum(dat$price)
lables <- c("very cheap","cheap","normal","expensive")
price.level <- factor(cut(dat$price,breaks,lables))
dat.new <- cbind(dat,price.level)
dat.new <- dat.new[!is.na(dat.new$price.level)]


ggplot(dat.new, aes(price.level, points, fill = price.level)) + 
 geom_boxplot(notch = T,notchwidth = 0.5) + 
 ggtitle("Points vs. Price Level") +
 labs(x="Price Level",y="Points") +
 geom_violin()+
 scale_fill_brewer(palette = "Set1") +
 labs(fill = "price.level") + theme_classic() 

```

## 3
```{r}
# Sentiment Analysis
subdat %>%
 filter(country == 'US') %>%
 unnest_tokens(output = word, input = description) %>%
 inner_join(get_sentiments('bing')) %>%
 group_by(sentiment) %>%
 count() %>%
 ggplot(aes(x=sentiment,y=n, fill=sentiment)) + geom_col() + 
 theme_classic() + guides(fill=F) + 
 ggtitle('Sentiment Distribution') + ylab('Number of Oversation For Italy') +
 theme(plot.title = element_text(hjust = 0.5)) + scale_fill_brewer(palette = 'Set1') + coord_flip()
```
## 4
```{r}

dat$country <- as.numeric(as.factor(dat$country))
subdat2 <- dat[,c('country','points','price')]
subdat2 <- subdat2[complete.cases(subdat2)]
dat.pca <- prcomp(subdat2,center = TRUE,scale. = TRUE)

summary(dat.pca)
```


## PCA 
```{r}

pca_facto <- PCA(subdat2,graph = F)
fviz_eig(pca_facto,ncp=11,addlabels = T)

charts = lapply(1:3,FUN = function(x) fviz_contrib(pca_facto,choice = 'var',axes = x,title=paste('Dim',x)))
grid.arrange(grobs = charts,ncol=3,nrow=2)
```



```{r read data, echo=FALSE}
dat <- fread(input = '../Data/winemag-data-130k-v2.csv',verbose = FALSE,na.strings=c(""))
```

```{r constants}
country.name <- "country"
description.name <- "description"
designation.name <- "designation"
points.name <- "points"
price.name <- "price"
province.name <- "province"
region_1.name <- "region_1"
region_2.name <- "region_2"
taster.name <- "taster_name"
twitter.name <- "taster_twitter_handle" 
title.name <- "title"
variaty.name <- "variety"
winery.name <- "winery"

dat[,eval(points.name)] <- as.numeric(dat[,get(points.name)])
dat[,eval(price.name)] <- as.numeric(dat[,get(price.name)])

single.var <- c(points.name, price.name, country.name)
```



```{r include=FALSE}
# filter data set
subdat <- dat %>%
 select(variaty.name,country.name,points.name,province.name, winery.name,description.name)

head(subdat)
# count length of 
subdat$descriptioncount <- str_count(string = subdat$description, pattern = '\\S+')
```

```{r}
# summary of description length
summary(subdat$descriptioncount)

# Description distribution
ggplot(data = subdat, aes(x = descriptioncount)) + geom_histogram(bins=30, fill = 'royalblue4') + 
 theme_classic() +
 ggtitle('Description word length Distribution') + 
 xlab('Number of words used in Description') + 
 ylab('Number of Observations') + 
 theme(plot.title = element_text(hjust = 0.5)) + scale_fill_brewer(palette = "Blues")
ylim(0,25000) 
```




## 2
```{r}
# filter data set
subdat <- dat %>%
 select(variaty.name,country.name,points.name,province.name, winery.name,description.name)

# Sentiment Analysis
subdat %>%
 unnest_tokens(output = word, input = description) %>%
 inner_join(get_sentiments('bing')) %>%
 group_by(sentiment) %>%
 count() %>%
 ggplot(aes(x=sentiment,y=n, fill=sentiment)) + geom_col() + 
 theme_classic() + guides(fill=F) + 
 ggtitle('Sentiment Distribution') + ylab('Number of Oversation') + 
 ylim(0,400000) + theme(plot.title = element_text(hjust = 0.5))

```
