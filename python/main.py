from interval import Interval
from myError import MyError
import sys

#Converts a string to an Integer (used for sorting)
def strToInt(x):
    return int(x)

#Function receives lines from stdin, parses strings, creates an object for each line and adds then to a list.
def getInput(list):
    idset = set()           #A set is used for a quick search method.
    for line in sys.stdin:  #Stdin is used for input reading
        try:
            input = map(strToInt, line.split())
        except ValueError:  #ValueError exceptio is caught in the case non-numeric characters appear
            raise MyError('erro; linha possui caracteres incorretos: ' + line)
        if(not len(input) == 3):
            raise MyError('erro; linha possui numero de parametros incorreto: ' + line)
        if(input[1] > input[2]):
            raise MyError('erro; comprimento negativo: ' + line)
        if input[0] in idset:
            raise MyError('erro; id repetido: ' + line)
        idset.add(input[0])            #The id is added to the set
        list.append(Interval(input))   #Interval class receives a list o its constructor to simplify code

#Finds the weakest link in a Interval list
def findWeakestLink(list):
    wkstLink = sys.maxint
    maxInter = list[0]
    for i in range(len(list)-1):
        #Candidate list stores possible candidates for weakest link
        candList = []
        if not list[i].isContained(maxInter):
            cand1 = list[i].max - list[i+1].min
            candList.append(cand1)
        cand2 = list[i].max - list[i].min
        candList.append(cand2)
        if min(candList)< wkstLink:
            wkstLink = min(candList)
        maxInter = Interval.maxInterval(maxInter, list[i])
            
    return wkstLink
        
#Main function
def main():
    list = []
    try:
        getInput(list)
        if(len(list) < 2):
            raise MyError("erro; colecao pequena demais")
    except MyError as err:
        print err.message
        exit()

    list.sort(key=lambda x : (x.min, x.max))
    '''
    for i in range(len(list)):
        print list[i]
    '''
    print findWeakestLink(list)
        
if __name__ == "__main__":
    main()
