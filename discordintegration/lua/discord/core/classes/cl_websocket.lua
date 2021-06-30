local WebSocket = {}

function WebSocket:Init()
    self.frame = vgui.Create('DFrame')
    self.frame:SetSize(0, 0)

    self.html = vgui.Create('DHTML', frame)

    self.ready = false
    self.connected = false
    self.queue = {}

    self.html.OnDocumentReady = function()
        timer.Simple(0, function()
            self.ready = true
            if self.connectto then
                self:Connect(self.connectto)
                self.connectto = nil
            end

            self:emit('ready')
        end)
    end
    
    self.html:AddFunction('gmod', 'open', function()
        self.connected = true

        while(#self.queue > 0) do
            self:Send(table.remove(self.queue, 1))
        end

        self:emit('open')
    end)

    self.html:AddFunction('gmod', 'message', function(data)
        self:emit('message', data)
    end)

    self.html:AddFunction('gmod', 'error', function(err)
        self:emit('error', err)
    end)

    self.html:AddFunction('gmod', 'close', function()
        self.connected = false
        self:emit('close')
    end)

    self.html:SetHTML([[
    <script>
        function ws(url) {
            websocket = new WebSocket(url);
            websocket.onopen = function() {
                gmod.open();
            };
            websocket.onmessage = function(data) {
                gmod.message(data.data);
            };
            websocket.onerror = function(err) {
                gmod.error(err);
            };
            websocket.onclose = function() {
                gmod.close();
                window.websocket = null;
            };
            window.websocket = websocket;
        }
    </script>
    ]])
    self.html:SetAllowLua(true)
end

function WebSocket:Connect(URL)
    if self.ready then
        self.html:Call('ws("' .. URL .. '")')
    else
        self.connectto = URL
    end
end

function WebSocket:Send(data)
    if self.connected then
        self.html:Call([[if(window.websocket) { window.websocket.send(']] .. data .. [[') }]])
    else
        table.insert(self.queue, data)
    end
end

function WebSocket:Disconnect()
    self.html:Call('if(window.websocket) { window.websocket.close(); window.websocket = null; }')
end

function WebSocket:Destroy()
    self:destroy()
    
    if self.frame then
        self:Disconnect()
        self.frame:Close()
        self.frame = nil
    end
end

Discord.OOP:Register('WebSocket', WebSocket, 'EventEmitter')