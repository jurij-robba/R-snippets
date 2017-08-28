require('ggplot2')

data <- read.csv('defaultgcc.csv')
summary(data)

png('compare.png', width = 800, height = 600)
ggplot(data=data) + geom_bar( aes(x=method, y=time),stat = "identity", colour = '#02B3E9') +
  labs(y='Time [ms]', title = "Counting number of chars 'a' in random std::string") +
  theme(panel.background = element_rect(fill = 'black', colour = 'black'),
        plot.background = element_rect(fill = 'black', colour = 'black'),
        panel.grid = element_blank(),
        axis.line = element_line(color = 'white'),
        axis.text = element_text(color = 'white'),
        title = element_text(color = 'white'),
        plot.title = element_text(hjust = 0.5, vjust=2))
dev.off()
