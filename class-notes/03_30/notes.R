## Notes from the book chapter 18, ~ p 247


library(reshape2)
library(scales)

econCor = cor(economics[, c(2, 4:6)])
econMelt = melt(econCor, varnames=c("x", "y"), value.name = "correlation")

econMelt = econMelt[order(econMelt$correlation),]
econMelt


## Plot it with ggplot 

ggplot(econMelt, aes(x=x, y=y)) +
  geom_tile(aes(fill = correlation)) +
  scale_fill_gradient2(low = muted("red"),
                      mid="white",
                      high = "steelblue",
                      guide = guide_colourbar(ticks=FALSE, barheight=10),
                      limit=c(-1, 1)) +
  theme_minimal() +
  labs(x=NULL, y=NULL)
