# 🏡 Bayesian House Price Prediction in R

> A practical example of Bayesian linear regression using R and `rstanarm` to estimate the **distribution of house prices** based on living area (sqft).

---

## 📌 Overview

This project demonstrates how to use **Bayesian inference** to estimate the price of a house based on its size (in square feet), using real housing data.

Unlike classical regression, Bayesian regression **does not return just one estimate** for each parameter — it returns a full **posterior distribution**, which allows us to **quantify uncertainty** in a meaningful way.

---

## 🧠 Methodology

We model the price of a house using:

$$
\text{price}_i \sim \mathcal{N}(\beta_0 + \beta_1 \cdot \text{sqft}_i, \sigma^2)
$$


- The model is fit using **MCMC sampling**
- Priors are weakly informative (default from `rstanarm`)
- Posterior distributions are used to generate **predictive intervals**

---

## 📁 Files

| File | Description |
|------|-------------|
| `Housing.csv` | Dataset with real housing data |
| `bayesian_model.R` | Core R script to run the Bayesian regression |
| `HousePriceBayesian.Rmd` | RMarkdown report with code, plots, and interpretation |
| `README.md` | Project overview |

---

## 📦 R Packages Used

- `rstanarm` – for Bayesian regression
- `ggplot2` – for visualizations
- `posterior` / `bayesplot` (optional) – for posterior diagnostics

---

## 🚀 How to Run

```r
# Load dataset
house <- read.csv("Housing.csv")

# Load required packages
install.packages("rstanarm")
library(rstanarm)

# Fit Bayesian regression model
model <- stan_glm(price ~ sqft_living, data = house, family = gaussian())

# Predict price for a new house (1800 sqft)
new_house <- data.frame(sqft_living = 1800)
posterior_pred <- posterior_predict(model, newdata = new_house)

# Visualize prediction
hist(posterior_pred, main = "Posterior Prediction for 1800 sqft", col = "lightpink")
abline(v = mean(posterior_pred), col = "lightblue", lwd = 2)

# Show 95% credible interval
posterior_interval(model, newdata = new_house, prob = 0.95)

