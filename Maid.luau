local Maid = {
	ClassName = "Maid"
}

local Promise = loadstring(game:HttpGet("https://codeberg.org/Crystal-Softworks/Utilities/raw/branch/main/Promise.luau"))()

Maid.__index = function(self, Key)
	if Maid[Key] ~= nil then
		return Maid[Key]
	end

	return self._tasks[Key]
end

Maid.__newindex = function(self, Key, Value)
	if Maid[Key] ~= nil then
		error(string.format("Cannot use '%s' as a Maid key", tostring(Key)), 2)
	end

	local Tasks = self._tasks
	local Existing = Tasks[Key]

	if Existing == Value then
		return
	end

	Tasks[Key] = Value

	if Existing == nil then
		return
	end

	local Kind = typeof(Existing)

	if Kind == "function" then
		Existing()
		return
	end

	if Kind == "RBXScriptConnection" then
		Existing:Disconnect()
		return
	end

	if Kind == "Instance" then
		Existing:Destroy()
		return
	end

	if Kind == "thread" then
		if coroutine.running() ~= Existing then
			task.cancel(Existing)
		end
		return
	end

	if Kind == "table" then
		local Destroy = Existing.Destroy
		if type(Destroy) == "function" then
			Existing:Destroy()
		end
	end
end

function Maid.new()
	return setmetatable(
		{
			_tasks = {}
		},
		Maid
	)
end

function Maid.isMaid(Value)
	return type(Value) == "table" and Value.ClassName == "Maid"
end

function Maid:GiveTask(Task)
	if Task == nil then
		error("Task cannot be nil", 2)
	end

	if Promise.is(Task) then
		task.spawn(function()
			local Ok, Result = Task:await()
			if Ok then
				self:GiveTask(Result)
			end
		end)
		return
	end

	local Index = #self._tasks + 1
	self[Index] = Task

	if type(Task) == "table" and type(Task.Destroy) ~= "function" then
		warn(
			"[Maid.GiveTask] - Gave table task without .Destroy\n\n" ..
				debug.traceback()
		)
	end

	return Index
end

function Maid:GivePromise(Promise)
	local Task = Promise
	local Index = self:GiveTask(Task)

	Task:Finally(function()
		self[Index] = nil
	end)

	return Task
end

function Maid:Destroy()
	local Tasks = self._tasks

	for Key, Task in pairs(Tasks) do
		Tasks[Key] = nil

		local Kind = typeof(Task)

		if Kind == "function" then
			Task()
		elseif Kind == "RBXScriptConnection" then
			Task:Disconnect()
		elseif Kind == "Instance" then
			Task:Destroy()
		elseif Kind == "thread" then
			if coroutine.running() ~= Task then
				task.cancel(Task)
			end
		elseif Kind == "table" then
			if type(Task.Destroy) == "function" then
				Task:Destroy()
			end
		end
	end
end

--Maid.Destroy = Maid.DoCleaning

function Maid:DoCleaning()
	self:Destroy()
end

return Maid
