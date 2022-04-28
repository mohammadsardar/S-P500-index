#simulating a dataset that we can use.

library(tidyverse)




simulated_sandp <-
  tibble(
    #these are the years that we have. I will take 200 years to make it simpler
    'year' = 1820:2019,
    # taking real price as a uniformly distributed variable
    'real_price' = round(runif(200, 50, 2000)),
    # taking real dividends as a uniformly distributed variable
    'real_dividend' = round(runif(200, 5, 50)),
    # taking real earnings as a uniformly distributed variable
    'real_earnings' = round(runif(200, 1, 40)),
    # taking cpi as a uniformly distributed variable
    'consumer_price_index' = round(runif(200, 1, 250)),
    # taking long term interest rate as a uniformly distributed variable
    'interest_rate' = runif(200, -0.1, 10)
  )
