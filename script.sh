#! /bin/bash


# pull weather data into file

date=$(date "+%Y_%m_%d")
file_name=raw_data_$date

curl wttr.in --output $file_name
echo $file_name

# extract data from file to get weather data

if [ -e $file_name ]; then
	echo "raw data exist"
	obs_temp=$(sed -n '13p' $file_name | cut -d 'C' -f 2 | cut -d '+' -f 2 | cut -d '(' -f 2 |  cut -d ')' -f 1)
	fc_temp=$(sed -n '23p' $file_name | cut -d 'C' -f 2 | cut -d '+' -f 2 | cut -d '(' -f 2 |  cut -d ')' -f 1)
	year=$(date '+%Y')
	month=$(date '+%m')
	day=$(date '+%d')
	echo $obs_temp
	echo $year
	
	# store data to report file
	record=$(echo -e "$year\t$month\t$day\t$obs_temp\t$fc_temp")
	echo $record >> rx_poc.log
else
	echo "raw data not exist"

fi


