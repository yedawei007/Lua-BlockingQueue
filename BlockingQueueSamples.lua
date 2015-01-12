require("BlockingQueue")

local function fork(run)
    local  co = coroutine.create(run) 
    coroutine.resume(co)
end

local q = createBlockingQueue()

local loopCount = 200

-- 先执行take
-- call take first
fork(function()
    for i = 1, loopCount do 
        local v = q.take()
        print(v)
    end
end)

-- 再执行put
-- then call put
fork(function()
    for i = 1, loopCount do 
        q.put(i)
    end
end)
