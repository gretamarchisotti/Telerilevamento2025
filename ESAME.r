# load required packages
library(terra)

setwd("C:/Users/march/Desktop/BOLOGNA/II semestre/Telerilevamento geoecologico in R/ESAME")

# import raster
sentinel2024 <- rast("sentinel2_Canada2024.tif")
sentinel2024

# visualize RGB (check the order of the bands)
plotRGB(sentinel2024, r = 1, g = 2, b = 3, stretch = "lin", main = "Sentinel (median) 2024")

# import raster
sentinel2025 <- rast("sentinel2_Canada2025.tif")
sentinel2025

# visualize RGB (check the order of the bands)
plotRGB(sentinel2025, r = 1, g = 2, b = 3, stretch = "lin", main = "Sentinel (median) 2025")
