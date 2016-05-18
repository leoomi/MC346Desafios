for i in {1..9}
do
    curl https://susy.ic.unicamp.br:9999/mc346a/Haskell/dados/arq0$i.in -k -o arq0$i.in
    curl https://susy.ic.unicamp.br:9999/mc346a/Haskell/dados/arq0$i.res -k -o arq0$i.res
done

for i in {10..25}
do
    curl https://susy.ic.unicamp.br:9999/mc346a/Haskell/dados/arq$i.in -k -o arq$i.in
    curl https://susy.ic.unicamp.br:9999/mc346a/Haskell/dados/arq$i.res -k -o arq$i.res
done

for i in {30..35}
do
    curl https://susy.ic.unicamp.br:9999/mc346a/Haskell/dados/arq$i.in -k -o arq$i.in
    curl https://susy.ic.unicamp.br:9999/mc346a/Haskell/dados/arq$i.res -k -o arq$i.res
done

for i in {40..55}
do
    curl https://susy.ic.unicamp.br:9999/mc346a/Haskell/dados/arq$i.in -k -o arq$i.in
    curl https://susy.ic.unicamp.br:9999/mc346a/Haskell/dados/arq$i.res -k -o arq$i.res
done
 
