# Ice melt in greenland
# proxy: LST- land surface temperature. it is a measurement of the temperature at the land level: soil or the highest part of vegetation.
# proxy is a variable that can substitute another. In this case we expect that the higher the T the higher the melt

# Let's set wd and recall all packages
# remember: set wd and import data every time since R is creating temporary data for raster files, data are stored in R as temporary files so it is better to reupload every time the data
setwd("C:/lab/greenland/")
library(raster)
library(ggplot2)
library(RStoolbox)
library(patchwork)
library(viridis)

# we've downloaded "data greenland" file from virtuale and we've put it inside the greenland folder we've created as a subfolder of lab folder
# let's create a list of these files. their common pattern is "lst"
rlist <- list.files(pattern="lst")
rlist
# we can see they are single layers images so to import them we use lapply function to apply the raster function to the list
import <- lapply(rlist, raster)
import
# now with import we can see the list of our files imported as raster layers, with all their properties presented.
# es we can see the variability of the values which is between 0 to 65535
# 65535 means 16 bit images since 2^16=65535 values

# let's create a stack: cluster all the files together and treat them as a single file
tgr <- stack(import)
tgr # u can see the total n of cells and pixels, very huge

#Let's plot the all stack
cl <- colorRampPalette(c("blue", "light blue", "pink", "yellow"))(100)
plot(tgr, col=cl)
# the final plot will have the yellow representing the highest temperature and blue the lowest
# very low temperature in 2000 but along years it increases:
# in 2010 and 2015 most of all, the areas with lower T are decreasing, the blue is rarefing meaning the temperature is increasingall external areas has lower temperature

# now ggplot of the first and final images: 2000 vs 2015

# ggplot for 2000: "p1"
p1 <- ggplot() +
geom_raster(tgr$lst_2000, mapping = aes(x=x, y=y, fill=lst_2000)) +
scale_fill_viridis(option="magma")
ggtitle("LST in 2000")
# black color represent the temperature 

# ggplot for 2015 "p2"
p2 <- ggplot() +
geom_raster(tgr$lst_2015, mapping = aes(x=x, y=y, fill=lst_2015)) +
scale_fill_viridis(option="magma") +
ggtitle("LST in 2015")
# here the black color (low T) has a lower amount of spread in space that means there are higher T

#let's plot them together:
p1 + p2
# here u see well that T of 2000 was quite lower with respect to the one in 2015
# the main point is that the lower temperatures, the ones guaranteing ice are decreasing in space, sore higher t are all around the core part of greenland
# in extreme environment u can see direct effects of climate change

# now let's look at the distribution of these data with histograms
# notes: explains how the distribution is changing

# plotting frequency sistributions of data
par(mfrow=c(1, 2))
hist(tgr$lst_2000)
hist(tgr$lst_2015)

# in 20015 2 picks. anomaly, strange distribution


par(mfrow=c(2, 2))
hist(tgr$lst_2000)
hist(tgr$lst_2005)
hist(tgr$lst_2010)
hist(tgr$lst_2015)

# let's plot 2010 and 2015 (notes) to see if we have increasing temperature trend
# Xlim and ylim are needed to let the line starting form the conjuction between the 2 axis
plot(tgr$lst_2010, tgr$lst_2015, xlim=c(12500,15000), ylim=c(12500,15000))
abline(0,1,col="red")
# all the first block of dots is higher in 2015 then 2010 since basically all the points are above the line

# make a plot with all the histograms and all the regressions for all the variables
par(mfrow=c(4,4))
hist(tgr$lst_2000)
hist(tgr$lst_2005)
hist(tgr$lst_2010)
hist(tgr$lst_2015)
plot(tgr$lst_2000, tgr$lst_2005, xlim=c(12500,15000), ylim=c(12500,15000))
plot(tgr$lst_2000, tgr$lst_2010, xlim=c(12500,15000), ylim=c(12500,15000))
plot(tgr$lst_2000, tgr$lst_2015, xlim=c(12500,15000), ylim=c(12500,15000))
plot(tgr$lst_2005, tgr$lst_2010, xlim=c(12500,15000), ylim=c(12500,15000))
plot(tgr$lst_2005, tgr$lst_2015, xlim=c(12500,15000), ylim=c(12500,15000))
plot(tgr$lst_2010, tgr$lst_2015, xlim=c(12500,15000), ylim=c(12500,15000))
plot(tgr$lst_2000, tgr$lst_2005, xlim=c(12500,15000), ylim=c(12500,15000))
abline(0,1,col="red")
plot(tgr$lst_2000, tgr$lst_2010, xlim=c(12500,15000), ylim=c(12500,15000))
abline(0,1,col="red")
plot(tgr$lst_2000, tgr$lst_2015, xlim=c(12500,15000), ylim=c(12500,15000))
abline(0,1,col="red")
plot(tgr$lst_2005, tgr$lst_2010, xlim=c(12500,15000), ylim=c(12500,15000))
abline(0,1,col="red")
plot(tgr$lst_2005, tgr$lst_2015, xlim=c(12500,15000), ylim=c(12500,15000))
abline(0,1,col="red")
plot(tgr$lst_2010, tgr$lst_2015, xlim=c(12500,15000), ylim=c(12500,15000))
abline(0,1,col="red")

# but we are lazy people we don't want to run all these line of code 
# we can achieve the same result by using the stack thanks to the pairs function
# pairs funciton creates scatterplot matrices
pairs(tgr)
# we have 4 histograms since we have 4 variables and then we compare variables
# to know how many plot u will have for comparisons between N variables is [N(N-1)]/2
# so in this case 4 histograms and 6 comparisons
# let's cocompare lst200 with lst20015 there is a kind of head of datas, that are the lower temperature that in 2015 are higher than in 2000, they are above the abline
# especially u can see the anomaly in the histogram of 2015
# it means there is a rise especially in the lowest temperature that are those guaranteing the ice to be there otherwise there is ice melt, that is what we are experiencing in fact
# it is the same we have said by observing the graph
