#!/bin/bash
PS3="Select a number: "
select option in "Option 1" "Option 2" "Option 3" "Quit"
do
    case $option in
        "Option 1")
            telepresence="C:\telepresence\telepresence.exe"
            "$telepresence" "connect"
            cd "C:\telepresence"
            ;;
        "Option 2")
            echo "You chose Option 2"
            cd "%USERPROFILE%\Documents"
            ;;
        "Option 3")
            echo "You chose Option 3"
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
