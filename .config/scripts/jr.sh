#!bin/bash


JOUR_FILE=journal.md
TMP_ENTRY=/tmp/$(date +%s).md

$EDITOR $TMP_ENTRY

echo ----------------------------------------------- >> $JOUR_FILE
echo $(date) >> $JOUR_FILE
echo ----------------------------------------------- >> $JOUR_FILE
cat $TMP_ENTRY >> $JOUR_FILE

rm -f $TMP_ENTRY
