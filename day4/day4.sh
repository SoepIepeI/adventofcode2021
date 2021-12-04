#!/bin/bash

INDEX=0
NUMBERS_TO_CHECK=()
CURRENT_CARD=0
LOWEST_CARD=0
LOWEST_CARD_COUNT=0
while read cardRow; do
    if [[ $INDEX == 0 ]]
        then
            IFS=',' read -ra NUMBERS_TO_CHECK <<< "$cardRow"
            ((INDEX++))
            continue
    fi

    if [[ -z "$cardRow" ]]
        then
            ((INDEX++))
            ((CURRENT_CARD++))
            continue
    fi

    IFS=' ' read -ra cardColumns <<< "$cardRow"
    IFS=' ' read -ra numbers <<< "${NUMBERS_TO_CHECK[@]}"
    COUNT=0
    MATCHES=0
    for number in ${numbers[@]}
        do
            if [[ "$MATCHES" == 5 ]]
                then
                    echo "BINGO!"
                    echo "$CURRENT_CARD" 
                    echo "$COUNT" 

                    if [[ "$LOWEST_CARD_COUNT" == 0 ]]
                        then
                            LOWEST_CARD="$CURRENT_CARD"
                            LOWEST_CARD_COUNT="$COUNT"
                            continue
                    fi

                    if [[ "$LOWEST_CARD_COUNT" > "$COUNT" ]]
                        then
                            LOWEST_CARD="$CURRENT_CARD"
                            LOWEST_CARD_COUNT="$COUNT"
                    fi
                    continue 2
            fi

            ((COUNT++))
            for cardColumn in ${cardColumns[@]} 
                do
                    if [[ (( $number -eq $cardColumn )) ]]
                        then
                            ((MATCHES++))
                            continue 2
                    fi
            done
    done

    

    ((INDEX++))
# done <day4.txt
done <day4_test.txt

echo " LOWEST CARD "
echo "$LOWEST_CARD"
echo " WITH " 
echo "$LOWEST_CARD_COUNT"