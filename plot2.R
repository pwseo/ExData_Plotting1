# Load the data and process it.
# For details on what exactly happens in this phase, please read the comments
# in the 'load.R' file (they're important).
source('load.R')

# Open up the PNG device (with transparent background, like Roger Peng's
# original png files)
png('plot2.png', width = 480, height = 480, bg = 'transparent')

# The plotting instructions.
# 'ds' is a data.frame created when sourcing the 'load.R' file.
plot(ds$DateTime, ds$Global_active_power,
     xlab = "",   # empty x axis label
     ylab = "Global Active Power (kilowatts)",
     type = 'l')  # lines instead of points

# Close the PNG device.
# We wrap the 'dev.off()' call in 'invisible()' to hide the "null device 1"
# text that 'dev.off()' usually prints.
invisible(dev.off())
