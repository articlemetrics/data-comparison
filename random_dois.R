library('rcrossref')
library('stringr')

splitColumn <- function(df, colname) {
  string <- df[colname]
  str_split(iconv(string, "latin1", "UTF-8"), ",")[[1]][1]
}     

for (i in 1:20) {
  result <- cr_works(sample = 1000, filter=c(from_pub_date='2013-01-01', until_pub_date='2013-12-31', type='journal-article'))
  data <- unique(as.data.frame(result$data))
  data$doi <- data$DOI
  data$publication_date <- data$issued
  data$title <- iconv(str_trim(data$title), "latin1", "UTF-8")
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
