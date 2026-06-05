-- Decompiled with Potassium.

local u1 = loadstring(game:HttpGet("https://raw.githubusercontent.com/cy5n03t2ct4y3jc0tn8y5/Modules/refs/heads/main/BufferUtil/BufferWriter.luau"))()
local u2 = loadstring(game:HttpGet("https://raw.githubusercontent.com/cy5n03t2ct4y3jc0tn8y5/Modules/refs/heads/main/BufferUtil/DataTypeBuffer.luau"))()
local u3 = {}
u3.__index = u3
function u3.new(p4) --[[ Line: 16 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u1
    --]]
    if typeof(p4) == "string" then
        return u3.fromString(p4)
    end
    if typeof(p4) == "buffer" then
        return u3.fromBuffer(p4)
    end
    if typeof(p4) == "table" and getmetatable(p4) == u1 then
        return u3.fromBuffer(p4:GetBuffer())
    end
    error((("expected string or buffer; got %*"):format((typeof(p4)))))
end
function u3.fromBuffer(p5) --[[ Line: 28 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    local v6 = {
        ["_cursor"] = 0,
        ["_buffer"] = p5,
        ["_size"] = buffer.len(p5)
    }
    local v7 = u3
    return setmetatable(v6, v7)
end
function u3.fromString(p8) --[[ Line: 38 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    return u3.fromBuffer(buffer.fromstring(p8))
end
function u3._assertSize(p9, p10) --[[ Line: 42 ]]
    if p9._size < p10 then
        error("cursor out of bounds", 3)
    end
end
function u3.ReadInt8(p11) --[[ Line: 51 ]]
    p11:_assertSize(p11._cursor + 1)
    local v12 = p11._buffer
    local v13 = p11._cursor
    local v14 = buffer.readi8(v12, v13)
    p11._cursor = p11._cursor + 1
    return v14
end
function u3.ReadUInt8(p15) --[[ Line: 61 ]]
    p15:_assertSize(p15._cursor + 1)
    local v16 = p15._buffer
    local v17 = p15._cursor
    local v18 = buffer.readu8(v16, v17)
    p15._cursor = p15._cursor + 1
    return v18
end
function u3.ReadInt16(p19) --[[ Line: 71 ]]
    p19:_assertSize(p19._cursor + 2)
    local v20 = p19._buffer
    local v21 = p19._cursor
    local v22 = buffer.readi16(v20, v21)
    p19._cursor = p19._cursor + 2
    return v22
end
function u3.ReadUInt16(p23) --[[ Line: 81 ]]
    p23:_assertSize(p23._cursor + 2)
    local v24 = p23._buffer
    local v25 = p23._cursor
    local v26 = buffer.readu16(v24, v25)
    p23._cursor = p23._cursor + 2
    return v26
end
function u3.ReadInt32(p27) --[[ Line: 91 ]]
    p27:_assertSize(p27._cursor + 4)
    local v28 = p27._buffer
    local v29 = p27._cursor
    local v30 = buffer.readi32(v28, v29)
    p27._cursor = p27._cursor + 4
    return v30
end
function u3.ReadUInt32(p31) --[[ Line: 101 ]]
    p31:_assertSize(p31._cursor + 4)
    local v32 = p31._buffer
    local v33 = p31._cursor
    local v34 = buffer.readu32(v32, v33)
    p31._cursor = p31._cursor + 4
    return v34
end
function u3.ReadFloat32(p35) --[[ Line: 111 ]]
    p35:_assertSize(p35._cursor + 4)
    local v36 = p35._buffer
    local v37 = p35._cursor
    local v38 = buffer.readf32(v36, v37)
    p35._cursor = p35._cursor + 4
    return v38
end
function u3.ReadFloat64(p39) --[[ Line: 121 ]]
    p39:_assertSize(p39._cursor + 8)
    local v40 = p39._buffer
    local v41 = p39._cursor
    local v42 = buffer.readf64(v40, v41)
    p39._cursor = p39._cursor + 8
    return v42
end
function u3.ReadBool(p43) --[[ Line: 131 ]]
    return p43:ReadUInt8() == 1
end
function u3.ReadString(p44) --[[ Line: 143 ]]
    local v45 = p44:ReadUInt32()
    p44:_assertSize(p44._cursor + v45)
    local v46 = buffer.readstring(p44._buffer, p44._cursor, v45)
    p44._cursor = p44._cursor + v45
    return v46
end
function u3.ReadStringRaw(p47, p48) --[[ Line: 157 ]]
    local v49 = math.floor(p48)
    local v50 = math.max(0, v49)
    p47:_assertSize(p47._cursor + v50)
    local v51 = buffer.readstring(p47._buffer, p47._cursor, v50)
    p47._cursor = p47._cursor + v50
    return v51
end
function u3.ReadDataType(p52, p53) --[[ Line: 172 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v54 = u2.DataTypesToString[p53]
    if not v54 then
        error("unsupported data type", 2)
    end
    return u2.ReadWrite[v54].read(p52)
end
function u3.SetCursor(p55, p56) --[[ Line: 185 ]]
    local v57 = math.floor(p56)
    if v57 < 0 or p55._size < v57 then
        error(("cursor position %* out of range [0, %*]"):format(v57, p55._size), 3)
    end
    p55._cursor = v57
end
function u3.GetCursor(p58) --[[ Line: 197 ]]
    return p58._cursor
end
function u3.ResetCursor(p59) --[[ Line: 204 ]]
    p59._cursor = 0
end
function u3.GetSize(p60) --[[ Line: 211 ]]
    return p60._size
end
function u3.GetBuffer(p61) --[[ Line: 218 ]]
    return p61._buffer
end
function u3.__tostring(_) --[[ Line: 222 ]]
    return "BufferReader"
end
return u3
