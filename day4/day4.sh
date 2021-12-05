#!/bin/bash

INDEX=0
CURRENT_ROW=0
NUMBERS_TO_CHECK=()
CURRENT_CARD=0
LOWEST_CARD=0
LOWEST_CARD_COUNT=0
LOWEST_CARD_TOTAL_ROW_NUMBER=0
NUMBERS_USED_FOR_LOWEST_CARD=()
WINNING_NUMBER=0
CARDS=()
MATCHED_NUMBERS=()
while read cardRow; do
    ((CURRENT_ROW++))
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
            CARDS[$CURRENT_CARD]=""
            continue
    fi
    
    CARDS[$CURRENT_CARD]="${CARDS[$CURRENT_CARD]} $CURRENT_ROW"

    IFS=' ' read -ra cardColumns <<< "$cardRow"
    IFS=' ' read -ra numbers <<< "${NUMBERS_TO_CHECK[@]}"
    COUNT=0
    MATCHES=0
    NUMBERS_USED_FOR_CARD=()
    for number in ${numbers[@]}
        do
            ((COUNT++))
            NUMBERS_USED_FOR_CARD=("${NUMBERS_USED_FOR_CARD[@]}" "$number")

            for cardColumn in ${cardColumns[@]}
                do
                    if [[ (( $number -eq $cardColumn )) ]]
                        then
                            ((MATCHES++))
                            if [[ "$MATCHES" == 5 ]]
                                then
                                    if [[ "$LOWEST_CARD_COUNT" == 0 ]]
                                        then
                                            LOWEST_CARD="$CURRENT_CARD"
                                            LOWEST_CARD_COUNT="$COUNT"
                                            MATCHED_NUMBERS="${cardColumns[@]}"
                                            LOWEST_CARD_TOTAL_ROW_NUMBER="$CURRENT_ROW"
                                            NUMBERS_USED_FOR_LOWEST_CARD="${NUMBERS_USED_FOR_CARD[@]}"
                                            WINNING_NUMBER="$number"
                                            continue
                                    fi

                                    if [[ "$LOWEST_CARD_COUNT" > "$COUNT" ]]
                                        then
                                            LOWEST_CARD="$CURRENT_CARD"
                                            LOWEST_CARD_COUNT="$COUNT"
                                            MATCHED_NUMBERS="${cardColumns[@]}"
                                            LOWEST_CARD_TOTAL_ROW_NUMBER="$CURRENT_ROW"
                                            NUMBERS_USED_FOR_LOWEST_CARD="${NUMBERS_USED_FOR_CARD[@]}"
                                            WINNING_NUMBER="$number"
                                    fi

                                    continue 3
                            fi
                            continue 2
                    fi
            done
    done

    ((INDEX++))
done <day4_test.txt
# done <day4_test.txt

# echo " LOWEST CARD "
# echo "$LOWEST_CARD"
# echo " WITH " 
# echo "$LOWEST_CARD_COUNT"
# echo "--------------"
# echo "$MATCHED_NUMBERS"
# echo " ON TOTAL ROW "
# echo "$LOWEST_CARD_TOTAL_ROW_NUMBER"
# echo "______________"
# echo ${CARDS[$LOWEST_CARD]}


#create vertical data for part 1
INDEX=0
LOWEST_CARD_NUM=0
LOWEST_LINE_COUNT=0
LOWEST_CARD_LINE=0

for index in {1..5};
    do
        CURRENT_CARD_NUM=0
        MATCHED=0
        while read cardRow; do
            if [[ $INDEX == 0 ]]
                then
                    ((INDEX++))
                    continue
            fi

            ((INDEX++))

            if [[ -z "$cardRow" ]]
                then
                    echo "new card"
                    ((CURRENT_CARD_NUM++))
                    continue
            fi

            IFS=' ' read -ra numbers <<< "${NUMBERS_TO_CHECK[@]}"
            IFS=' ' read -ra cardColumns <<< "$cardRow"

            NUMBER_COUNT=0
            for number in ${numbers[@]}
                do
                    ((NUMBER_COUNT++))
                    if [[ (( $number -eq ${cardColumns[$index]} )) ]]
                        then
                            ((MATCHED++))
                            break
                    fi
            done

            if [[ "$MATCHES" == 5 ]]
                then
                    if [[ "$LOWEST_LINE_COUNT" == 0 ]]
                        then
                            LOWEST_CARD_NUM="$CURRENT_CARD_NUM"
                            LOWEST_CARD_LINE="$index"
                            LOWEST_LINE_COUNT="$NUMBER_COUNT"
                    elif [[ "$LOWEST_LINE_COUNT" > "$NUMBER_COUNT" ]]
                        then
                            LOWEST_CARD_NUM="$CURRENT_CARD_NUM"
                            LOWEST_CARD_LINE="$index"
                            LOWEST_LINE_COUNT="$NUMBER_COUNT"
                    fi
            fi
        done <day4_test.txt
        ((columnIndex++))
    done

echo "$LOWEST_CARD_NUM"
echo "$LOWEST_CARD_LINE"
echo "$LOWEST_LINE_COUNT"

# process horizontal data for part 1
# SECOND_CURRENT_LINE_BUT_REALLY_THE_INDEX_THIS_TIME=0
# SUM_OF_UNMARKED_NUMBERS=0
# while read cardRow; do
#     ((SECOND_CURRENT_LINE_BUT_REALLY_THE_INDEX_THIS_TIME++))

#     if [[ "$LOWEST_CARD_TOTAL_ROW_NUMBER" == "$SECOND_CURRENT_LINE_BUT_REALLY_THE_INDEX_THIS_TIME" ]]
#         then
#             continue
#     fi

#     for negativeLineNumber in ${CARDS[$LOWEST_CARD]}
#         do
#             if [[ "$negativeLineNumber" == "$SECOND_CURRENT_LINE_BUT_REALLY_THE_INDEX_THIS_TIME" ]]
#                 then
#                     IFS=' ' read -ra cardColumns <<< "$cardRow"
#                     IFS=' ' read -ra numbers <<< "${NUMBERS_USED_FOR_LOWEST_CARD[@]}"
#                     for cardColumn in ${cardColumns[@]}
#                         do
#                             for number in ${numbers[@]}
#                                 do
#                                     if [[ "$number" == "$cardColumn" ]]
#                                         then
#                                             continue 2
#                                     fi
#                             done
#                             (( SUM_OF_UNMARKED_NUMBERS += "$cardColumn"))
#                     done
#             fi
#     done
# done <day4.txt
# # done <day4_test.txt

# echo "$WINNING_NUMBER"
# echo "$SUM_OF_UNMARKED_NUMBERS"

# result=$(($WINNING_NUMBER*$SUM_OF_UNMARKED_NUMBERS))

# echo "$result"