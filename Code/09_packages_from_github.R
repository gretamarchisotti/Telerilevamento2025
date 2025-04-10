# R code for intsalling packages from GitHub

# From GitHub:
# intsall.packages("devtools")
library(devtools) # or remotes
install_github("ducciorocchini/cblindplot")
library(cblindplot)

install_github("clauswilke/colorblindr")
library(colorblindr)

# From CRAN:
install.packages("colorblindcheck")
library(colorblindcheck)
