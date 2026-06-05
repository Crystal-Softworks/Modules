-- Decompiled with Potassium.

require(script.Parent.Types)
local u1 = {
    ["DataTypesToString"] = {
        [BrickColor] = "BrickColor",
        [CFrame] = "CFrame",
        [Color3] = "Color3",
        [DateTime] = "DateTime",
        [Ray] = "Ray",
        [Rect] = "Rect",
        [Region3] = "Region3",
        [Region3int16] = "Region3int16",
        [UDim] = "UDim",
        [UDim2] = "UDim2",
        [Vector2] = "Vector2",
        [Vector3] = "Vector3",
        [Vector2int16] = "Vector2int16",
        [Vector3int16] = "Vector3int16"
    },
    ["ReadWrite"] = {}
}
u1.ReadWrite.BrickColor = {
    ["write"] = function(p2, p3) --[[ Name: write, Line 32 ]]
        p2:WriteUInt16(p3.Number)
    end,
    ["read"] = function(p4) --[[ Name: read, Line 36 ]]
        local v5 = p4:ReadUInt16()
        return BrickColor.new(v5)
    end
}
u1.ReadWrite.CFrame = {
    ["write"] = function(p6, p7) --[[ Name: write, Line 43 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        u1.ReadWrite.Vector3.write(p6, p7.Position)
        u1.ReadWrite.Vector3.write(p6, p7.XVector)
        u1.ReadWrite.Vector3.write(p6, p7.YVector)
        u1.ReadWrite.Vector3.write(p6, p7.ZVector)
    end,
    ["read"] = function(p8) --[[ Name: read, Line 50 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local v9 = u1.ReadWrite.Vector3.read(p8)
        local v10 = u1.ReadWrite.Vector3.read(p8)
        local v11 = u1.ReadWrite.Vector3.read(p8)
        local v12 = u1.ReadWrite.Vector3.read(p8)
        return CFrame.fromMatrix(v9, v10, v11, v12)
    end
}
u1.ReadWrite.Color3 = {
    ["write"] = function(p13, p14) --[[ Name: write, Line 60 ]]
        p13:WriteFloat32(p14.R)
        p13:WriteFloat32(p14.G)
        p13:WriteFloat32(p14.B)
    end,
    ["read"] = function(p15) --[[ Name: read, Line 66 ]]
        local v16 = p15:ReadFloat32()
        local v17 = p15:ReadFloat32()
        local v18 = p15:ReadFloat32()
        return Color3.new(v16, v17, v18)
    end
}
u1.ReadWrite.DateTime = {
    ["write"] = function(p19, p20) --[[ Name: write, Line 75 ]]
        p19:WriteFloat64(p20.UnixTimestampMillis)
    end,
    ["read"] = function(p21) --[[ Name: read, Line 79 ]]
        local v22 = p21:ReadFloat64()
        return DateTime.fromUnixTimestampMillis(v22)
    end
}
u1.ReadWrite.Ray = {
    ["write"] = function(p23, p24) --[[ Name: write, Line 86 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        u1.ReadWrite.Vector3.write(p23, p24.Origin)
        u1.ReadWrite.Vector3.write(p23, p24.Direction)
    end,
    ["read"] = function(p25) --[[ Name: read, Line 91 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local v26 = u1.ReadWrite.Vector3.read(p25)
        local v27 = u1.ReadWrite.Vector3.read(p25)
        return Ray.new(v26, v27)
    end
}
u1.ReadWrite.Rect = {
    ["write"] = function(p28, p29) --[[ Name: write, Line 99 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        u1.ReadWrite.Vector3.write(p28, p29.Min)
        u1.ReadWrite.Vector3.write(p28, p29.Max)
    end,
    ["read"] = function(p30) --[[ Name: read, Line 104 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local v31 = u1.ReadWrite.Vector3.read(p30)
        local v32 = u1.ReadWrite.Vector3.read(p30)
        return Rect.new(v31, v32)
    end
}
u1.ReadWrite.Region3 = {
    ["write"] = function(p33, p34) --[[ Name: write, Line 112 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local v35 = p34.CFrame.Position
        local v36 = p34.Size * 0.5
        local v37 = v35 - v36
        local v38 = v35 + v36
        u1.ReadWrite.Vector3.write(p33, v37)
        u1.ReadWrite.Vector3.write(p33, v38)
    end,
    ["read"] = function(p39) --[[ Name: read, Line 121 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local v40 = u1.ReadWrite.Vector3.read(p39)
        local v41 = u1.ReadWrite.Vector3.read(p39)
        return Region3.new(v40, v41)
    end
}
u1.ReadWrite.Region3int16 = {
    ["write"] = function(p42, p43) --[[ Name: write, Line 129 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        u1.ReadWrite.Vector3int16.write(p42, p43.Min)
        u1.ReadWrite.Vector3int16.write(p42, p43.Max)
    end,
    ["read"] = function(p44) --[[ Name: read, Line 134 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local v45 = u1.ReadWrite.Vector3int16.read(p44)
        local v46 = u1.ReadWrite.Vector3int16.read(p44)
        return Region3int16.new(v45, v46)
    end
}
u1.ReadWrite.UDim = {
    ["write"] = function(p47, p48) --[[ Name: write, Line 142 ]]
        p47:WriteFloat32(p48.Scale)
        p47:WriteInt32(p48.Offset)
    end,
    ["read"] = function(p49) --[[ Name: read, Line 147 ]]
        local v50 = p49:ReadFloat32()
        local v51 = p49:ReadInt32()
        return UDim.new(v50, v51)
    end
}
u1.ReadWrite.UDim2 = {
    ["write"] = function(p52, p53) --[[ Name: write, Line 155 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        u1.ReadWrite.UDim.write(p52, p53.X)
        u1.ReadWrite.UDim.write(p52, p53.Y)
    end,
    ["read"] = function(p54) --[[ Name: read, Line 160 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local v55 = u1.ReadWrite.UDim.read(p54)
        local v56 = u1.ReadWrite.UDim.read(p54)
        return UDim2.new(v55, v56)
    end
}
u1.ReadWrite.Vector2 = {
    ["write"] = function(p57, p58) --[[ Name: write, Line 168 ]]
        p57:WriteFloat32(p58.X)
        p57:WriteFloat32(p58.Y)
    end,
    ["read"] = function(p59) --[[ Name: read, Line 173 ]]
        local v60 = p59:ReadFloat32()
        local v61 = p59:ReadFloat32()
        return Vector2.new(v60, v61)
    end
}
u1.ReadWrite.Vector3 = {
    ["write"] = function(p62, p63) --[[ Name: write, Line 181 ]]
        p62:WriteFloat32(p63.X)
        p62:WriteFloat32(p63.Y)
        p62:WriteFloat32(p63.Z)
    end,
    ["read"] = function(p64) --[[ Name: read, Line 187 ]]
        local v65 = p64:ReadFloat32()
        local v66 = p64:ReadFloat32()
        local v67 = p64:ReadFloat32()
        return Vector3.new(v65, v66, v67)
    end
}
u1.ReadWrite.Vector2int16 = {
    ["write"] = function(p68, p69) --[[ Name: write, Line 196 ]]
        p68:WriteInt16(p69.X)
        p68:WriteInt16(p69.Y)
    end,
    ["read"] = function(p70) --[[ Name: read, Line 201 ]]
        local v71 = p70:ReadInt16()
        local v72 = p70:ReadInt16()
        return Vector2int16.new(v71, v72)
    end
}
u1.ReadWrite.Vector3int16 = {
    ["write"] = function(p73, p74) --[[ Name: write, Line 209 ]]
        p73:WriteInt16(p74.X)
        p73:WriteInt16(p74.Y)
        p73:WriteInt16(p74.Z)
    end,
    ["read"] = function(p75) --[[ Name: read, Line 215 ]]
        local v76 = p75:ReadInt16()
        local v77 = p75:ReadInt16()
        local v78 = p75:ReadInt16()
        return Vector3int16.new(v76, v77, v78)
    end
}
return u1
