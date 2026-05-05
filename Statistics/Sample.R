library(ggplot2)
library(httpgd)

data <- iris

httpgd::hgd()
options(device = httpgd::hgd)

p <- ggplot(data, aes(x = Sepal.Length, y = Sepal.Width, color = Species)) +
  geom_point()

print(p)  # Explicitly print the plot

q <- ggplot(data, aes(x = Petal.Length, y = Petal.Width, color = Species)) +
  geom_point()

print(q)  # Explicitly print the plot
