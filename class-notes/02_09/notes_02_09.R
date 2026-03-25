# first line

---
# Load the data set
# Initialize the variables (i.e., x,y)
ggplot(dataset, aes(x = area, y = ypopulation))

# Or else use new lines with '+' sign
ggplot(my_dataset) +
  aes(x = area) +
  aes(y = ypopulation)


## Now add objects (i.e., scatter plot, histogram, ect.)
ggplot(dataset, aes(x = area, y = ypopulation)) +
  geom_point() +
  geom_smooth(method = 'lm')

## Now you an add images, color, zoom in and zoom out ect. 


# Now save the plot as an object and graph the object.
g = ggplot(dataset, aes(x = area, y = ypopulation)) +
  geom_point() +
  geom_smooth(method = 'lm')
# Now plot g
plot(g)


## Now to limit the x and y access to Zoom in or out

# Method 1 (this will delete data points that are outliers)
g + xlim(c(0, 0.1)) + ylim(c(0, 100)) ## Or what ever the scale needs....

# Method 2, here we will zoom in without deleting data points
g + coord_cartesian(xlim=c(0,0.1), ylim=c(0,10000))


## Add the labels layer
g + 
  labs(title = "Area vs Population", 
       subtitle = "From Midwest data set",
       y="Population", x="Area",
       caption = "Midwest Demographics")


# note about color
library(RColorBrewer)
# MORE THAT I DIDNT GET!


## All together we have:
ggplot(dataset, aes(x = area, y = ypopulation)) +
  geom_point() +
  geom_smooth(method = 'lm') +
  coord_cartesian(xlim=c(0,0.1), ylim=c(0,10000)) +
  labs(title = "Area vs Population", 
       subtitle = "From Midwest data set",
       y="Population", x="Area",
       caption = "Midwest Demographics")


## Now to adjust the dots in the middle
## Search on google for the types "geom_point types"
ggplot(dataset, aes(x = area, y = ypopulation)) +
  geom_point(aes(col=state), size=3) +
  geom_smooth(method = 'lm') +
  coord_cartesian(xlim=c(0,0.1), ylim=c(0,10000)) +
  labs(title = "Area vs Population", 
       subtitle = "From Midwest data set",
       y="Population", x="Area",
       caption = "Midwest Demographics")


# Set above to variable gg
gg = ggplot(dataset, aes(x = area, y = ypopulation)) +
  geom_point(aes(col=state), size=3) +
  geom_smooth(method = 'lm') +
  coord_cartesian(xlim=c(0,0.1), ylim=c(0,10000)) +
  labs(title = "Area vs Population", 
       subtitle = "From Midwest data set",
       y="Population", x="Area",
       caption = "Midwest Demographics")

## Modifying X or Y axes
gg +
  scale_color_brewer(palette = "Set1") +
  theme(legend.position = "None")  + # Remove the legend
  scale_x_continuous(breaks = seq(0, 0.1, 0.01), labels = "None")


## Dlifferent Pre-built Theems
gg +
  theme_bw() +
  theme(legend.position = "None")

---


#Old faithful dataset
# Load the dataset
data("faithful")
View(data)


## We can get descriptive statics for variables in data 
summary(faithful)


ggplot(faithful,aes(x=waiting), y = after_stat(count)/sum(after_stat(count))) +
 geom_histogram(binwidth=2,
                fill="cornsilk",color="black")+
 labs(x="Waiting Time Between Eruptions In Minutes",
      y="Relative Frequencies",
      title="Old Faithful Geyser Eruptions")


histPlot <- ggplot(faithful,aes(x=waiting,y = after_stat(density))) +
  geom_histogram(binwidth=2,
                 fill="cornsilk",color="black")+
  labs(x="Waiting Time Between Eruptions In Minutes",
       y="Density",
       title="Old Faithful Geyser Eruptions")

plot(histPlot)

histPlot+ geom_line(stat="density",color="blue",linewidth=1.2)+
  xlim(33,104)

histPlot +
  geom_density(adjust=.5,fill="cyan",color="black",alpha=0.4)+
  xlim(35,102)
