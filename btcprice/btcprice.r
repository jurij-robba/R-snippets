# libraries
require('ggplot2')

# load data (originaly from https://bitcoincharts.com/charts/bitstampUSD#igDailyztgSzm1g10zm2g25)
data<-read.csv('price.csv', colClasses = c('POSIXct', rep('numeric', 7)))

# manipulation data frames
mtgox <- data.frame(xmin=as.POSIXct('2013-10-01'), xmax=as.POSIXct('2014-04-01'), ymin=-Inf, ymax=Inf)
manip <- data.frame(xmin=as.POSIXct('2017-03-01'), xmax=as.POSIXct('2017-09-01'), ymin=-Inf, ymax=Inf)

# actual plot
png('btc_price_all.png', width = 800, height = 600)
ggplot(data=data, aes(Timestamp, Price)) + geom_step(col = '#02B3E9') + labs(x='Date', y='value [$]', title = 'BTC PRICE OVER TIME') +
  theme(panel.background = element_rect(fill = 'black', colour = 'black'),
    plot.background = element_rect(fill = 'black', colour = 'black'),
    panel.grid = element_blank(),
    axis.line = element_line(color = 'white'),
    axis.text = element_text(color = 'white'),
    title = element_text(color = 'white'),
    plot.title = element_text(hjust = 0.5, vjust=2)) +
  geom_rect(data=mtgox, aes(xmin=xmin, xmax=xmax, ymin=ymin, ymax=ymax),
    color='white',
    alpha=0.5,
    inherit.aes = FALSE) +
  geom_rect(data=manip, aes(xmin=xmin, xmax=xmax, ymin=ymin, ymax=ymax),
    color='white',
    alpha=0.5,
    inherit.aes = FALSE) +
  geom_label(aes(x=as.POSIXct('2013-06-01'), y=max(data$Price)/2, label='MtGox')) +
  geom_label(aes(x=as.POSIXct('2016-10-01'), y=max(data$Price)/2, label='Fork talks'))
dev.off()

