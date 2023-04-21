#!/bin/bash -x

pushd ~/Documents/UNTPublicSurplusBot/

url="https://www.publicsurplus.com/sms/unt,tx/browse/search?posting=y&endHours=-1&startHours=25&highlight=Y&region=unt,tx"

no_surplus_string="No auctions found"
#This is a file where your webhook endpoint URL is
#The file might not be allowed to have a newline in it, so use printf "<URL>" >> webhookURL.txt
post_url=$(cat ./webhookURL.txt)

# Set a default path if $1 is not defined
json_path=${1:-Surplus.json}

#Request the html from the url
response=$(curl -s "$url")
# If the string is not found in the html
if [[ $response != *"$no_surplus_string"* ]]; then
	echo "There's surplus!"
	date
	# Send a POST request with the JSON file
	curl -X POST -H "Content-Type: application/json" -d "@$json_path" "$post_url"
else
	echo "No surplus today"
	date
fi

popd
