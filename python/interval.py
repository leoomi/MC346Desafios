class Interval:
    """Interval class, with id, minimum and maxbimum coordinates, and related functions"""
    def __init__(self, input):
        self.id = input[0]
        self.min = input[1]
        self.max = input[2]
    def __str__(self):    #for easier debugging
        return 'id: {0}; [{1}, {2}]'.format(self.id, self.min, self.max)
    def isContained(self, other):
        if(self.min >= other.min and self.max <= other.max):
            return True
        else:
            return False
    # Receives two intervals, and returns their union, if they have an intersection
    def maxInterval(current, new):
        if(not(new.isContained(current))):
            return Interval([-1, current.min, new.max])
        else:
            return current
