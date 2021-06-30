local RPC = {}

function RPC:Constructor()
    self.port = 6463
    self.discovered = false
end

function RPC:Init()
    Discord:Debug('Searching for Discord RPC...')
    self:Discover()
end

function RPC:GetURL(endpoint, ...)
    return ('http://127.0.0.1:%s/' .. (endpoint or '')):format(self.port, ...)
end

function RPC:Discover()
    if self.port > 6472 then return Discord:Debug('RPC not found.') end
    if self.discovered then return Discord:Debug('Already discovered.') end

    http.Fetch(self:GetURL(), function(body, size, headers, code)
        if code == 401 then
            self.discovered = true

            Discord:Debug('RPC found at port ' .. self.port .. '!')
            self:emit('discovered')
        end
    end, function(err)
        self.port = self.port + 1

        self:Discover()
    end)
end

function RPC:API(data, clientid, callback)
    if not self.discovered then return callback('RPC isn\'t discovered.') end

    HTTP({
        url = self:GetURL('rpc?v=1&client_id=%s', clientid),
        method = 'POST',

        type = 'application/json',
        headers = {
            ['Content-Type'] = 'application/json',
        },

        body = util.TableToJSON(data),

        success = function(code, body, headers)
            if code == 200 then
                local response = util.JSONToTable(body)
                if not response then return callback('Failed, malformed json: ' .. body) end

                if response.data and (not response.data.code or not tonumber(response.data.code)) then
                    callback(nil, response.data)
                else
                    callback('Failed with the error: ' .. body)
                end
            else
                callback('Failed with the error: ' .. code .. ' - ' .. body)
            end
        end,

        failed = function(err)
            callback('Failed with the error: ' .. err)
        end,
    })
end

function RPC:SetPresence(data, clientid, callback)
    self:API({
        cmd = 'SET_ACTIVITY',
        nonce = 'SET_ACTIVITY_' .. os.time(),
        args = {
            activity = data,
            pid = GetProcessID and GetProcessID() or 3287,
        },
    }, clientid,
    function(err)
        if err then
            Discord:Log(err)
            return
        end

        if callback then callback() end
    end)
end

function RPC:Request(scopes, clientid, callback)
    self:API({
        cmd = 'AUTHORIZE',
        nonce = 'AUTHORIZE_' .. os.time(),
        args = {
            scopes = scopes,
            client_id = clientid,
        },
    }, clientid, callback)
end

Discord.OOP:Register('RPC', RPC, 'EventEmitter')