for i in {1..9}
do
    curl https://susy.ic.unicamp.br:9999/mc346a/Prolog/dados/arq0$i.in -k -o arq0$i.in
    curl https://susy.ic.unicamp.br:9999/mc346a/Prolog/dados/arq0$i.res -k -o arq0$i.res
done

for i in {10..25}
do
    curl https://susy.ic.unicamp.br:9999/mc346a/Prolog/dados/arq$i.in -k -o arq$i.in
    curl https://susy.ic.unicamp.br:9999/mc346a/Prolog/dados/arq$i.res -k -o arq$i.res
done

for i in {51..62}
do
    curl https://susy.ic.unicamp.br:9999/mc346a/Prolog/dados/arq$i.in -k -o arq$i.in
    curl https://susy.ic.unicamp.br:9999/mc346a/Prolog/dados/arq$i.res -k -o arq$i.res
done
 
