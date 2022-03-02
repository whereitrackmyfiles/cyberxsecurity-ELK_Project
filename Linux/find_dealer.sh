#!/bin/bash
### Author: jgonz

###-Setup Options-###
_script_version="0.2.0"

###-Variable Declarations-###
_find_dir=$HOME

function help {

    echo "Usage: $0 [OPTIONS] -d SEARCH_DIR

    Options:
        -v|version  This displays the current script version
        -h|help     This displays the help file for this script
        -d|dir      This changes the current search folder from "$HOME" to the specified location
                    Requires an absolute or a relative path

    Arguments:
        $0 -d ~/Documents

    "
}

while getopts "vh:d" options; do
    case $options in

    v|version)
        echo "$0 Version $_script_version"
        exit 0
        ;;

    h|help)
        help
        exit 0
        ;;    
    

    -d|find_dir)
        _find_dir=$OPTARG
        exit 0
        ;;   

    \?)
    echo "Invalid option: -$OPTARG" >&2
    help
    exit 1
    ;;

    esac 
done

###-Main Script-###

echo "Searching for Lucky_Duck_Investigations folder in Home Dir"
function find_dir() {
find_lucky_duck_investigation_dir=$(find $_find_dir -type d -name "Lucky_Duck_Investigations")
}

find_dir

cd $find_lucky_duck_investigation_dir
echo "Folder is now $find_lucky_duck_investigation_dir"

echo "Setting folder to Dealer Analysis"
cd Dealer_Analysis/

roulette_losses=$(ls ../Player_Analysis/Roulette_Losses)


function find_dealer() {
dealer_search=$(grep "${2} ${3}" "${1}_Dealer_schedule"| awk -F" " '{print $1,$2,$5,$6}')
echo "$dealer_search"
}

echo "Reading Roulette_Losses file as input to find Dealers working during losses"

while IFS=" " read -r x y z
 do
 find_dealer $x $y $z >>Dealers_working_during_losses
done < $roulette_losses

echo "Generated Dealers_working_during_losses file in Dealer_Analysis folder"
