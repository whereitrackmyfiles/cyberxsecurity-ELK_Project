#!/bin/bash
### Author: jgonz

###-Setup Options-###

_script_version="0.1.0"

function help {

    echo "Usage: $0 [OPTIONS]

    Synopsis:
    This script is designed to search for the Dealer working on a particular game. This script will prompt for an input from the user and will then use that input to match the Dealer, the date and the game that was requested. 

    Options:
        -v|version  This displays the current script version
        -h|help     This displays the help file for this script

    Arguments:
        DATE        This is the date of the file you want to search. Example 0310
        TIME        This is the time you want to search. Example 05:00:00
        TIMEOFDAY   This is either AM or PM.
    "
}


while getopts "vh" options; do
    case $options in

    v|version)
        echo "$0 Version $_script_version"
        exit 0
        ;;

    h|help)
        help
        exit 0
        ;;    
    
    \?)
    echo "Invalid option: -$OPTARG" >&2
    help
    exit 1
    ;;

    esac 
done

###-Variable Declarations-###


###-Main Script-###

echo "Please enter Time"
read lookup_time
echo "Please enter Time of day to check"
read lookup_timeofday
echo "Please enter Date (format should be DDMM)"
read lookup_date
echo "Please select a game (enter the number of the Game)"
echo "1: Blackjack"
echo "2: Roulette"
echo "3: Texas Hold'Em"
read lookup_game

echo "Game selected is $lookup_game"
if [[ $lookup_game -eq 1 ]]; then
  dealer='{ print $3,$4 }'
  game="Blackjack"
elif [[ $lookup_game -eq 2 ]]; then
  dealer='{ print $5,$6 }'
  game="Roulette"
elif [[ $lookup_game -eq 3 ]]; then
  dealer='{ print $7,$8 }'
  game="Texas Hold'Em"
else
  echoerr "Error: invalid argument. Please select between 1, 2 and 3."
  usage
  exit 1
fi


function get_dealer() {

    awk -F" " "$dealer"

}

function find_dealer_game() {

    grep -i "${lookup_time} ${lookup_timeofday}" ${lookup_date}_Dealer_schedule | get_dealer

}
dealer_found=$(find_dealer_game)

echo "The dealer for ${game} working on ${lookup_date} - ${lookup_time} ${lookup_timeofday} is ${dealer_found}"