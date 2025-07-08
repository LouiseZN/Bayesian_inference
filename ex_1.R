house <- read.csv("Housing.csv")
View(house)

#If you don't have ths packege:
#install.packages("rstanarm")
#library(rstanarm)

model <- stan_glm(price ~ sqft_living, data = house, family = gaussian(), refresh = 0)

summary(model)

new_house <- data.frame(sqft_living = 1800)
posterior_pred <- posterior_predict(model, newdata = new_house)

# Visualize the distribution
hist(posterior_pred, main = "Posterior Price Prediction", xlab = "Price", col = "lightpink", border = "white")
abline(v = mean(posterior_pred), col = "lightblue", lwd = 2)
posterior_interval(model, newdata = new_house, prob = 0.95)

