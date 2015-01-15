library('rcrossref')

dois <- cr_r(15000, filter=c(from_pub_date='2013-01-01', until_pub_date='2013-12-31', type='journal-article'))
csv <- unique(as.data.frame(dois))
write.csv(csv, "random_crossref_dois_2013.csv", row.names=FALSE, quote=FALSE, fileEncoding="utf-8")
