class MyError(Exception):
    def __init__(self, string):
        self.message = string
         
    def __str__(self):
        return self.message
