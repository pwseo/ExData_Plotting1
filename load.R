# Exploratory Data Analysis
# Course Project 1
# António Pedro Cunha (pwseo)

# URL, zip file and txt file names for the data
data.url <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
data.zip <- 'exdata_data_household_power_consumption.zip'
data.txt <- 'household_power_consumption.txt'

# If the 'household_power_consumption.txt' file doesn't exist, the script will try to
# extract it from the original data zipfile.  If the zip file itself doesn't exist as
# well, the script will download it (should work in both Windows and non-Windows)
if (!file.exists(data.txt)) {
  if (!file.exists(data.zip)) {
    message(paste('Downloading data to', data.zip))
    if (Sys.info()[['sysname']] == 'Windows') {
      setInternet2(use = T)
      download.file(data.url, destfile = data.zip, quiet = T)
    } else {
      download.file(data.url, destfile = data.zip, quiet = T, method = 'curl')
    }
  }
  message(paste('Unzipping', data.zip))
  unzip(data.zip)
}

# As per the README.md, we don't need to load the complete dataset into R;
# we need only the lines regarding to dates from 1/2/2007 to 2/2/2007.
# By simple inspection of the data, we can see that the relevant lines are
# 66638 through 69517 (total of 2880 lines):
ds <- read.csv(data.txt, header = F, sep = ';',
               na.strings = '?',            # convert '?' to NA
               skip = 66637, nrow = 2880)   # load only the relevant lines

# Read the column names from the original data.
# We read just the first line from the data (the header) into a data.frame
# and then assign names(ds) to the names from that data.frame.
names(ds) <- names(read.csv(data.txt, header = T, sep = ';', nrow = 1))

# Merge both 'Date' and 'Time' columns in a single 'DateTime' column, since
# we cannot represent 'Time' without an associated 'Date'.
ds$DateTime <- strptime(paste(ds$Date, ds$Time), format = '%d/%m/%Y %H:%M:%S')

# Remove the old 'Date' and 'Time' columns
ds <- subset(ds, select = -c(Date, Time))

# So, ds is now a data.frame with 8 columns: the original Date and Time columns
# have been deleted, so the 'Global_active_power' through 'Sub_metering_3' columns
# have been shifted from positions 3:9 to 1:7.
# DateTime now occupies the 8th position.

# Set the current locale to 'C'.
# This command is important to get the correct weekday abbreviations in the
# plots -- 'Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat' -- instead of
# using the locale of the computer running the script (portuguese, in my case).
Sys.setlocale(category = 'LC_ALL', locale = 'C')
