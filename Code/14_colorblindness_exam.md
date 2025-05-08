# Code to solve colorblindness problems

## Packages

The packages used in this script are the following

```r
library(terra)
library(imageRy)
```

## Installing cblindplot

In order to install cblindplot form GitHub follow these instructions:

```r
library(devtools)
install_github("ducciorocchini/cblindplot")
library(cblindplot)
```

## Importing data

Data can be imported by:

```r
setwd("C:\Users\march\Desktop\BOLOGNA\II semestre\Telerilevamento geoecologico in R")
vinicunca = rast("vinicunca.jpg")
plot(vinicunca)
vinicunca = flip(vinicunca)
plot(vinicunca)
```

## Simulating colorblindness

Code to simulate colorblindness

```r
im.multiframe(2,1)
im.plotRGB(vinicunca, r=1, g=2, b=3, title="Standard Vision")
im.plotRGB(vinicunca, r=2, g=1, b=3, title="Protanopia")
```

The simulated image looks as follows:

![vinicunca_out](https://github.com/user-attachments/assets/d6b710c6-3d5d-4a72-94a8-369581473b1c)

## Solving colorblindness

In order to solve colorblindness issues, the *cblind.plot()* function can be used:

```r
dev.off()
rainbow=rast("rainbow.jpg")
plot(rainbow)
rainbow = flip(rainbow)
plot(rainbow)
cblind.plot(rainbow, cvd="protanopia")
cblind.plot(rainbow, cvd="deuteranopia")
cblind.plot(rainbow, cvd="tritanopia")
```

As an example, a person affected by protanopia can view a rainbow color image as:

![rainbow_out](https://github.com/user-attachments/assets/07818983-b907-4c1b-8fd3-f460f9f415c5)
