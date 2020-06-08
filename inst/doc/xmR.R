## ---- message=FALSE, echo = F-------------------------------------------------
library(xmrr)
library(tidyr)
library(ggplot2)
library(dplyr)
library(tibble)
set.seed(1)
Measure <- round(runif(12, min = 0.50, max = 0.66)*100, 0)
Measure <- c(Measure, round(runif(6, min = 0.70, max = .85)*100, 0))
Time <- c(2000:2017) 
example_data <- data.frame(Time, Measure)
knitr::kable(example_data, format = "markdown", align = 'c')

## ---- message=FALSE, eval = F-------------------------------------------------
#  xmr_data <- xmr(df = example_data, measure = "Measure")

## ---- message=FALSE, eval = F-------------------------------------------------
#  xmr_data <- xmr(df = example_data, measure = "Measure", recalc = T)

## ---- echo=F, message=FALSE, warning = F, eval=F------------------------------
#  xmr_data <- xmr(example_data, "Measure",
#                  recalc = T) %>%
#    as_tibble() %>%
#    select(-Order)
#  knitr::kable(xmr_data, format = "markdown", align = 'c')

## ---- message = FALSE,eval=F--------------------------------------------------
#  xmr_data <- xmr(example_data,  "Measure",
#                  recalc = T,
#                  interval = 5,
#                  shortrun = c(3,4),
#                  longrun = c(5,8))

## ---- message = FALSE, eval = F-----------------------------------------------
#  xmr_data <- xmr(df = example_data,
#                  measure = "Measure",
#                  recalc = T,
#                  #change the rule like so:,
#                  interval = 4,
#                  shortrun = c(2,3))

## ---- fig.height=5, fig.width=7, warning=F, eval = F--------------------------
#  xmr_chart(xmr_data,
#            time = "Time",
#            measure = "Measure",
#            line_width = 0.75, text_size = 12, point_size = 2.5)

## ---- eval = F----------------------------------------------------------------
#  example_data %>%
#    xmr("Measure", recalc = T) %>%
#    xmr_chart("Time", "Measure")

## ---- message=FALSE, echo = F-------------------------------------------------
library(xmrr)
library(dplyr)
`Year` <- seq(2004, 2017, 1)
Variable <- "A"
FDA <- data.frame(`Year`, Variable, check.names = F)
Variable <- "B"
FDB <- data.frame(`Year`, Variable, check.names = F)
MFD <- rbind(FDA, FDB) %>% as_tibble()

MFD$Measure <- runif(nrow(MFD))*100
MFD$Measure <- round(MFD$Measure, 0)
knitr::kable(MFD, format = "markdown", align = 'c')

## ---- eval = F----------------------------------------------------------------
#  #this installs many useful packages
#  install.packages("tidyverse")
#  
#  #this just loads the ones we need
#  library(dplyr)
#  library(purrr)
#  library(ggplot2)

## ---- eval = F----------------------------------------------------------------
#  MFD_xmr <- MFD %>%
#    group_split(Variable)  %>%
#    map(xmr, measure = "Measure", recalc = T) %>%
#    map_df(as_tibble)

## ---- echo=FALSE, eval = F----------------------------------------------------
#  knitr::kable(MFD_xmr, format = "markdown", align = 'c')

## ---- fig.height=5, fig.width=7, eval = F-------------------------------------
#  MFD_xmr %>%
#    xmr_chart("Year", "Measure", line_width = 0.75, text_size = 12) +
#    facet_wrap(~Variable) +
#    scale_x_discrete(breaks = seq(2004, 2017, 4))

