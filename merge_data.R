data <- read.csv("random_crossref_dois_2013_1.csv", stringsAsFactors=FALSE, sep=",", header=TRUE)

for (i in 2:20) {
  file <- paste("random_crossref_dois", "_", "2013", "_", i, ".csv", sep = "")
  temp <- read.csv(file, stringsAsFactors=FALSE, sep=",", header=TRUE)
  data <- rbind(data, temp)
}

data <- unique(data)
data <- data[sample(1:nrow(data), 15000,replace=FALSE),]

write.csv(data, "random_crossref_dois_2013.csv", row.names=FALSE, fileEncoding="UTF-8")
