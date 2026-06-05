-- Decompiled with Potassium.

local u1 = require(script.Parent.DataTypeBuffer)
require(script.Parent.Types)
local u2 = {}
u2.__index = u2
function u2.new(p3) --[[ Line: 20 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v4 = typeof(p3) ~= "number" and 0 or math.clamp(p3, 0, 1073741824)
    local v5 = {
        ["_cursor"] = 0,
        ["_size"] = 0,
        ["_buffer"] = buffer.create(v4)
    }
    local v6 = u2
    return setmetatable(v5, v6)
end
function u2._resizeUpTo(p7, p8) --[[ Line: 32 ]]
    if p8 > 1073741824 then
        error(("cannot resize buffer to %* bytes (max size: %* bytes)"):format(p8, 1073741824), 3)
    end
    local v9 = p7._size
    p7._size = math.max(v9, p8)
    if p8 >= buffer.len(p7._buffer) then
        local v10 = math.log(p8, 2)
        if math.floor(v10) ~= v10 then
            p8 = 2 ^ (math.floor(v10) + 1)
        end
        local v11 = p7._buffer
        local v12 = buffer.create(p8)
        buffer.copy(v12, 0, v11, 0)
        p7._buffer = v12
    end
end
function u2.WriteInt8(p13, p14) --[[ Line: 61 ]]
    p13:_resizeUpTo(p13._cursor + 1)
    local v15 = p13._buffer
    local v16 = p13._cursor
    buffer.writei8(v15, v16, p14)
    p13._cursor = p13._cursor + 1
end
function u2.WriteUInt8(p17, p18) --[[ Line: 70 ]]
    p17:_resizeUpTo(p17._cursor + 1)
    local v19 = p17._buffer
    local v20 = p17._cursor
    buffer.writeu8(v19, v20, p18)
    p17._cursor = p17._cursor + 1
end
function u2.WriteInt16(p21, p22) --[[ Line: 79 ]]
    p21:_resizeUpTo(p21._cursor + 2)
    local v23 = p21._buffer
    local v24 = p21._cursor
    buffer.writei16(v23, v24, p22)
    p21._cursor = p21._cursor + 2
end
function u2.WriteUInt16(p25, p26) --[[ Line: 88 ]]
    p25:_resizeUpTo(p25._cursor + 2)
    local v27 = p25._buffer
    local v28 = p25._cursor
    buffer.writeu16(v27, v28, p26)
    p25._cursor = p25._cursor + 2
end
function u2.WriteInt32(p29, p30) --[[ Line: 97 ]]
    p29:_resizeUpTo(p29._cursor + 4)
    local v31 = p29._buffer
    local v32 = p29._cursor
    buffer.writei32(v31, v32, p30)
    p29._cursor = p29._cursor + 4
end
function u2.WriteUInt32(p33, p34) --[[ Line: 106 ]]
    p33:_resizeUpTo(p33._cursor + 4)
    local v35 = p33._buffer
    local v36 = p33._cursor
    buffer.writeu32(v35, v36, p34)
    p33._cursor = p33._cursor + 4
end
function u2.WriteFloat32(p37, p38) --[[ Line: 115 ]]
    p37:_resizeUpTo(p37._cursor + 4)
    local v39 = p37._buffer
    local v40 = p37._cursor
    buffer.writef32(v39, v40, p38)
    p37._cursor = p37._cursor + 4
end
function u2.WriteFloat64(p41, p42) --[[ Line: 124 ]]
    p41:_resizeUpTo(p41._cursor + 8)
    local v43 = p41._buffer
    local v44 = p41._cursor
    buffer.writef64(v43, v44, p42)
    p41._cursor = p41._cursor + 8
end
function u2.WriteBool(p45, p46) --[[ Line: 133 ]]
    p45:WriteUInt8(p46 and 1 or 0)
end
function u2.WriteString(p47, p48, p49) --[[ Line: 146 ]]
    local v50
    if p49 then
        local v51 = #p48
        v50 = math.min(v51, p49)
    else
        v50 = #p48
    end
    local v52 = v50 + 4
    p47:_resizeUpTo(p47._cursor + v52)
    local v53 = p47._buffer
    local v54 = p47._cursor
    buffer.writeu32(v53, v54, v50)
    buffer.writestring(p47._buffer, p47._cursor + 4, p48, p49)
    p47._cursor = p47._cursor + v52
end
function u2.WriteStringRaw(p55, p56, p57) --[[ Line: 165 ]]
    local v58
    if p57 then
        local v59 = #p56
        v58 = math.min(v59, p57)
    else
        v58 = #p56
    end
    p55:_resizeUpTo(p55._cursor + v58)
    buffer.writestring(p55._buffer, p55._cursor, p56, p57)
    p55._cursor = p55._cursor + v58
end
function u2.WriteDataType(p60, p61) --[[ Line: 179 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v62 = typeof(p61)
    local v63 = u1.ReadWrite[v62]
    if not v63 then
        error(("unsupported data type \"%*\""):format(v62), 2)
    end
    v63.write(p60, p61)
end
function u2.Shrink(p64) --[[ Line: 191 ]]
    if p64._size ~= buffer.len(p64._buffer) then
        local v65 = p64._buffer
        local v66 = buffer.create(p64._size)
        buffer.copy(v66, 0, v65, 0, p64._size)
        p64._buffer = v66
    end
end
function u2.GetSize(p67) --[[ Line: 208 ]]
    return p67._size
end
function u2.GetCapacity(p68) --[[ Line: 219 ]]
    return buffer.len(p68._buffer)
end
function u2.SetCursor(p69, p70) --[[ Line: 226 ]]
    local v71 = math.floor(p70)
    if v71 < 0 or p69._size < v71 then
        error(("cursor position %* out of range [0, %*]"):format(v71, p69._size), 3)
    end
    p69._cursor = v71
end
function u2.GetCursor(p72) --[[ Line: 238 ]]
    return p72._cursor
end
function u2.ResetCursor(p73) --[[ Line: 245 ]]
    p73._cursor = 0
end
function u2.GetBuffer(p74) --[[ Line: 252 ]]
    return p74._buffer
end
function u2.ToString(p75) --[[ Line: 259 ]]
    return buffer.tostring(p75._buffer)
end
function u2.__tostring(_) --[[ Line: 263 ]]
    return "BufferWriter"
end
return u2
