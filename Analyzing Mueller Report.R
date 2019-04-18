#making a textnet of the Mueller Report

download.file("https://viewfromll2.files.wordpress.com/2019/04/mueller-report.pdf", "mueller-report.pdf")

#install.packages("pdftools")
report<-pdftools::pdf_text("mueller-report.pdf")

muellerreport<-as.data.frame(report)


library(devtools)
#install_github("cbail/textnets", force=TRUE)
library(textnets)

muellerreport$page<-rownames(muellerreport)

muellernets <- PrepText(muellerreport, textvar = "report", groupvar="page", node_type="words", tokenizer = "words", pos = "nouns", remove_stop_words = TRUE, compound_nouns = TRUE)

out<-muellernets[muellernets$count>2,]

mueller_network <- CreateTextnet(out)

VisTextNet(mueller_network, label_degree_cut = 0, alpha=.05)



