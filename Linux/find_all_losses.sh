#!/bin/bash
### Author: jgonz

###-Setup Options-###
_script_version="0.1.2"

###-Variable Declarations-###

function help {

    echo "Usage: $0 [OPTIONS] 

    Synopsis:
    This script is designed to search all losses from the files inside Player_Analysis. Once all the negative values (or losses) have been found, it will redirect it to the file Roulette_Losses. 

    Options:
        -v|version  This displays the current script version
        -h|help     This displays the help file for this script


    Arguments:
        $0 -v
        $0 -h

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

###-Main Script-###

echo "Searching for all losses"
pwd=$(pwd)
echo "current folder is $pwd"
grep "-" *_win_loss_player_data | sed 's/_win_loss_player_data:/ /g' >> Roulette_Losses
echo "Output file Roulette_Losses has been generated"
