#!/bin/sh


if cmus-remote -Q | grep -q "paused";then
	echo "Paused";
else
	cmus-remote -Q | egrep 'tag (artist|title) '| sed -E 's/tag (artist|title) //g' | sed 'N;s/\n/ - /'
fi
