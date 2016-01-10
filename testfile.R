
library(ggplot2)
library(dplyr)


data <- read.table(unz("activity.zip", "activity.csv"), header=T, sep=",")
mydata <- as.data.frame(data)

# Add column tah identify days,data are FULL so no intervals was missed
# In this case I can automatically generate days columns without any error
mydata$days = rep(seq(1,61,1),each = 288)

# Using dplyr I group data in days

data_gr_day <- group_by(mydata,days)

daily_count <- summarise(data_gr_day, StepsCount = sum(steps, na.rm = TRUE))


ggplot(daily_count, aes(x = days, y = StepsCount, fill = StepsCount)) + 
    geom_bar(stat = "identity") +
    scale_fill_gradient(low="blue", high="red")

ggplot(mydata, aes( y = (steps))) + 
  geom_boxplot()

data_gr_interval <- group_by(mydata,interval)
daily_mean <- summarise(data_gr_interval, StepsMean = mean(steps, na.rm = TRUE))

ggplot(daily_mean, aes(x = interval, y = StepsMean)) + 
  geom_line()

    