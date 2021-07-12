#!/bin/bash 

folder=.

end1=$(wc -l $folder/motif_instances.txt   | awk '{print $1}')
for ((r=1; $r<=$end1; r=$r+1)); do
seq=`sed -n "${r}p" $folder/motif_instances.txt  | awk '{print $1}'`


seq_len=`echo $seq | wc | awk '{print $3-1}'`
echo "0 0 $seq_len N" > $folder/seq_palindromes.txt
for ((i=1; $i<$seq_len-$min+1; i=$i+1)); do
j=$min
while ((j<$seq_len-1 && ($i+$j)<=$seq_len)); do
l=$((i+j-1))     
sub_seq=`echo $seq | cut -c$i-$l`
rcsub_seq=`echo $sub_seq | awk '{ for(i = length; i!=0; i--) x = x substr($0, i, 1);}END {print x}' | sed 's/A/1/g' | sed 's/T/2/g' | sed 's/C/4/g' | sed 's/G/3/g' | sed 's/1/T/g' | sed 's/2/A/g' | sed 's/4/G/g' | sed 's/3/C/g'`

if [ $sub_seq == $rcsub_seq ]; then
echo $i $j $seq_len $sub_seq
echo $i $j $seq_len $sub_seq >> $folder/seq_palindromes.txt
j=$((j+2))

else
j=$((j+2))
fi
done
done
