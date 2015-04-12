# Load the data and process it.
# For details on what exactly happens in this phase, please read the comments
# in the 'load.R' file (they're important).
source('load.R')

# Open up the PNG device (with transparent background, like Roger Peng's
# original png files)
png('plot4.png', width = 480, height = 480, bg = 'transparent')

# We want 4 plots in a 2x2 layout, with row-wise filling.
par(mfrow = c(2,2))

# The plotting instructions.
# 'ds' is a data.frame created when sourcing the 'load.R' file.
with(ds, {
  # Upper left plot
  plot(DateTime, Global_active_power, type = 'l',
       ylab = 'Global Active Power', xlab = '')

  # Upper right plot
  plot(DateTime, Voltage, type = 'l', xlab = 'datetime')

  # Lower left plot
  # For details on the making of this particular subplot please read the
  # comments in file 'plot3.R'.
  plot(DateTime, Sub_metering_1, type = 'l',
       ylab = 'Energy sub metering', xlab = '')
  lines(DateTime, Sub_metering_2, type = 'l', col = 'red')
  lines(DateTime, Sub_metering_3, type = 'l', col = 'blue')
  legend('topright', legend = names(ds)[5:7],
         bg = 'transparent', bty = 'n',       # required for a borderless legend
         col = c('black', 'red', 'blue'), lty = c(1, 1, 1))

  # Lower right plot
  plot(DateTime, Global_reactive_power, type = 'l', xlab = 'datetime', ylim = c(0, 0.5))
})

# Close the PNG device.
# We wrap the 'dev.off()' call in 'invisible()' to hide the "null device 1"
# text that 'dev.off()' usually prints.
invisible(dev.off())
