# Load the data and process it.
# For details on what exactly happens in this phase, please read the comments
# in the 'load.R' file (they're important).
source('load.R')

# Open up the PNG device (with transparent background, like Roger Peng's
# original png files)
png('plot3.png', width = 480, height = 480, bg = 'transparent')

# The plotting instructions.
# 'ds' is a data.frame created when sourcing the 'load.R' file.
with(ds, {
  # Plot the first variable (Sub_metering_1) and simultaneously define the axes.
  plot(DateTime, Sub_metering_1,
       ylab = "Energy sub metering", xlab = "",  # set up the axes' labels
       type = 'l')                 # black (default) line
  # Plot the second variable (Sub_metering_2)
  lines(DateTime, Sub_metering_2,
        col = 'red', type = 'l')   # red line
  # Plot the third variable (Sub_metering_3)
  lines(DateTime, Sub_metering_3,
        col = 'blue', type = 'l')  # blue line

  # Now plot the legend
  legend('topright', legend = names(ds)[5:7], # use names directly from the dataset
         col = c('black', 'red', 'blue'),     # color the legend's lines
         lty = c(1, 1, 1))                    # type of the legend's lines
})

# Close the PNG device.
# We wrap the 'dev.off()' call in 'invisible()' to hide the "null device 1"
# text that 'dev.off()' usually prints.
invisible(dev.off())
