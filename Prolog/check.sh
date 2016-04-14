function pause(){
   read -p "$*"
}

for i in {1..9}
do
    echo "Test $i"
    swipl -q -f desafio.pl -g main -t halt < tests/arq0$i.in
    cat tests/arq0$i.res
    pause
done

for i in {10..25}
do
    echo "Test $i"
    swipl -q -f desafio.pl -g main -t halt < tests/arq$i.in
    cat tests/arq$i.res
    pause
done

for i in {51..62}
do
    echo "Test $i"
    swipl -q -f desafio.pl -g main -t halt < tests/arq$i.in
    cat tests/arq$i.res
    pause
done
 
