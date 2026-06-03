--[=[
    @class Queue
    Simple FIFO (first-in, first-out) queue implementation

    Example Usage:
    ```lua
    local Queue = require(path.to.Queue)

    local q = Queue.new()
    q:Enqueue("A")
    q:Enqueue("B")

    print(q:Dequeue()) -- "A"
    print(q:Peek())    -- "B"
    ```
]=]

local Queue = {}
Queue.__index = Queue

--- Create a new Queue
--- @return Queue
function Queue.new()
    return setmetatable({
        _first = 0,
        _last = -1,
        _queue = {}
    }, Queue)
end

--- Check if the queue contains a value
function Queue:Contains(value)
    for i = self._first, self._last do
        if self._queue[i] == value then
            return true
        end
    end
    return false
end

--- Peek at the first value without removing it
function Queue:Peek()
    if self:IsEmpty() then
        error("Cannot peek from an empty queue")
    end
    return self._queue[self._first]
end

--- Check whether the queue is empty
function Queue:IsEmpty()
    return self._first > self._last
end

--- Add a value to the end of the queue
function Queue:Enqueue(value)
	print("SELF", self)
	print("VALUE", value)

	local last = self._last + 1
	self._last = last
	self._queue[last] = value
end

--- Remove and return the first value in the queue
function Queue:Dequeue()
    if self:IsEmpty() then
        error("Cannot dequeue from empty queue")
    end
    local first = self._first
    local value = self._queue[first]
    self._queue[first] = nil
    self._first = first + 1
    return value
end

--- Destroy and clear the queue
function Queue:Destroy()
    self._queue = {}
    self._first = 0
    self._last = -1
end

return Queue
