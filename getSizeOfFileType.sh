if [[ -z $1 ]]; then echo "Please specify the file type"; exit; fi;
filetype=$1
tmp=$(find . -name TOEXCLUDE -prune -o -print | tail -n +2 | grep ".$filetype$")
if [[ $tmp -eq 0 ]]; then echo "No files of type .$filetype"; exit; fi;
bytes=$(echo "$tmp" | sed 's/^/"/' | sed 's/$/"/' | xargs du -b | sort -h | awk '{ print $1 }' )

while read i; 
do
	counter=$((counter+$i))
done < <(echo "$bytes")
echo "Total bytes: $counter"

if [[ $((counter/1024/1024)) -eq 0 ]];
then
	echo "All $filetype files amount to $((counter/1000)) KB"
else 
	echo "All $filetype files amount to $((counter/1000/1000)) MB"
fi


#counter=0
#n=$(echo "$bytes" | while read i; do counter=$((counter+$i)); echo $counter; done;)
#echo $n
