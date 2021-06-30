local API = {}

function API:Constructor()
    self._ws = Discord.OOP:New('WebSocket')
    self._ws:Init()

    self._attempts = 0
    self._connected = false
end

function API:Init()
    self._ws:once('open', function()
        hook.Run('Discord_Backend_Connected')
    end)

    self._ws:on('open', function()
        Discord:Log('Connected to Backend!')

        self._attempts = 0
        self._connected = true
    end)

    self._ws:on('message', function(message)
        local json = util.JSONToTable(message)
        if not json then return Discord:Log('Invalid JSON received: ' .. message) end

        if json.op == Discord.OP.PING then
            self:Send({
                op = Discord.OP.PONG,
                d = json.d,
            })
            return
        elseif json.op == Discord.OP.ERROR then
            Discord:Chat(Discord.Util:GetLang(json.d))
            Discord:Error(Discord.Util:GetLang(json.d))
            return
        elseif json.op == Discord.OP.CONSOLE_MESSAGE then
            Discord:Log(json.d)
            return
        elseif json.op == Discord.OP.CHAT_MESSAGE then
            Discord:Chat(Discord.Util:GetLang(json.d.id, json.d.data))
            return
        end

        self:emit('payload', json)
        self:emit('payload_' .. json.op, json.d)
    end)

    self._ws:on('close', function()
        if self._connected then Discord:Log('Disconnected from backend.') end
        self._connected = false

        if self._attempts <= 3 then
            timer.Create(tostring(self), 10 * math.min(self._attempts, 6), 1, function()
                if self._attempts <= 3 then
                    self:Connect()
                else
                    self._attempts = 1
                    self:emit('request_key')
                end
            end)
        else
            timer.Destroy(tostring(self))
            
            self._attempts = 1
            self:emit('request_key')
        end
    end)

    self._ws:on('error', function(err)
        Discord:Error('WebSocket errored: ' .. (err or '<NO ERROR RETURNED>'))
    end)
end

function API:Connect()
    self._attempts = self._attempts + 1
    self._ws:Disconnect()
    self._ws:Connect(Discord.Backend.WebSocket_URL .. '?access_token=' .. Discord.Backend.Key .. '&type=client&sid64=' .. LocalPlayer():SteamID64())
end

function API:Send(payload)
    self._ws:Send(util.TableToJSON(payload))
end

function API:Destroy()
    self._ws:Destroy()

    timer.Destroy(tostring(self))
end

Discord.OOP:Register('API', API, 'EventEmitter')