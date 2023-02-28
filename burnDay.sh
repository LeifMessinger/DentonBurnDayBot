#!/bin/bash

url="https://www.dentoncountyesd1.gov/wp-content/uploads/scripts/burnday.php"
#TODO: Use the "It's a burn day" string instead, so no false positives. Have to wait for a burn day to make sure that's the right text.
burn_day_string="is a burn day"
#This is a file where your webhook endpoint URL is
#The file might not be allowed to have a newline in it, so use printf "<URL>" >> webhookURL.txt
post_url=$(cat ./webhookURL.txt)

# Set a default path if $1 is not defined
json_path=${1:-TisBurnDay.json}

#Request the html from the url
response=$(curl -s "$url")
# If the string is not found in the html
if [[ $response == *"$burn_day_string"* ]]; then
	echo "It's a burn day!"
	date
	# Send a POST request with the JSON file
	curl -X POST -H "Content-Type: application/json" -d "@$json_path" "$post_url"
else
	echo "Not a burn day. No message sent."
fi
