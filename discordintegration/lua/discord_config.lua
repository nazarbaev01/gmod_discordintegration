Discord.Config = {
    EnabledModules = {
        ['Relay'] = true,
        ['Join Rewards'] = true,
        ['Rank Sync'] = false,
    },

    --[[
        HibernateThink

        This'll automatically enable sv_hibernate_think to make all timers
        and http requests work. (Highly recommended to keep enabled)
    ]]
    HibernateThink = true,

    --[[
        Creating Discord application:
        Go to https://discordapp.com/developers/applications/me and
        click on "Create an application".
        
        Set the name (and icon) to anything you want. It's used for as title
        for Rich Presence, bot name and application name when requesting
        permissions to join your Discord or link account.
        
        Copy the Client ID and Client Secret to the fields below.
    ]]
	ClientID = '856425777523982367',
	ClientSecret = 'Vo9cfLjrKf6vU-rYymHWB0qQeX1jOZgj',

    --[[
        Now navigate to the "OAuth2" tab on the left.
        Click the "Add Redirect" button and add the following URL into it:
        https://garrysmod.site/discord

        Now click the "Bot" tab on the left.
        Then click on the "Add Bot" button, then confirm it's creation.

        After the bot gets created, click on the "Click to reveal token"
        button and copy and paste the WHOLE token in to the field below.
        (You may also want to check off the "Public Bot" checkbox, if you
        don't want to allow other people to invite your bot to their Discord)
    ]]
	BotToken = 'ODU2NDI1Nzc3NTIzOTgyMzY3.YNA2qA.mJG_4PUMLJJdSO6WEFiX-UnPOSE',

    --[[
        Inviting your bot to your Discord:

        Copy the Client ID and replace the "INSERT_CLIENT_ID_HERE" part at
        the end of the following url:
        https://discordapp.com/oauth2/authorize?scope=bot&permissions=805308416&client_id=856425777523982367

        Then open the link in your browser and select your Discord from the list.
        Then authorize the application and you're done!

        NOTE: The bot needs all permissions to work (unless you don't want to use
        rank sync, you can disable manage roles permission)
    ]]

    --[[
        GuildID

        Your discord server's guild ID.

        Enable dev mode in Discord Settings by navigating into the "Appearance" tab
        and check the Developer Mode tickbox. Then right click your server and
        select "Copy ID" and copy it to the field below.
    ]]
	GuildID = '784059134366056468',

    --[[

            END OF REQUIRED CONFIGURATION

    ]]



    --[[

            Relay Configuration

    ]]

    Relay = {
        --[[
            Channels

            "Relay" will have all the relay messages, and
            "Admin" will have all logging messages (ULX, SG, etc.)

            Either channel id or channel name (without #) are valid arguments.
            If the bot will be in multiple servers, use ID or unique channel names
            to avoid them conflicting.
            
            If you want to get the channel id:
            Enable dev mode in Discord Settings by navigating into
            the "Appearance" tab and check the Developer Mode tickbox.
            Then right click your channel and select "Copy ID".

            DEVELOPER:
            You can add additional channels here with name => channel id/name
            so that you can use them in your code and as argument for Message:SetChannel.
            Refer to Developer API on script page for additional info.
        ]]
        Channels = {
			Relay = '859876986926137364',
			Admin = '847901980839116800',
        },
        
        --[[
            BotPrefix

            Prefix for all bot commands (e.g: !help)
        ]]
        BotPrefix = '!!',

        --[[
            BotStatus

            Displayed as the bot's status. Max 32 characters.
        ]]
        BotStatus = 'sex 18+',

        --[[
            NamePrefix

            Prefix all players names with certain string (e.g: [GMOD])
        ]]
        NamePrefix = '[GMOD]',

        --[[
            RelayChat

            Should chat messages get relayed into Discord?
        ]]
        RelayChat = true,

        --[[
            RelayJoinLeave

            Should join/leave messages get relayed into Discord?
        ]]
        RelayJoinLeave = true,

        --[[
            Mentioning

            Allow mentioning of Discord users from Gmod -> Discord
        ]]
        Mentioning = false,

        --[[
            TeamChatEnabled

            Should team chat be relayed into Discord?
        ]]
        TeamChatEnabled = false,

        --[[
            SendOnlineMessage

            Should "Server is now online!" type of message be sent on server bootup?
            NOTE: Translatable in discord_lang.lua
        ]]
        SendOnlineMessage = true,

        --[[
            BlockedCommands

            Messages starting with the following strings won't be relayed.
            NOTE: Empty ({}) for disabled
        ]]
        BlockedCommands = {'!', '/', '.'},

        --[[
            WhitelistedCommands

            Only messages starting with the following strings will be relayed.
            NOTE: Has hierarchu over BlockedCommands, empty ({}) for disabled
        ]]
        WhitelistedCommands = {},

        --[[
            PreventGhosting - TTT Only

            Should dead peoples messages b relayed into Discord?
        ]]
        PreventGhosting = true,

        --[[
            AdminRanks

            Extra admin ranks that should be count as staff for status command.
            
            e.g:
            AdminRanks = {"owner", "admin"},
        ]]
        AdminRanks = {owner, admin},

        --[[
            DiscordPermissions

            Permissions for each role in Discord for commands.

            e.g:
            ["rolename"] = {
                "commandname",
                "anothercommand",
            },

            All possible commands:
            status, help, rcon, lua, kick, ss, job (if bWhitelist integration is enabled)

            NOTE: All discord users have the @everyone role
        ]]
        DiscordPermissions = {
            ['@everyone'] = {
                'status',
                'help',
            },
            ['admin, owner'] = {
                'rcon',
                'lua',
                'kick',
                'ss',
                'job',
            },
        },

        --[[
            ULXLogging

            Logs every ulx action to the configured admin channel.
            NOTE: This will enable ulx logfile.
        ]]
        ULXLogging = true,

        --[[
            ULXBlacklist

            The following keywords in ULX logs will be ignored and not relayed.
        ]]
        ULXBlacklist = {
            ' spawned ',
            ' connected.',
            'Dropped ',
            ' used the tool ',
            ': ', -- Try not to log chat messages
        },

        --[[
            ULXWhitelist

            Only the following keywords in ULX logs will be relayed.
            NOTE: Has hieararchy over ULXBlacklist.
        ]]
        ULXWhitelist = {},

        --[[
            SGLogging

            Logs every serverguard action to the configured admin channel.
        ]]
        SGLogging = true,

        --[[
            SGBlacklist

            The following keywords in SS logs will be ignored and not relayed.
        ]]
        SGBlacklist = {
            ' used tool "',
            ' un-froze (reloaded) using the physgun',
            ' spawned prop "',
            ' spawned ragdoll "',
            ' spawned vehicle "',
            ' spawned effect "',
            ' spawned npc "',
            ' spawned SENt "',
            ' spawned SWEP "',
            '> is attempting to connect.',
            '> has spawned in the server',
            '> has left the server',
            ': ', -- Try not to log chat messages
        },

        --[[
            SGWhitelist

            Only the following keywords in SG logs will be relayed.
            NOTE: Has hieararchy over SGBlacklist.
        ]]
        SGWhitelist = {},

        --[[
            CAC

            Enable CAC integration?
            Takes screenshot of cheating player when detected and posts
            detection list with the screenshot in the configured admin channel.
        ]]
        CAC = true,

        --[[
            SimpLAC

            Enable SimpLAC integration?
            Takes screenshot of cheating player when detected and posts
            detection list with the screenshot in the configured admin channel.
        ]]
        SimpLAC = false,

        --[[
            ModernAC

            Enable ModernAC integration?
            Takes screenshot of cheating player when detected and posts
            detection list with the screenshot in the configured admin channel.
        ]]
        ModernAC = true,

        --[[
            bWhitelist

            Enable bWhitelist integration?
            Allows you to whitelist/blacklist people from jobs in Discord.
        ]]
        bWhitelist = false,
    },

    --[[
            
            End of Relay Configuration

    ]]



    --[[

            Join Rewards Configuration

    ]]

    JoinRewards = {
        --[[
            PopupOnJoin

            Show "Join our Discord" popup on player join?
            NOTE: Text configurable in discord_lang.lua
        ]]
        PopupOnJoin = true,

        --[[
            OneTime

            Should the popup be displayed only once, on first join?
        ]]
        OneTime = false,

        --[[
            ChatCommand

            Chat command to join Discord.
        ]]
        ChatCommand = '!discord',

        --[[
            ConsoleCommand

            Console command to join Discord.
        ]]
        ConsoleCommand = 'discord_join',

        --[[
            ShouldNotReward

            If you've used any other Discord reward addons, you may need to figure out
            how they store who has already been awarded, and return true if they SHOULDN'T
            be awarded due to already using the previous addon.
        ]]
        ShouldNotReward = function(ply)

        end,

        --[[
            RewardFunc

            Custom lua function that is ran when player joins your Discord.
        ]]
        RewardFunc = function(ply)
            if ply.AddMoney then ply:AddMoney(97000) end
        end,
    },

    --[[

        End of Join Rewards Configuration

    ]]



    --[[

            Rank Sync Configuration

    ]]

    RankSync = {
        --[[
            LinkChatCommand

            Chat command to start linking Discord account.
        ]]
        LinkChatCommand = '!link',

        --[[
            LinkConsoleCommand

            Console command to start linking Discord account.
        ]]
        LinkConsoleCommand = 'discord_link',

        --[[
            SyncChatCommand

            Chat command to manually sync Discord ranks to in-game.
        ]]
        SyncChatCommand = '!sync',

        --[[
            SyncConsoleCommand

            Console command to manually sync Discord ranks to in-game.
        ]]
        SyncConsoleCommand = 'discord_sync',

        --[[
            SyncDiscordCommand

            Discord command to manually sync in-game ranks to Discord.
        ]]
        SyncDiscordCommand = 'sync',

        --[[
            DiscordToGmod

            Should role changes in Discord update rank in-game?
        ]]
        DiscordToGmod = false,

        --[[
            SyncableDiscordRanks

            Which rank should be given in-game if you get a specific Discord role?
            NOTE: The highest role in Discord will be always the role you get in-game.

            e.g:
            ["discord role"] = "rank in-game",
        ]]
        SyncableDiscordRanks = {
            ['Owner'] = 'root',
            ['Участник'] = 'user',
        },

        --[[
            DefaultRank

            If all roles get removed, which rank is the default to fallback to?
        ]]
        DefaultRank = 'user',

        --[[
            GmodToDiscord

            Should role changes in-game update role in Discord?
        ]]
        GmodToDiscord = true,

        --[[
            SyncableGmodRanks

            Which rank should be given in Discord if you get a specific in-game rank?
            NOTE: The old role will be removed if possible.

            e.g:
            ["rank in-game"] = "discord role",
        ]]
        SyncableGmodRanks = {
            ['root'] = 'Owner',
        },

        --[[
            AssociatedRanks

            Which ranks should be given alongside other ranks in Discord? These
            should only be used for aesthetic purposes (organization/sorting) and
            should not include any new permissions or priveleges. They depend
            on the original Discord rank, so if it gets removed so do these.
            Though if the aesthetic rank gets removed, nothing will happen.
            Any of the aesthetic ranks shouldn't also be above if you want to avoid
            any unintended behavior.

            e.g:
            ['Discord Rank'] = { 'Discord Associated Rank 1', 'Discord Associated Rank 2' },
        ]]
        AssociatedRanks = {
            ['Owner'] = {'Staff'},
        },
    },

    --[[

        End of Rank Sync Configuration

    ]]
}