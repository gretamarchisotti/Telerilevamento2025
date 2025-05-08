# Presentation title

## Data gathering

Data were **gathered** from the [Earth Observatory site](https://earthobservatory.nasa.gov/)

Package used:

```r
library(terra)
library(imageRy)
library(viridis) #in order to plot images with different viridis color ramp palettes
```

Setting the working directory and importing the data:
```r
setwd("C:/Users/march/Desktop/BOLOGNA/II semestre/Telerilevamento geoecologico in R")
dust = rast("dust.jpg")
plot(dust)
dust = flip(dust)
plot(dust)
```

The image looks like:

![dust](https://github.com/user-attachments/assets/672ff544-1b6a-4ff1-a9b2-866b99a6874d)

## Data analysis

Based on the data gathered, we can calcute the following index:

```r
dustindex = dust[[1]]-dust[[3]]
plot(dustindex)
```

The output image is the following:

![dustindex](https://github.com/user-attachments/assets/3d7329dd-e6a3-4841-9427-6399ce3ed717)

## Correlation of bands

Since the RGB is composed by visibile bands, a high correlation is expected:

```r
pairs(dust)
```

This is also graphically apparent:

![pairdust](https://github.com/user-attachments/assets/29c14f23-8bce-42a7-a565-6ea69d2439b1)

## Visualization of the image

The visualization of the index can be changed to any viridis palette:

```r
plot(dustindex, col=inferno(100))
```

The image will look like:

![dustindex_inf](https://github.com/user-attachments/assets/472e67d9-505d-45d8-aa07-6703d56e62db)
