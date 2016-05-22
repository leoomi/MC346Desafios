function pause(){
   read -p "$*"
}

for i in {1..9}
do
    echo "Test $i"
    runghc Main.hs < tests/arq0$i.in
    cat tests/arq0$i.res
    pause
done

for i in {10..25}
do
    echo "Test $i"
    runghc Main.hs < tests/arq$i.in
    cat tests/arq$i.res
    pause
done

for i in {30..35}
do
    echo "Test $i"
    runghc Main.hs < tests/arq$i.in
    cat tests/arq$i.res
    pause
done

for i in {40..55}
do
    echo "Test $i"
    runghc Main.hs < tests/arq$i.in
    cat tests/arq$i.res
    pause
done
 
