class Interval:
    """Interval class, with id, minimum and maxbimum coordinates, and related functions"""
    #The constructor recives a list with an id, and min and max coordinates, in this order
    def __init__(self, input):
        self.id = input[0]
        self.min = input[1]
        self.max = input[2]

    #for easier debugging
    def __str__(self):
        return 'id: {0}; [{1}, {2}]'.format(self.id, self.min, self.max)
    
    #returns True if this interval is contained in another one. Considers that a interval is not contained on another interval with the same values
    def isContained(self, other):
        if(self.min == other.min and self.max == other.max):
            return False
        elif(self.min >= other.min and self.max <= other.max):
            return True
        else:
            return False

    #if the other Interval has the same or higher min value, returns True if they have an intersection
    def hasIntersection(self, other):
        if(self.min <= other.min and self.max <= other.max and self.max >= other.min):
            return True
        else:
            return False
        
    # Receives two intervals, and returns their union, if they have an intersection
    def maxInterval(current, new):
        if(not(new.isContained(current)) and current.hasIntersection(new)):
            return Interval([-1, current.min, new.max])
        else:
            return current
