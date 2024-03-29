#!/bin/bash -x

pushd ~/Documents/DentonBurnDayBot/

#This link no longer works :(
#url="https://www.dentoncountyesd1.gov/wp-content/uploads/scripts/burnday.php"
url="https://apps.dentoncounty.gov/website/publicburncontrol/Default"

#TODO: Use the "It's a burn day" string instead, so no false positives. Have to wait for a burn day to make sure that's the right text.
#burn_day_string="is a burn day"
#New strategy
#TODO: Use the "It's a burn day" string instead, so no false positives. Have to wait for a burn day to make sure that's the right text.
burn_day_string="Images/BurndayYes2.jpg"

#This is a file where your webhook endpoint URL is
#The file might not be allowed to have a newline in it, so use printf "<URL>" >> webhookURL.txt
post_url=$(cat ./webhookURL.txt)

# Set a default path if $1 is not defined
tisBurnDayJSON=${1:-TisBurnDay.json}

# Set a default path if $1 is not defined
notBurnDayJSON=${1:-NotBurnDay.json}

#Request the html from the url
curl -s "$url" > /tmp/burnDayScrape.txt
# If the string is not found in the html
if grep "$burn_day_string" /tmp/burnDayScrape.txt; then
	echo "It's a burn day!"
	date
	# Send a POST request with the JSON file
	curl -X POST -H "Content-Type: application/json" -d "@$tisBurnDayJSON" "$post_url"
else
	echo "It's not a burn day. :("
	date
	# Send a POST request with the JSON file
	curl -X POST -H "Content-Type: application/json" -d "@$notBurnDayJSON" "$post_url"
fi

popd
