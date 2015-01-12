-- BlockingQueue
-- 缺陷： 必须先调用take，再调用put
-- issus: must call take first, then call put
function createBlockingQueue()
    local queue = {}

    local takeThread = nil

    queue.put = function(value)
        coroutine.resume(takeThread, value)
    end

    queue.take = function()
        local currentThread = coroutine.running()
        if takeThread ~= currentThread then
            takeThread = currentThread
        end
        return coroutine.yield()
    end

    return queue
end

