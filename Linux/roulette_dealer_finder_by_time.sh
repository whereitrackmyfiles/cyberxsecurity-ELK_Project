#!/bin/bash
### Author: jgonz

###-Setup Options-###

_script_version="0.1.4"

function help {

    echo "Usage: $0 [OPTIONS] DATE TIME TIMEOFDAY

    Synopsis:
    This script is designed to accept an option from the user which is the date and time of the day and search for the Roulette Dealer working on those specified option. 

    Options:
        -v|version  This displays the current script version
        -h|help     This displays the help file for this script

    Arguments:
        DATE        This is the date of the file you want to search. Example 0310 (The format should be strictly followed)
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

lookup_date=$1
lookup_time=$2
lookup_timeofday=$3


###-Main Script-###
function roulette_dealer_finder {

awk -F" " '{print $5, $6}'

}

roulette_dealer=$(grep "${lookup_time} ${lookup_timeofday}" "${lookup_date}"_Dealer_schedule | roulette_dealer_finder )

echo "The dealer during the specified time is $roulette_dealer"