#! /bin/bash

# guliver's travels
response=$(curl -sSL 'https://www.gutenberg.org/files/829/829-h/829-h.htm' \
  -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9' \
  -H 'Accept-Language: en-US,en;q=0.9,fr;q=0.8' \
  -H 'Cache-Control: max-age=0' \
  -H 'Connection: keep-alive' \
  -H 'DNT: 1' \
  -H 'Referer: https://www.google.com/' \
  -H 'Sec-Fetch-Dest: document' \
  -H 'Sec-Fetch-Mode: navigate' \
  -H 'Sec-Fetch-Site: cross-site' \
  -H 'Sec-Fetch-User: ?1' \
  -H 'Upgrade-Insecure-Requests: 1' \
  -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.54 Safari/537.36' \
  -H 'sec-ch-ua: " Not A;Brand";v="99", "Chromium";v="101", "Google Chrome";v="101"' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'sec-ch-ua-platform: "macOS"' \
  --compressed)

body="$response.body"
body_length=${#body}


# prime number
function check_prime() 
{ 
	for ((divisor=2; divisor<=candidate_prime/2; divisor++))
	do
	  ans=$(( candidate_prime%divisor ))
	  if [ $ans -eq 0 ]
	  then
	  	echo "was not a prime"
	    return 1
	  fi
	done
	echo "was prime"
	return 0
}

prime_count=0
candidate_prime=1
while ((prime_count<5))
do
	echo "candidate prime number: $candidate_prime"
	if check_prime $candidate_prime
	then 
		((prime_count++))
		mkdir "$candidate_prime"
		segment_length=$((body_length/5))
		start=$(((prime_count - 1) * segment_length))
		text_segment=${body:$start:$segment_length}
		filename="$candidate_prime" 
		filename+="/"
		filename+="$candidate_prime" 
		filename+=".txt"
		echo "filename was: $filename"
		echo "$text_segment" > "$candidate_prime/$candidate_prime" + ".txt"
	fi
	((candidate_prime++))
	echo "total found prime's was $prime_count"
done







