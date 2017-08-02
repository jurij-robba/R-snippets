# libraries
require('ggplot2')
require('lubridate')

# load data (originaly from https://coinmarketcap.com/currencies/dash/historical-data/?start=20130428&end=20170802)
# and https://bitcoincharts.com/charts/bitstampUSD#igDailyztgSzm1g10zm2g25
data<-cbind(read.csv('btc.csv', colClasses = c('POSIXct', rep('numeric', 7))),
            apply(read.csv('dash.csv', colClasses = c(rep('NULL', 4), 'numeric', rep('NULL', 2))), 2, rev))
data<- data[,c(1, 5, 9)]

names(data)<- c('timestamp', 'btc', 'dash')

dd <- data.frame(timestamp = rep(data$timestamp, 2),
                 value = c(data$btc, data$dash),
                 currency = as.factor(c(rep('BTC', length(data$btc)), rep('DASH', length(data$dash)))))

# actual plot
png('compare.png', width = 800, height = 600)
ggplot(data=dd, aes(x = timestamp, y=value)) +
  geom_step(colour = '#02B3E9') +
  labs(x='Date', y='value [$]', title = 'PRICE OVER TIME') +
  theme(panel.background = element_rect(fill = 'black', colour = 'black'),
        plot.background = element_rect(fill = 'black', colour = 'black'),
        panel.grid = element_blank(),
        axis.line = element_line(color = 'white'),
        axis.text = element_text(color = 'white'),
        title = element_text(color = 'white'),
        plot.title = element_text(hjust = 0.5, vjust=2),
        strip.background = element_rect(colour='black', fill='black'),
        strip.text = element_text(color = '#02B3E9', size=12, face="bold")) +
  facet_grid(currency ~ ., scales = 'free_y')
dev.off()