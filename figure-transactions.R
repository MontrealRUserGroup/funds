works_with_R("3.1.2", ggplot2="1.0", scales="0.2.3")

transactions <- read.csv("transactions.csv", comment.char="#")

transactions$CAD.balance <- cumsum(transactions$CAD.received)
transactions$Date <- strptime(transactions$date, "%Y-%m-%d")

current <- transactions[nrow(transactions), ]

date.range <- as.POSIXct(range(transactions$Date))
time.diff <- date.range[2] - date.range[1]
date.range[2] <- date.range[2] + time.diff/10

moneyPlot <- 
ggplot(transactions, aes(Date, CAD.balance))+
  theme_bw()+
  geom_hline(aes(yintercept=CAD),
             color="grey",
             data=data.frame(CAD=0))+
  geom_point()+
  geom_line()+
  scale_x_datetime(limits=date.range)+
  geom_text(aes(label=sprintf("%.02f$CAD", CAD.balance)),
            vjust=1.5,
            data=current)

pdf("figure-transactions.pdf")
print(moneyPlot)
dev.off()

