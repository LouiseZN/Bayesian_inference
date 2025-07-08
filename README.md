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
# Load dataset of the prices of the houses and their sqr fotege 
house <- read.csv("Housing.csv")

# Load rstanarm
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
```r
---

## 📊 Results 


Modela a incerteza dos parâmetros usando:
Distribuições a priori para os coeficientes (como Normal(0,10));

Inferência bayesiana com MCMC (amostragem de Monte Carlo via Cadeias de Markov);

Distribuições a posteriori dos parâmetros, que refletem a incerteza após observar os dados.

Model Info:
 function:     **stan_glm**
  -> The model was fitted using the stan_glm() function.
 family:       gaussian [identity]
  -> The model assumes that the data follow a normal (Gaussian) distribution with an identity link function (i.e., the expected value of price is modeled directly as a linear function of sqft_living)
 formula:      price ~ sqft_living
  -> The model formula: price is predicted based on sqft_living (square footage of the house).
 algorithm:    sampling
  -> The model was estimated using MCMC sampling (not approximations such as variational Bayes).
 sample:       4000 (posterior sample size)
  -> A total of 4000 posterior samples were drawn (typically the sum across all chains after burn-in).
 priors:       see help('prior_summary')
  -> The priors used are the defaults from the rstanarm package, which are generally weakly informative (e.g., normal(0, 10) for coefficients).
 observations: 21613
  -> The number of data points (rows) used to fit the model.
 predictors:   2
  -> The model includes two predictors: sqft_living and the intercept (β₀).

The function stan_glm is the Baysian of the function glm(), that represent a generalized vergion of a linar regretion.
This function calculetes the incertanty of the parameters used, and not the max likelyhood.
that represents:
price<sub>i</sub> ~ N(β₀ + β₁ × sqft<sub>i</sub>, σ²)


**Estimates:**

              mean     sd       10%      50%      90%   
(Intercept) -43560.2   4374.4 -49193.5 -43538.5 -37956.5
sqft_living    280.6      1.9    278.1    280.6    283.1
sigma       261497.3   1251.5 259869.9 261513.2 263055.7

  -> sqft_living - Quanto o preço da casa aumenta, em média, a cada 1 unidade adicional de área útil.
  -> Sigma - O desvio padrão do erro (variabilidade não explicada pelo modelo).

**sqft_living = 280.6 → Um metro quadrado adicional aumenta o preço em média 280,6 unidades monetárias, com incerteza pequena (sd = 1.9)**

Fit Diagnostics:
           mean     sd       10%      50%      90%   
mean_PPD 540076.4   2508.5 536827.4 540117.1 543273.7

  -> mean_PPD - média da distribuição posterior preditiva (Posterior Predictive Distribution) para o preço.

**MCMC diagnostics**
              mcse Rhat n_eff
(Intercept)   72.9  1.0 3604  
sqft_living    0.0  1.0 3749 
sigma         24.6  1.0 2579 
mean_PPD      47.1  1.0 2838 
log-posterior  0.0  1.0 1596

  -> mcse - erro padrão causado pela amostragem MCMC
  -> Rhat - Diagnóstico de convergência — deve estar perto de 1.0!
  -> n_eff - Tamanho efetivo da amostra — quanto maior, melhor! (reflete independência)

For each parameter, mcse is Monte Carlo standard error, n_eff is a crude measure of effective sample size, and Rhat is the potential scale reduction factor on split chains (at convergence Rhat=1).

# 📌 Conclusion
The model indicates a positive and statistically significant linear relationship between the size of the house (sqft_living) and its price. Specifically, the estimated coefficient suggests that, on average, each additional square foot increases the house price by approximately 280.60 units.

However, the residual standard deviation is quite high (~261,500), which implies that a large portion of the variability in house prices is not explained by size alone. This suggests that other factors—such as location, number of rooms, or property condition—likely play an important role and should be considered in future models.

The Bayesian estimation was performed successfully using MCMC, and the diagnostics (e.g., Rhat = 1.0 and high effective sample sizes) indicate strong convergence and reliable posterior estimates.

In summary, the model captures a clear trend between square footage and price but highlights the need for additional predictors to improve accuracy and reduce uncertainty.


