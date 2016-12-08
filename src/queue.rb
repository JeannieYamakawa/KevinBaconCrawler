class Queue
    #create an empty list
    def initialize()
        @q = []
    end
    #enqueue create a new array on initialization that includes the node being passed in.
    def enqueue(node)
        #the double arrow means to PUSH the node into our q list
        @q << node
    end
    #dequeue will pull out the thing on the front of the array and return it to us and in doing so shortens the array
    def dequeue
        @q.unshift
    end
    #method below will just return the current value of the whole q list
    def all
        @q
    end

end
