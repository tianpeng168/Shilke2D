---Extends table namespace
 
---clears a table, setting all the values to nil
--@param t the table to clear
--@param recursive [optional] if true clear all subtables deeply. Default value is false
function table.clear(t,recursive)
    for k,_ in pairs(t) do
		if recursive and type(t[k]) == 'table' then
			table.clear(t[k],true)
		end
        t[k] = nil
    end
end  

---make a copy of the values of a table and assign the same metatable
--@return table table to be copied
--@return a new table
function table.copy(t)
    local u ={}
    for k,v in pairs(t) do
        u[k] = v
    end
    return setmetatable(u, getmetatable(t))
end


---Make a deep copy of the values of a table and assign the same metatable.
--Deep copy means that each value of type table is deepcopied itself
--@return table table to be copied
--@return a new table
function table.deepcopy(t)
    if type(t) ~= 'table' then 
        return t 
    end
    local mt = getmetatable(t)
    local res = {}
    for k,v in pairs(t) do
        if type(v) == 'table' then
            res[k] = table.deepcopy(v)
        else
            res[k] = v
        end
    end
    setmetatable(res,mt)
    return res
end 

---Sets to nil a key and returns previous value
--@param table the table to modify
--@param key the key to reset
--@return previous kay value
function table.removeKey(table, key)
    local element = table[key]
    table[key] = nil
    return element
end

---Returns position of o in table t
--@param t the table where to search
--@param o the object to be searched
--@return index of the object into the table. 
--0 if the table doesn't contain the object.
function table.find(t,o)
    local c = 1
    for _,v in pairs(t) do
        if(v == o) then
            return c
        end
        c = c + 1
    end
    return 0
end

---Removes an object from a table
--@param t the table to modify
--@param o the object to be removed
--@return the removed object. nil if o doesn't belong to t
function table.removeObj(t, o)
    local i = table.find(t,o)
    if i then 
        return table.remove(t,i)
    end
    return nil
end

---Returns a new table that contains the same elements in inverse order.
--Threats the table as normal indexed array
--@param t the array to invert
--@return a new table
function table.invert(t)
    local new = {}
    for i=0, #t do
        table.insert(new, t[#t - i])
    end
    return new
end

---Returns a new table that is a copy of a section af a given table.
--@param t the source table
--@param i1 start index of the copy section
--@param i2 end index of the copy section
--@return a new table
function table.slice(t,i1,i2)
    local res = {}
    local n = #t
    -- default values for range
    local i1 = i1 or 1
    local i2 = i2 or n
    if i2 < 0 then
        i2 = n + i2 + 1
    elseif i2 > n then
        i2 = n
    end
    if i1 < 1 or i1 > n then
        return {}
    end
    local k = 1
    for i = i1,i2 do
        res[k] = t[i]
    k = k + 1
    end
    return res
end

---prints the content of a table using outFunc
--@param t the table to dump
--@param outFunc the function to be used for dumping. default is "print"
function table.dump(t,outFunc)
	local outFunc = outFunc or print
	for k,v in pairs(t) do
		outFunc(k,v)
		if type(v) == "table" then
			table.dump(v)
		end
	end
end
    