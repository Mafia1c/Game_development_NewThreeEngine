-- 二进制      可以用U变量替代T变量
BitMgr = BitMgr or {}
BitMgr.len = 64             -- 默认64位
BitMgr.data32 = {}
BitMgr.data64 = {}

for i = 1, 64 do
	if i <= 32 then
		BitMgr.data32[i] = 2 ^ (32 - i)
	end
	BitMgr.data64[i] = 2 ^ (64 - i)
end

-- number转table
function BitMgr.NumToTab(value)
    if type(value) ~= "number" then
        value = tonumber(value)
    end
	local len = BitMgr.len
	local bit_t = BitMgr.data64
	local arg2 = math.abs(value)
	local tr = {}
	for i = 1, len do
		if arg2 >= bit_t[i] then
			tr[i] = 1
			arg2 = arg2 - bit_t[i]
		else
			tr[i] = 0
		end
	end
	return BitMgr.ReverseArrayInPlace(tr)
end

-- table转number
function BitMgr.TabToNum(arg)
	local nr = 0
	for i = 1, BitMgr.len do
		if arg[i] == 1 then
			nr = nr + 2 ^ (i - 1)
		end
	end
	return math.ceil(nr)
end

-- table 反转
function BitMgr.ReverseArrayInPlace(tbl)
    local left, right = 1, #tbl
    while left < right do
        tbl[left], tbl[right] = tbl[right], tbl[left]
        left = left + 1
        right = right - 1
    end
    return tbl
end