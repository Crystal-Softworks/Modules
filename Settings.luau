```lua
local Settings = {}
local HttpService = game:GetService("HttpService")

function Settings:Load(FileName)
    if not readfile(FileName) then
        return 'Not Found', nil
    else
        return readfile(FileName)
    end
end

function Settings:Delete(FileName)
    if readfile(FileName) then
        delfile(FileName)
        return true
    else
        return 'Not Found', false
    end
end

return Settings
```