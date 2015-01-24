## List of 15,000 random CrossRef DOIs from 2013

Generated with the following R script:

```r
library('rcrossref')
library('stringr')

splitColumn <- function(df, colname) {
  string <- df[colname]
  str_split(iconv(string, "latin1", "UTF-8"), ",")[[1]][1]
}

trimWhitespace <-  function(df, colname) {
  string <- df[colname]
  iconv(gsub("\\s+"," ",string), "latin1", "UTF-8")
}

for (i in 1:20) {
  result <- cr_works(sample = 1000, filter=c(from_pub_date='2013-01-01', until_pub_date='2013-12-31', type='journal-article'))
  data <- unique(as.data.frame(result$data))
  data$doi <- data$DOI
  data$publication_date <- data$issued
  data$title <- apply(data, 1, trimWhitespace, colname = "title")
  # only fetch first journal title
  data$journal <- apply(data, 1, splitColumn, colname = "container.title")
  # only fetch first ISSN
  data$issn <- apply(data, 1, splitColumn, colname = "ISSN")
  # extract CrossRef member id from URL
  data$member_id <- str_extract(data$member, "\\d+")
  data <- subset(data, select=c("doi", "publication_date", "title", "journal", "issn", "publisher", "member_id"))
  file <- paste("random_crossref_dois", "_", "2013", "_", i, ".csv", sep = "")
  write.csv(data, file, row.names=FALSE, fileEncoding="UTF-8")
}

data <- read.csv("random_crossref_dois_2013_1.csv", stringsAsFactors=FALSE, sep=",", header=TRUE)

for (i in 2:20) {
  file <- paste("random_crossref_dois", "_", "2013", "_", i, ".csv", sep = "")
  temp <- read.csv(file, stringsAsFactors=FALSE, sep=",", header=TRUE)
  data <- rbind(data, temp)
}

data <- unique(data)
data <- data[sample(1:nrow(data), 15000,replace=FALSE),]

data <- subset(data, member_id == 340)

write.csv(data, "random_crossref_dois_2013.csv", row.names=FALSE, fileEncoding="UTF-8")
```
