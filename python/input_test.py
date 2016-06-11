import sys
list = []



def strToInt(x): return int(x)

# fuction that reads lines from stdin and puts then into a list, in a appropriate format, and sorts the list by the x attribute.
def get_input():
    for line in sys.stdin:
        words = line.split()
        list.append(map(strToInt, words))
    list.sort(key=lambda x : x[1])

get_input()
print list
if len(list) < 2:
    print 'erro; zero ou um elemento'

weakestlink = sys.maxint
print weakestlink
for i in range(len(list)-1):
    candidate1 = list[i][2] - list[i+1][1]
    candidate2 = sys.maxint
    candidate3 = sys.maxint
    if list[i][2] - candidate1 <= list[i][1]:
        candidate2 = list[i][2] - list[i][1]
    if list[i+1][2] - candidate1 <= list[i+1][1]:
        candidate3 = list[i+1][2] - list[i+1][1]
    finalCandidate = min(candidate1, candidate2, candidate3)
    if finalCandidate < weakestlink:
        weakestlink = finalCandidate

print weakestlink
