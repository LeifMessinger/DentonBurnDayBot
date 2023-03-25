#!/bin/bash -x

pushd ~/Documents/UNTPublicSurplusBot/

url="https://www.publicsurplus.com/sms/unt,tx/browse/search?posting=y&slth=&page=0&sortBy=&keyWord=&catId=-1&endHours=-1&startHours=24&lowerPrice=0&higherPrice=0&milesLocation=-1&zipCode=&region=unt%2Ctx&search=Search"

no_surplus_string="No auctions found"
#This is a file where your webhook endpoint URL is
#The file might not be allowed to have a newline in it, so use printf "<URL>" >> webhookURL.txt
post_url=$(cat ./webhookURL.txt)

# Set a default path if $1 is not defined
surplusJSON=${1:-Surplus.json}

# Set a default path if $1 is not defined
noSurplusJSON=${2:-NotBurnDay.json}

#Request the html from the url
response=$(curl -s "$url")
# If the string is not found in the html
if [[ $response != *"$no_surplus_string"* ]]; then
	echo "There's surplus today!"
	date
	# Send a POST request with the JSON file
	curl -X POST -H "Content-Type: application/json" -d "@$noSurplusJSON" "$post_url"
else
	echo "No surplus today. :("
	date
	# Send a POST request with the JSON file
	curl -X POST -H "Content-Type: application/json" -d "@$surplusJSON" "$post_url"
fi

popd
