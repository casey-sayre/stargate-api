#!/bin/bash

API_URL_PERSON="https://localhost:7204/Person"
API_URL_DUTY="https://localhost:7204/AstronautDuty"

# Array of names
names=(
  "James Smith" "Mary Johnson" "John Williams" "Patricia Brown" "Robert Jones" "Jennifer Garcia" "Michael Miller" "Linda Davis" "William Rodriguez" "Elizabeth Martinez"
  "David Hernandez" "Barbara Lopez" "Richard Gonzalez" "Susan Wilson" "Joseph Anderson" "Jessica Thomas" "Thomas Taylor" "Sarah Moore" "Charles Jackson" "Margaret Martin"
  "George Lee" "Karen Perez" "Donald Thompson" "Lisa White" "Paul Harris" "Nancy Sanchez" "Mark Clark" "Betty Ramirez" "Andrew Lewis" "Sandra Robinson"
  "Steven Walker" "Sharon Young" "Edward Allen" "Carol Torres" "Brian Wright" "Ruth King" "Kevin Scott" "Michelle Green" "Gary Baker" "Laura Adams"
  "Timothy Nelson" "Kimberly Hill" "Jose Rivera" "Donna Mitchell" "Larry Roberts" "Emily Phillips" "Jeffrey Diaz" "Frank Cruz" "Angela Morales" "Amy Powell"
  "Scott Reed" "Melissa Gutierrez" "Eric Bell" "Stephanie Murphy" "Stephen Bailey" "Rebecca Sullivan" "Raymond Frazier" "Heather Webb" "Gregory Ellis" "Teresa Stephens"
  "Daniel Lawson" "Doris Porter" "Jerry Waters" "Evelyn Garrett" "Dennis Saunders" "Abigail Wise" "Walter Brewer" "Brittany Woodard" "Peter Knight" "Nicole Curtis"
  "Harold Lester" "Tammy Powers" "Carl Washington" "Kayla Bishop" "Henry Freeman" "Beverly Matthews" "Ryan Christina" "Roger Martha" "Joe Lauren" "Adam Judith"
  "Craig Alice" "Brandon Theresa" "Sean Olivia" "Philip Kathleen" "Roy Ann" "Wayne Maryann" "Billy Gloria" "Dale Virginia" "Todd Michelle" "Crystal Brandon"
)
NUM_USERS="${#names[@]}"

# Loop to create 100 user records
echo "Creating Person records..."
for i in $(seq 0 "$((NUM_USERS - 1))"); do
  API_PERSON_NAME="${names[$i]}"
  curl -k -X 'POST' "$API_URL_PERSON" \
    -H 'accept: */*' \
    -H 'Content-Type: application/json' \
    -d "\"$API_PERSON_NAME\""
  echo -e "Created Person $((i + 1)): $API_PERSON_NAME\n"
  sleep 0.1
done
echo "Person records creation complete.\n"

echo "Creating Astronaut Duty records..."
# Loop to add duties to specific users
for i in $(seq 0 "$((NUM_USERS - 1))"); do
  duty_rank=""
  duty_title="NONE"
  duty_start_date="1900-01-01T00:00:00.000Z"
  person_name="${names[$i]}"

  if [[ $((i % 3)) -eq 0 ]]; then
    duty_rank="Captain"
    duty_title="ISS"
    duty_start_date="2015-06-01T18:28:05.849Z"
  elif [[ $((i % 3)) -eq 1 ]]; then
    duty_rank="Major"
    duty_title="MARS"
    duty_start_date="2020-06-01T18:28:05.849Z"
  fi

  if [[ -n "$duty_rank" ]]; then
    duty_payload=$(jq -n --arg name "$person_name" --arg rank "$duty_rank" --arg dutyTitle "$duty_title" --arg dutyStartDate "$duty_start_date" '{"name": $name, "rank": $rank, "dutyTitle": $dutyTitle, "dutyStartDate": $dutyStartDate}')
    curl -k -X 'POST' "$API_URL_DUTY" \
      -H 'accept: */*' \
      -H 'Content-Type: application/json' \
      -d "$duty_payload"
    echo -e "Added Duty '$duty_title' to Person: $person_name\n"
    sleep 0.1
  fi
done

echo "Astronaut Duty records creation complete."