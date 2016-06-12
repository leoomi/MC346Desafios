from interval import Interval
from myError import MyError
import sys

def checkId(id, list):
    for i in range(len(list)):
        if (id == list[i].id):
            return True
    return False

#Converts a string to an Integer (used for sorting)
def strToInt(x):
    return int(x)

#Function receives lines from stdin, parses strings, creates an object for each line and adds then to a list.
def getInput(list):
    for line in sys.stdin:
        try:
            input = map(strToInt, line.split())
        except ValueError:
            raise MyError('erro; linha possui caracteres incorretos: ' + line)
        if(len(input) > 3):
            raise MyError('erro; linha possui parametros demais: ' + line)
        if checkId(input[0], list):
            raise MyError('erro; id repetido: ' + line)
        list.append(Interval(input))

#Main function
def main():
    list = []
    try:
        getInput(list)
    except MyError as err:
        print err
        exit()

    list.sort(key=lambda x : (x.min, x.max))
        
    for i in range(len(list)):
        print list[i]

if __name__ == "__main__":
    main()
