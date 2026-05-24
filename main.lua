do
	local _E = getgenv();
	local script_id = game:GetService("HttpService"):GenerateGUID(false);
	_E.CurrentScriptID = script_id;
	local isYubX = false;
	if identifyexecutor then
		local execName = tostring(identifyexecutor()):lower();
		if (execName:find("yub") or execName:find("yubx")) then
			isYubX = true;
		end
	end
	local fsWrite = not isYubX and writefile ;
	local fsRead = not isYubX and readfile ;
	local fsIsFile = not isYubX and isfile ;
	local fsMakeFolder = not isYubX and makefolder ;
	local fsIsFolder = not isYubX and isfolder ;
	if _E.LuxyHub_Unload then
		pcall(_E.LuxyHub_Unload);
	end
	_E.HubRunning = true;
	_E.AFarm = false;
	_E.APredict = false;
	_E.TBrainrot = {
		"All"
	};
	_E.TRarity = {
		"All"
	};
	_E.TMutation = {
		"All"
	};
	_E.ATrain = false;
	_E.ATrainCollect = false;
	_E.TrainCollectDelay = 20;
	_E.IsFlashCollecting = false;
	_E.NextFlashCollect = 0;
	_E.A2xTrain = false;
	_E.ACollect = false;
	_E.CollectDelay = 60;
	_E.AUpgrade = false;
	_E.TUpgrade = {
		"Any"
	};
	_E.MaxUpLevel = 1;
	_E.PlotBrainrotList = {
		"Any"
	};
	_E.ARebirth = false;
	_E.APlotUpgrade = false;
	_E.APlaceBest = false;
	_E.TProtectedBrainrots = {};
	_E.AProtectFilter = false;
	_E.IsPlacingPet = false;
	_E.ABuySpeed = false;
	_E.ABuyWeights = false;
	_E.ABuyBest = false;
	_E.TTargetWeight = "None";
	_E.ASellFilter = false;
	_E.SellDelay = 20;
	_E.TSSellBrainrot = {
		"Any"
	};
	_E.TSSellRarity = {
		"Any"
	};
	_E.TSSellMutation = {
		"Any"
	};
	_E.AVolcanoCollect = false;
	_E.AVolcanoUpgrade = false;
	_E.TVolcanoUpgrade = "Any";
	_E.AVolcanoBuy = false;
	_E.TVolcanoBuy = "Any";
	_E.CollectedShards = {};
	_E.WBBrainrot = {
		"Any"
	};
	_E.WBRarity = {
		"Any"
	};
	_E.WBMutation = {
		"Any"
	};
	_E.WebhookURL = "";
	_E.AWebhook = false;
	_E.AAutoFav = false;
	_E.AKickUntilTarget = false;
	_E.TTargetRarity = "Any";
	_E.TTargetMutation = "Any";
	_E.KickAttempts = 0;
	_E.LastKickResult = nil;
	_E.makefolder = nil;
	_E.writefile = nil;
	_E.readfile = nil;
	_E.listfiles = nil;
	_E.isfile = nil;
	_E.isfolder = nil;
	local HttpService = game:GetService("HttpService");
	local ConfigFolder = "LuxyHub_Configs";
	local ConfigFileName = ConfigFolder .. "/KickBlox_Auto.json" ;
	local function SaveConfig()
		if not fsWrite then
			return;
		end
		local ConfigData = {
			AFarm = _E.AFarm,
			APredict = _E.APredict,
			ATrain = _E.ATrain,
			A2xTrain = _E.A2xTrain,
			ACollect = _E.ACollect,
			CollectDelay = _E.CollectDelay,
			ARebirth = _E.ARebirth,
			APlotUpgrade = _E.APlotUpgrade,
			APlaceBest = _E.APlaceBest,
			ABuySpeed = _E.ABuySpeed,
			ABuyWeights = _E.ABuyWeights,
			ABuyBest = _E.ABuyBest,
			ASellFilter = _E.ASellFilter,
			SellDelay = _E.SellDelay,
			TProtectedBrainrots = _E.TProtectedBrainrots,
			AProtectFilter = _E.AProtectFilter,
			WBBrainrot = _E.WBBrainrot,
			WBRarity = _E.WBRarity,
			WBMutation = _E.WBMutation,
			WebhookURL = _E.WebhookURL,
			AWebhook = _E.AWebhook,
			AAutoFav = _E.AAutoFav,
			TBrainrot = _E.TBrainrot,
			TRarity = _E.TRarity,
			TMutation = _E.TMutation,
			TUpgrade = _E.TUpgrade,
			TTargetWeight = _E.TTargetWeight,
			TSSellBrainrot = _E.TSSellBrainrot,
			TSSellRarity = _E.TSSellRarity,
			TSSellMutation = _E.TSSellMutation,
		AVolcanoCollect = _E.AVolcanoCollect,
		AVolcanoUpgrade = _E.AVolcanoUpgrade,
		TVolcanoUpgrade = _E.TVolcanoUpgrade,
		AVolcanoBuy = _E.AVolcanoBuy,
		TVolcanoBuy = _E.TVolcanoBuy,
		AKickUntilTarget = _E.AKickUntilTarget,
		TTargetRarity = _E.TTargetRarity,
		TTargetMutation = _E.TTargetMutation
	};
		pcall(function()
			if (fsIsFolder and not fsIsFolder(ConfigFolder)) then
				if fsMakeFolder then
					fsMakeFolder(ConfigFolder);
				end
			end
			fsWrite(ConfigFileName, HttpService:JSONEncode(ConfigData));
		end);
	end
	local function LoadConfig()
		if ( not fsRead or not fsIsFile) then
			return;
		end
		local success, data = pcall(function()
			if fsIsFile(ConfigFileName) then
				local jsonString = fsRead(ConfigFileName);
				if (jsonString and (jsonString ~= "")) then
					return HttpService:JSONDecode(jsonString);
				end
			end
			return nil;
		end);
		if (success and data) then
			for key, value in pairs(data) do
				if (_E[key] ~= nil) then
					_E[key] = value;
				end
			end
			pcall(function()
				game:GetService("StarterGui"):SetCore("SendNotification", {
					Title = "Luxy Hub",
					Text = "Config Loaded Successfully!",
					Duration = 3
				});
			end);
		end
	end
	LoadConfig();
	local LibraryURL = "https://raw.githubusercontent.com/Omnie7/Luxy-Core/main/Library/LuxyV3.lua?nocache=" .. tostring(math.random(10000, 99999)) ;
	local DataURL = "https://raw.githubusercontent.com/Omnie7/Luxy-Core/main/Data/KickBlox.luau";
	local AnalyticsURL = "https://raw.githubusercontent.com/Omnie7/Luxy-Core/main/Modules/Analytics.lua";
	local LuxyLib, DB, Analytics = nil, nil, nil;
	local uiSuccess, uiResult = pcall(function()
		local code = game:HttpGet(LibraryURL);
		if (code and (code ~= "") and not code:find("404: Not Found")) then
			local func, syntaxErr = loadstring(code);
			if func then
				return func();
			else
				warn("[Luxy Hub] UI Syntax Error dari GitHub: " .. tostring(syntaxErr));
			end
		else
			warn("[Luxy Hub] Gagal fetch UI dari GitHub. URL salah atau file belom ada.");
		end
		return nil;
	end);
	if uiSuccess then
		LuxyLib = uiResult;
	end
	pcall(function()
		local code = game:HttpGet(DataURL);
		if (code and (code ~= "")) then
			DB = loadstring(code)();
		end
	end);
	pcall(function()
		Analytics = loadstring(game:HttpGet(AnalyticsURL))();
	end);
	if Analytics then
		pcall(function()
			Analytics:Track();
		end);
	end
	pcall(function()
		if DB then
			local GameMutations = require(game:GetService("ReplicatedStorage").Shared.Data.MutationData);
			if (GameMutations and GameMutations.ValidMutations) then
				DB.MutationOptions = GameMutations.ValidMutations;
			end
		end
	end);
	local function InjectFilterOptions(optionList)
		local newList = {
			"Any"
		};
		local added = {
			Any = true,
			All = true,
			None = true,
			["--"] = true
		};
		for _, opt in ipairs(optionList or {}) do
			if not added[opt] then
				table.insert(newList, opt);
				added[opt] = true;
			end
		end
		return newList;
	end
	if DB then
		DB.BrainrotOptions = InjectFilterOptions(DB.BrainrotOptions);
		DB.RarityOptions = InjectFilterOptions(DB.RarityOptions);
		DB.MutationOptions = InjectFilterOptions(DB.MutationOptions);
	end
	local function NormalizeFilterState(tbl)
		if (type(tbl) == "string") then
			tbl = {
				tbl
			};
		end
		if (type(tbl) == "table") then
			for i, v in ipairs(tbl) do
				if ((v == "All") or (v == "--") or (v == "None")) then
					tbl[i] = "Any";
				end
			end
			local hash = {};
			local clean = {};
			for _, v in ipairs(tbl) do
				if not hash[v] then
					table.insert(clean, v);
					hash[v] = true;
				end
			end
			return clean;
		end
		return {
			"Any"
		};
	end
	_E.TBrainrot = NormalizeFilterState(_E.TBrainrot);
	_E.TMutation = NormalizeFilterState(_E.TMutation);
	if ( not LuxyLib or not DB) then
		pcall(function()
			game:GetService("StarterGui"):SetCore("SendNotification", {
				Title = "Luxy Hub Error",
				Text = "Failed to load Core Libraries! Check F9 Console for details.",
				Duration = 7
			});
		end);
		return;
	end
	local UI = {};
	local Icons = {
		home = "10723407389",
		playcircle = "10734923214",
		shoppingcart = "10734952479",
		info = "10723415903",
		settings = "10734950020"
	};
	local function Icon(name)
		return "rbxassetid://" .. tostring(Icons[name] or Icons.home) ;
	end
	UI.CreateWindow = function(self, title, version, icon)
		local ok, result = pcall(function()
			return LuxyLib:CreateWindow(title .. " | " .. version);
		end);
		if not ok then
			warn("[ADAPTER ERROR] CreateWindow failed: " .. tostring(result));
		end
		return result;
	end;
	UI.CreateTab = function(self, win, name, icon)
		local ok, result = pcall(function()
			return win:CreateTab(name, icon);
		end);
		if not ok then
			warn("[ADAPTER ERROR] CreateTab failed!(nama, icon). Error: " .. tostring(result));
		end
		return result;
	end;
	UI.CreateSection = function(self, tab, name)
		pcall(function()
			tab:CreateSection(name);
		end);
	end;
	UI.CreateLabel = function(self, tab, title, content)
		pcall(function()
			tab:CreateChangelog(title, content);
		end);
	end;
	UI.CreateDropdown = function(self, tab, title, options, isMulti, default, callback)
		if (type(default) == "function") then
			callback = default;
			default = {};
		end
		local wrappedCallback = function(SelectedItems)
			if not isMulti then
				local selectedStr = ((type(SelectedItems) == "table") and SelectedItems[1]) or tostring(SelectedItems) ;
				callback(selectedStr);
			else
				callback(SelectedItems);
			end
		end;
		return tab:CreateSelect(title, "", options, default, wrappedCallback);
	end;
	UI.CreateToggle = function(self, tab, title, arg3, arg4, arg5)
		local desc, default, cb;
		if (type(arg3) == "string") then
			desc, default, cb = arg3, arg4, arg5;
		else
			desc, default, cb = "", arg3, arg4;
		end
		local ok, result = pcall(function()
			tab:CreateToggle(title, desc, default, cb);
		end);
		if not ok then
			warn("[ADAPTER ERROR] CreateToggle failed: " .. tostring(result));
		end
	end;
	UI.CreateSlider = function(self, tab, title, min, max, default, callback)
		pcall(function()
			tab:CreateSlider(title, min, max, default, callback);
		end);
	end;
	UI.CreateButton = function(self, tab, title, callback)
		pcall(function()
			tab:CreateButton(title, "", nil, callback);
		end);
	end;
	UI.Notify = function(self, win, title, content, duration)
		pcall(function()
			LuxyLib:Notify({
				Title = title,
				Content = content,
				Duration = duration
			});
		end);
	end;
	UI.BuildBuiltInSettings = function(self, win)
		return true;
	end;
	local Win = UI:CreateWindow("Luxy Hub", "| v3.5", "rbxassetid://82246802133344");
	local TabInfo = UI:CreateTab(Win, "Info", Icon("info"));
	local Tab1 = UI:CreateTab(Win, "Main", Icon("home"));
	local TabAuto = UI:CreateTab(Win, "Automatically", Icon("playcircle"));
	local TabShop = UI:CreateTab(Win, "Shop", Icon("shoppingcart"));
	local TabMisc = UI:CreateTab(Win, "Misc", Icon("settings"));
	local Plrs = game:GetService("Players");
	local WS = game:GetService("Workspace");
	local RS = game:GetService("ReplicatedStorage");
	local LP = Plrs.LocalPlayer;
	_E.LuxyHub_Unload = function()
		_E.HubRunning = false;
		_E.CurrentScriptID = nil;
		for k, v in pairs(_E) do
			if (k:match("^A") and (type(v) == "boolean")) then
				_E[k] = false;
			end
		end
		if (LP.Character and LP.Character:FindFirstChild("Humanoid")) then
			LP.Character.Humanoid.MaxSlopeAngle = 45;
		end
	end;
	local function ParseWallet(strVal)
		if not strVal then
			return 0;
		end
		if (type(strVal) == "number") then
			return strVal;
		end
		local cleanStr = string.gsub(tostring(strVal), "[,%s%$]", "");
		local numStr, suffix = string.match(cleanStr, "^([%d%.]+)(%a*)$");
		if not numStr then
			return tonumber(cleanStr) or 0 ;
		end
		local num = tonumber(numStr) or 0 ;
		local suffixes = {
			K = 3,
			M = 6,
			B = 9,
			T = 12,
			Q = 15,
			Qi = 18,
			S = 21,
			Sp = 24,
			O = 27,
			N = 30,
			D = 33
		};
		if (suffix and (suffix ~= "") and suffixes[suffix]) then
			return num * (10 ^ suffixes[suffix]) ;
		end
		return num;
	end
	local function InfMathToNumber(val)
		if (type(val) == "number") then
			return val;
		end
		local str = tostring(val);
		local base, exp = str:match("^(%-?[%d%.]+)%s*,%s*(%-?%d+)$");
		if (base and exp) then
			return tonumber(base) * (10 ^ tonumber(exp)) ;
		end
		return ParseWallet(str);
	end
	local MyMoney = 0;
	local MyKickLevel = 0;
	local MyRebirthLevel = 0;
	pcall(function()
		local ClientBalanceService = require(RS.Modules.ServicesLoader.ClientBalanceService);
		local KickServiceClient = require(RS.Modules.ServicesLoader.KickServiceClient);
		local RebirthServiceClient = require(RS.Modules.ServicesLoader.RebirthServiceClient);
		MyMoney = InfMathToNumber(ClientBalanceService.Balance);
		ClientBalanceService.CoinsChanged:Connect(function(v)
			MyMoney = InfMathToNumber(v);
		end);
		if KickServiceClient.Level then
			MyKickLevel = KickServiceClient.Level;
		end
		KickServiceClient.LevelChanged:Connect(function(v)
			MyKickLevel = v;
		end);
		if RebirthServiceClient.RebirthLevel then
			MyRebirthLevel = RebirthServiceClient.RebirthLevel;
		end
		RebirthServiceClient.RebirthChanged:Connect(function(v)
			MyRebirthLevel = v;
		end);
	end);
	local function ShouldKeepPet(cBrainrot, cMutation)
		if (type(_E.TBrainrot) == "string") then
			_E.TBrainrot = {
				_E.TBrainrot
			};
		end
		if (type(_E.TMutation) == "string") then
			_E.TMutation = {
				_E.TMutation
			};
		end
		local filterBrainrotActive = true;
		if (( # _E.TBrainrot == 0) or table.find(_E.TBrainrot, "Any") or table.find(_E.TBrainrot, "All")) then
			filterBrainrotActive = false;
		end
		local filterMutationActive = true;
		if (( # _E.TMutation == 0) or table.find(_E.TMutation, "Any") or table.find(_E.TMutation, "All")) then
			filterMutationActive = false;
		end
		if ( not filterBrainrotActive and not filterMutationActive) then
			return true;
		end
		local matchBrainrot = not filterBrainrotActive or (table.find(_E.TBrainrot, cBrainrot) ~= nil) ;
		local matchMutation = not filterMutationActive or (table.find(_E.TMutation, cMutation) ~= nil) ;
		return matchBrainrot and matchMutation ;
	end
	local function isMatch(targetList, currentVal, isMutation)
		if (type(targetList) == "string") then
			targetList = {
				targetList
			};
		end
		if ( not targetList or ( # targetList == 0)) then
			return true;
		end
		if table.find(targetList, "All") then
			return true;
		end
		return table.find(targetList, currentVal) ~= nil ;
	end
	local function isStrictMatch(targetList, currentVal, isMutation)
		if (type(targetList) == "string") then
			targetList = {
				targetList
			};
		end
		if ( not targetList or ( # targetList == 0)) then
			return true;
		end
		if table.find(targetList, "Any") then
			return true;
		end
		if table.find(targetList, "All") then
			if (isMutation and (currentVal == "None")) then
				return false;
			end
			return true;
		end
		if table.find(targetList, "None") then
			if not isMutation then
				return true;
			end
		end
		return table.find(targetList, currentVal) ~= nil ;
	end
	local function GetMyPlot()
		local success, PlotService = pcall(function()
			return require(RS.Modules.ServicesLoader.ClientPlotService);
		end);
		if (success and PlotService and PlotService.Model) then
			return PlotService.Model;
		end
		local plots = WS:FindFirstChild("Plots");
		if plots then
			for _, plot in ipairs(plots:GetChildren()) do
				local ownerAttr = plot:GetAttribute("Owner");
				if ((ownerAttr == LP.Name) or (ownerAttr == LP.DisplayName)) then
					return plot;
				end
			end
		end
		return nil;
	end
	local function GetMutation(petModel)
		for _, child in ipairs(petModel:GetChildren()) do
			if (DB.MutationOptions and table.find(DB.MutationOptions, child.Name) and (child.Name ~= "None") and (child.Name ~= "Any")) then
				return child.Name;
			end
		end
		return "None";
	end
	local NetDir = RS:FindFirstChild("Shared");
	if NetDir then
		NetDir = NetDir:FindFirstChild("Packages");
	end
	if NetDir then
		NetDir = NetDir:FindFirstChild("Network");
	end
	local KkEvt = (NetDir and NetDir:FindFirstChild("rev_KickEvent")) or RS:FindFirstChild("rev_KickEvent", true) ;
	local BCollectEvt = (NetDir and NetDir:FindFirstChild("rev_B_Collect")) or RS:FindFirstChild("rev_B_Collect", true) ;
	local BUpgradeEvt = (NetDir and NetDir:FindFirstChild("rev_B_Upgrade")) or RS:FindFirstChild("rev_B_Upgrade", true) ;
	local SpeedUpEvt = (NetDir and NetDir:FindFirstChild("rev_SPEED_UPGRADE")) or RS:FindFirstChild("rev_SPEED_UPGRADE", true) ;
	local ShopBuyEvt = (NetDir and NetDir:FindFirstChild("rev_Shop_Buy")) or RS:FindFirstChild("rev_Shop_Buy", true) ;
	local WeightEquipEvt = (NetDir and NetDir:FindFirstChild("rev_WeightEquip")) or RS:FindFirstChild("rev_WeightEquip", true) ;
	local SellAllEvt = (NetDir and NetDir:FindFirstChild("ref_B_SellAll")) or RS:FindFirstChild("ref_B_SellAll", true) ;
	local SellSingleEvt = (NetDir and NetDir:FindFirstChild("ref_B_Sell")) or RS:FindFirstChild("ref_B_Sell", true) ;
	local RebirthEvt = (NetDir and NetDir:FindFirstChild("rev_RebirthRequest")) or RS:FindFirstChild("rev_RebirthRequest", true) ;
	local PlotUpgradeEvt = (NetDir and NetDir:FindFirstChild("rev_bs_upgrade")) or RS:FindFirstChild("rev_bs_upgrade", true) ;
	local SInteractEvt = (NetDir and NetDir:FindFirstChild("rev_S_Interact")) or RS:FindFirstChild("rev_S_Interact", true) ;
	local SummonEvt = (NetDir and NetDir:FindFirstChild("rev_sbe")) or RS:FindFirstChild("rev_sbe", true) ;
	local ToggleFavEvt = (NetDir and NetDir:FindFirstChild("rev_ToggleFav")) or RS:FindFirstChild("rev_ToggleFav", true) ;
	local weightsFolder = RS:FindFirstChild("Objects") and RS.Objects:FindFirstChild("WeightModels") ;
	local function DecodeBase64(str)
		local crypt = (syn and syn.crypt) or crypt ;
		if (crypt and crypt.b64decode) then
			local success, decoded = pcall(crypt.b64decode, str);
			if success then
				return decoded;
			end
		end
		local b = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
		str = string.gsub(str, "[^" .. b .. "=]", "");
		return (string.gsub(str, ".", function(x)
			if (x == "=") then
				return "";
			end
			local r, f = "", b:find(x) - 1 ;
			for i = 6, 1, - 1 do
				r = r .. (((((f % (2 ^ i)) - (f % (2 ^ (i - 1)))) > 0) and "1") or "0") ;
			end
			return r;
		end):gsub("%d%d%d%d%d%d%d%d", function(x)
			local c = 0;
			for i = 1, 8 do
				c = c + (((x:sub(i, i) == "1") and (2 ^ (8 - i))) or 0) ;
			end
			return string.char(c);
		end));
	end
	local WeightsDataObj = RS:FindFirstChild("WeightsData", true);
	local WeightsData = nil;
	pcall(function()
		if WeightsDataObj then
			WeightsData = require(WeightsDataObj);
		end
	end);
	local SpeedData = nil;
	pcall(function()
		SpeedData = require(RS.Shared.Data.SpeedData);
	end);
	local RebirthData = nil;
	pcall(function()
		RebirthData = require(RS.Shared.Data.RebirthData);
	end);
	local SacrificeData = nil;
	pcall(function()
		SacrificeData = require(RS.Shared.Data.SacrificeData);
	end);
	local WeatherServiceClient = nil;
	pcall(function()
		WeatherServiceClient = require(RS.Modules.ServicesLoader.WeatherService_Client);
	end);
	local ServerLuckClient = nil;
	pcall(function()
		ServerLuckClient = require(game:GetService("ReplicatedStorage").Modules.ServicesLoader.ServerLuckClient);
	end);
	local WeatherOptions = {
		"Any"
	};
	if (SacrificeData and SacrificeData.Recipes) then
		local sortedWeathers = {};
		for weatherName, _ in pairs(SacrificeData.Recipes) do
			if weatherName then
				table.insert(sortedWeathers, weatherName);
			end
		end
		table.sort(sortedWeathers);
		for _, w in ipairs(sortedWeathers) do
			table.insert(WeatherOptions, w);
		end
	end
	local function GetSpeedCost(level)
		if SpeedData then
			local s, c = pcall(function()
				return SpeedData:GetCostForLevel(level + 1);
			end);
			if (s and c) then
				return ParseWallet(tostring(c));
			end
		end
		return math.huge;
	end
	local function GetRebirthCost(level)
		if RebirthData then
			local s, r = pcall(function()
				return RebirthData:GetKickRequirement(level + 1);
			end);
			if (s and r) then
				return ParseWallet(tostring(r));
			end
		end
		return math.huge;
	end
	local function GetWeightPrice(weightName)
		if (WeightsData and WeightsData.Weights and WeightsData.Weights[weightName]) then
			local cost = WeightsData.Weights[weightName].Cost;
			if cost then
				return (cost.first or 0) * (10 ^ (cost.second or 0)) ;
			end
		end
		return math.huge;
	end
	local SortedWeightsCache = nil;
	local function GetSortedWeights()
		if SortedWeightsCache then
			return SortedWeightsCache;
		end
		local list = {};
		if weightsFolder then
			for _, w in ipairs(weightsFolder:GetChildren()) do
				table.insert(list, {
					name = w.Name,
					price = GetWeightPrice(w.Name)
				});
			end
			table.sort(list, function(a, b)
				return a.price < b.price ;
			end);
			SortedWeightsCache = list;
		end
		return list;
	end
	local EntitiesDataCache = nil;
	local BrainrotScoreCache = {};
	pcall(function()
		EntitiesDataCache = require(RS.Shared.Data.EntitiesData);
		if (EntitiesDataCache and EntitiesDataCache.Brainrots) then
			for k, v in pairs(EntitiesDataCache.Brainrots) do
				if v.CPS then
					BrainrotScoreCache[k] = InfMathToNumber(v.CPS);
				end
			end
		end
	end);
	local MutationMultipliers = {
		Golden = 1.5,
		Diamond = 2,
		Plasma = 3,
		Molten = 0.8,
		Radioactive = 4,
		Void = 6,
		Shadow = 7,
		Electrified = 8,
		Rainbow = 10,
		Virus = 12,
		Wet = 15,
		Alien = 20,
		Bacon = 25,
		Enchanted = 30,
		Phantom = 40,
		Astral = 50
	};
	local function GetActualCPS(petName, mutation, level)
		level = level or 1 ;
		local baseCPS = BrainrotScoreCache[petName];
		if not baseCPS then
			local safeName = string.lower(string.gsub(petName, "[%s%p]", ""));
			for k, v in pairs(BrainrotScoreCache) do
				if (string.lower(string.gsub(k, "[%s%p]", "")) == safeName) then
					baseCPS = v;
					break;
				end
			end
		end
		baseCPS = baseCPS or 1 ;
		local mutBuff = (mutation and (mutation ~= "None") and (mutation ~= "") and MutationMultipliers[mutation]) or 1 ;
		return baseCPS * mutBuff * (1.25 ^ (level - 1)) ;
	end
	UI:CreateSection(TabInfo, "Changelog");
	UI:CreateLabel(TabInfo, "UPDATE 3.3 | Kick A Lucky Blox", "[ ! ] Fix Fitur Auto Predick\n" .. "[ ! ] Fix Fitur Auto Machine\n\n" .. "[ ! ] Fix Auto Favorit Brainrots\n" .. "[ ! ] Fix Filter Kick Brainrots\n" .. "[ / ] Etc\n");
	UI:CreateLabel(TabInfo, "UPDATE 3.2 | Kick A Lucky Blox", "[ + ] Added Auto Predik Tonggle.\n" .. "[ + ] Fix Auto Kick Filter.\n\n" .. "[ * ] Fix Bug Webhook.\n" .. "[ * ] Fix Kick Stuck.\n" .. "[ + ] Fix Bug Screen UI.\n");
	UI:CreateSection(Tab1, "Filter Brainrots");
	UI:CreateDropdown(Tab1, "Brainrot", DB.BrainrotOptions, true, _E.TBrainrot, function(Val)
		_E.TBrainrot = Val;
		SaveConfig();
	end);
	UI:CreateDropdown(Tab1, "Mutation", DB.MutationOptions, true, _E.TMutation, function(Val)
		_E.TMutation = Val;
		SaveConfig();
	end);
	_E.CustomKickPowerPercent = 100;
	UI:CreateSlider(Tab1, "Set Kick Power (%)", 1, 100, 100, function(Val)
		_E.CustomKickPowerPercent = Val;
	end);
	UI:CreateToggle(Tab1, "Auto Predict", _E.APredict, function(Val)
		_E.APredict = Val;
		SaveConfig();
		if not Val then
			pcall(function()
				LuxyLib:UpdatePredictHUD(nil);
			end);
		end
	end);
UI:CreateToggle(Tab1, "Auto Kick", _E.AFarm, function(Val)
	_E.AFarm = Val;
	SaveConfig();
	if ( not _E.AFarm and LP.Character and LP.Character:FindFirstChild("Humanoid")) then
		LP.Character.Humanoid.MaxSlopeAngle = 45;
	end
end);
UI:CreateSection(Tab1, "KICK UNTIL TARGET");
UI:CreateDropdown(Tab1, "Target Rarity", DB.RarityOptions, false, _E.TTargetRarity, function(Val)
	_E.TTargetRarity = Val;
	SaveConfig();
end);
UI:CreateDropdown(Tab1, "Target Mutation", DB.MutationOptions, false, _E.TTargetMutation, function(Val)
	_E.TTargetMutation = Val;
	SaveConfig();
end);
UI:CreateToggle(Tab1, "Auto Kick Until Get Target", _E.AKickUntilTarget, function(Val)
	_E.AKickUntilTarget = Val;
	if Val then
		_E.KickAttempts = 0;
		_E.LastKickResult = nil;
	end
	SaveConfig();
end);
UI:CreateButton(Tab1, "Reset Kick Counter", function()
	_E.KickAttempts = 0;
	UI:Notify(Win, "Counter Reset", "Kick attempts counter has been reset to 0", 3);
end);
UI:CreateToggle(Tab1, "Anti-Wave (Godmode)", false, function(val)
		_E.GodmodeEnabled = val;
		if val then
			task.spawn(function()
				while _E.GodmodeEnabled do
					task.wait(0.1);
					pcall(function()
						local char = LP.Character;
						if (char and char:FindFirstChild("Humanoid")) then
							if not char:FindFirstChildOfClass("ForceField") then
								local ff = Instance.new("ForceField");
								ff.Visible = false;
								ff.Parent = char;
							end
						end
						local wavesFolder = workspace:FindFirstChild("Waves");
						if wavesFolder then
							for _, wave in ipairs(wavesFolder:GetChildren()) do
								if (wave:IsA("BasePart") or wave:IsA("MeshPart")) then
									wave.CanCollide = false;
								end
							end
						end
					end);
				end
				pcall(function()
					local char = LP.Character;
					if char then
						local ff = char:FindFirstChildOfClass("ForceField");
						if ff then
							ff:Destroy();
						end
					end
				end);
			end);
		end
	end);
	UI:CreateSection(Tab1, "AUTO TRAIN & CASH");
	UI:CreateToggle(Tab1, "Auto Train + Collect Cash", _E.ATrainCollect, function(Val)
		_E.ATrainCollect = Val;
		if Val then
			_E.NextFlashCollect = 0;
			local hrp = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") ;
			if hrp then
				_E.TrainAnchorCFrame = hrp.CFrame;
			end
		else
			_E.TrainAnchorCFrame = nil;
		end
		SaveConfig();
	end);
	UI:CreateSlider(Tab1, "Collect Interval (Minutes)", 1, 60, _E.TrainCollectDelay, function(Val)
		_E.TrainCollectDelay = Val;
		_E.NextFlashCollect = tick() + (_E.TrainCollectDelay * 60) ;
		SaveConfig();
	end);
	UI:CreateSection(Tab1, "TRAIN & REBIRTH");
	UI:CreateToggle(Tab1, "Auto Train", _E.ATrain, function(Val)
		_E.ATrain = Val;
		SaveConfig();
	end);
	UI:CreateToggle(Tab1, "Auto Claim 2x", _E.A2xTrain, function(Val)
		_E.A2xTrain = Val;
		SaveConfig();
	end);
	UI:CreateToggle(Tab1, "Auto Rebirth", _E.ARebirth, function(Val)
		_E.ARebirth = Val;
		SaveConfig();
	end);
	UI:CreateSection(Tab1, "FARM CASH");
	UI:CreateToggle(Tab1, "Auto Collect Cash", _E.ACollect, function(Val)
		_E.ACollect = Val;
		SaveConfig();
	end);
	UI:CreateSlider(Tab1, "Collect Delay", 1, 600, _E.CollectDelay, function(Val)
		_E.CollectDelay = Val;
		SaveConfig();
	end);
	UI:CreateSection(Tab1, "UPGRADE PLOT");
	UI:CreateToggle(Tab1, "Auto Upgrade Plot", _E.APlotUpgrade, function(Val)
		_E.APlotUpgrade = Val;
		SaveConfig();
	end);
	UI:CreateSection(TabAuto, "PLACE BRAINROT");
	_E.PlotProtectedList = {
		"None"
	};
	local ProtectDropdown = UI:CreateDropdown(TabAuto, "Protected Brainrots", _E.PlotProtectedList, true, {}, function(Val)
		_E.TProtectedBrainrots = Val;
		SaveConfig();
	end);
	UI:CreateButton(TabAuto, "Refresh Protected List", function()
		local myPlot = GetMyPlot();
		local newList = {};
		if (myPlot and myPlot:FindFirstChild("Slots")) then
			for _, slot in ipairs(myPlot.Slots:GetChildren()) do
				local placedPart = slot:FindFirstChild("PlacedPart");
				local slotNum = string.match(slot.Name, "%d+");
				if (placedPart and placedPart:GetAttribute("ID")) then
					local pName = placedPart:GetAttribute("ID");
					local pMut = placedPart:GetAttribute("Mutation") or "None" ;
					local entryName = string.format("[Slot %s] %s [%s]", tostring(slotNum), pName, pMut);
					table.insert(newList, entryName);
				end
			end
		end
		if ( # newList == 0) then
			table.insert(newList, "None");
		end
		_E.PlotProtectedList = newList;
		pcall(function()
			if (ProtectDropdown and ProtectDropdown.Refresh) then
				ProtectDropdown:Refresh(_E.PlotProtectedList);
			end
		end);
		UI:Notify(Win, "Shield Updated", "Found " .. tostring( # newList) .. " pets on plot. Dropdown refreshed!", 3);
	end);
	UI:CreateToggle(TabAuto, "Enable Protection", _E.AProtectFilter, function(Val)
		_E.AProtectFilter = Val;
		SaveConfig();
	end);
	UI:CreateToggle(TabAuto, "Auto Place Best", _E.APlaceBest, function(Val)
		_E.APlaceBest = Val;
		SaveConfig();
	end);
	UI:CreateSection(TabAuto, "UPGRADE BRAINROT");
	local UpgradeDropdown = UI:CreateDropdown(TabAuto, "Target Upgrade Brainrot", _E.PlotBrainrotList, true, _E.TUpgrade, function(Val)
		_E.TUpgrade = Val;
		SaveConfig();
	end);
	UI:CreateButton(TabAuto, "Refresh Brainrot List", function()
		local myPlot = GetMyPlot();
		local newList = {
			"Any"
		};
		local foundPets = {};
		if (myPlot and myPlot:FindFirstChild("Slots")) then
			for _, slot in ipairs(myPlot.Slots:GetChildren()) do
				local placedPart = slot:FindFirstChild("PlacedPart");
				if placedPart then
					for _, pet in ipairs(placedPart:GetChildren()) do
						if (pet:IsA("Model") and not pet.Name:match("Hitbox")) then
							local mut = GetMutation(pet);
							local displayName = string.format("%s [%s]", pet.Name, mut);
							if not foundPets[displayName] then
								foundPets[displayName] = true;
								table.insert(newList, displayName);
							end
						end
					end
				end
			end
		else
			UI:Notify(Win, "Refresh Failed", "Plot not found! Make sure you are on your plot.", 3);
			return;
		end
		_E.PlotBrainrotList = newList;
		pcall(function()
			if (UpgradeDropdown and UpgradeDropdown.Refresh) then
				UpgradeDropdown:Refresh(_E.PlotBrainrotList);
			end
		end);
		if ( # newList > 1) then
			UI:Notify(Win, "Brainrot Updated", "Found " .. tostring( # newList - 1) .. " Brainrots! Dropdown opened to refresh.", 3);
		else
			UI:Notify(Win, "Brainrot Empty", "No Brainrots found on your plot slots.", 3);
		end
	end);
	UI:CreateSlider(TabAuto, "Upgrade Times", 1, 100, _E.MaxUpLevel, function(Val)
		_E.MaxUpLevel = Val;
	end);
	UI:CreateButton(TabAuto, "Start Auto Upgrade", function()
		if not BUpgradeEvt then
			return;
		end
		local myPlot = GetMyPlot();
		if not myPlot then
			return;
		end
		local targetSlots = {};
		if myPlot:FindFirstChild("Slots") then
			for _, slot in ipairs(myPlot.Slots:GetChildren()) do
				local placedPart = slot:FindFirstChild("PlacedPart");
				if placedPart then
					local petModel;
					for _, p in ipairs(placedPart:GetChildren()) do
						if (p:IsA("Model") and not p.Name:match("Hitbox")) then
							petModel = p;
							break;
						end
					end
					if petModel then
						local currentMut = GetMutation(petModel);
						local displayName = string.format("%s [%s]", petModel.Name, currentMut);
						local isMatchBool = false;
						if (type(_E.TUpgrade) == "table") then
							if (table.find(_E.TUpgrade, "Any") or ( # _E.TUpgrade == 0)) then
								isMatchBool = true;
							elseif table.find(_E.TUpgrade, displayName) then
								isMatchBool = true;
							end
						elseif (type(_E.TUpgrade) == "string") then
							if ((_E.TUpgrade == "Any") or (_E.TUpgrade == displayName)) then
								isMatchBool = true;
							end
						end
						if isMatchBool then
							local slotNum = tonumber(string.match(slot.Name, "%d+"));
							if slotNum then
								table.insert(targetSlots, slotNum);
							end
						end
					end
				end
			end
		end
		if ( # targetSlots > 0) then
			task.spawn(function()
				for i = 1, _E.MaxUpLevel do
					if not _E.HubRunning then
						break;
					end
					for _, sNum in ipairs(targetSlots) do
						pcall(function()
							BUpgradeEvt:FireServer(sNum);
						end);
						task.wait(0.1);
					end
					task.wait(0.2);
				end
			end);
		end
	end);
	UI:CreateSection(TabAuto, "VOLCANO SYSTEM");
	UI:CreateToggle(TabAuto, "Auto Collect Shards (Orbs)", _E.AVolcanoCollect, function(Val)
		_E.AVolcanoCollect = Val;
		if not Val then
			_E.CollectedShards = {};
		end
		SaveConfig();
	end);
	local FriendlyUpgradeOptions = {
		"Any",
		"More Ores",
		"Ore Size",
		"Golden Ores",
		"Diamond Ores",
		"Rainbow Ores",
		"Golden Chance",
		"Diamond Chance",
		"Rainbow Chance",
		"Volcanic Mutation",
		"Mutation Chance"
	};
	UI:CreateDropdown(TabAuto, "Target Volcano Upgrade", FriendlyUpgradeOptions, false, _E.TVolcanoUpgrade, function(Val)
		_E.TVolcanoUpgrade = Val;
		SaveConfig();
	end);
	UI:CreateToggle(TabAuto, "Auto Upgrade Volcano", _E.AVolcanoUpgrade, function(Val)
		_E.AVolcanoUpgrade = Val;
		SaveConfig();
	end);
	local FriendlyShopOptions = {
		"Any",
		"Farm Potion",
		"Weight Potion",
		"Cash Potion",
		"Luck Potion",
		"LuckyBlock x1",
		"LuckyBlock x3",
		"LuckyBlock x8",
		"Rocky",
		"Volcanic Kick"
	};
	UI:CreateDropdown(TabAuto, "Target Volcano Shop", FriendlyShopOptions, false, _E.TVolcanoBuy, function(Val)
		_E.TVolcanoBuy = Val;
		SaveConfig();
	end);
	UI:CreateToggle(TabAuto, "Auto Buy Volcanic Shop", _E.AVolcanoBuy, function(Val)
		_E.AVolcanoBuy = Val;
		SaveConfig();
	end);
	TabShop:CreateSection("SHOP SPEED");
	TabShop:CreateToggle("Auto Buy Speed", "", _E.ABuySpeed, function(Val)
		_E.ABuySpeed = Val;
		SaveConfig();
	end);
	TabShop:CreateSection("SHOP WEIGHT");
	_E.WeightList = {
		"None"
	};
	if weightsFolder then
		for _, w in ipairs(weightsFolder:GetChildren()) do
			table.insert(_E.WeightList, w.Name);
		end
	end
	TabShop:CreateSelect("Target Weight", "", _E.WeightList, _E.TTargetWeight, function(Val)
		_E.TTargetWeight = Val;
	end);
	TabShop:CreateToggle("Auto Buy Selected Weight", "", _E.ABuyWeights, function(Val)
		_E.ABuyWeights = Val;
		SaveConfig();
	end);
	TabShop:CreateToggle("Auto Buy Best Weight", "", _E.ABuyBest, function(Val)
		_E.ABuyBest = Val;
		SaveConfig();
	end);
	TabShop:CreateSection("SELL & FAVORITE");
	TabShop:CreateSelect("Favorite Brainrot", "Auto-fav and protect these from Sell All", DB.BrainrotOptions, _E.TSSellBrainrot, function(Val)
		_E.TSSellBrainrot = Val;
		SaveConfig();
		if _E.TriggerFavScan then
			task.spawn(_E.TriggerFavScan);
		end
	end);
	TabShop:CreateSelect("Favorite Rarity", "", DB.RarityOptions, _E.TSSellRarity, function(Val)
		_E.TSSellRarity = Val;
		SaveConfig();
		if _E.TriggerFavScan then
			task.spawn(_E.TriggerFavScan);
		end
	end);
	TabShop:CreateSelect("Favorite Mutation", "", DB.MutationOptions, _E.TSSellMutation, function(Val)
		_E.TSSellMutation = Val;
		SaveConfig();
		if _E.TriggerFavScan then
			task.spawn(_E.TriggerFavScan);
		end
	end);
	TabShop:CreateToggle("Auto Favorite Filter", "Automatically favorites pets matching filters above.", _E.AAutoFav, function(Val)
		_E.AAutoFav = Val;
		SaveConfig();
		if (Val and _E.TriggerFavScan) then
			_E.TriggerFavScan();
		end
	end);
	TabShop:CreateButton("Sell All Brainrots", "Instantly sells all NON-favorited brainrots.", nil, function()
		if SellAllEvt then
			pcall(function()
				SellAllEvt:InvokeServer();
			end);
			UI:Notify(Win, "Sell All", "Executed! Favorited pets are safe.", 3);
		else
			UI:Notify(Win, "Error", "Sell All remote not found!", 3);
		end
	end);
	TabMisc:CreateSection("SERVER INSTANCE JOINER");
	getgenv().TargetServerInput = "";
	TabMisc:CreateInput("Join Server Link / JobId", "Paste server link or JobId from Discord", "", nil, nil, function(Val)
		getgenv().TargetServerInput = Val;
	end);
	UI:CreateButton(TabMisc, "Join Server Instance", function()
		local rawInput = getgenv().TargetServerInput;
		if ( not rawInput or (rawInput == "")) then
			UI:Notify(Win, "Error", "Input is empty! Try pressing Enter first after pasting.", 3);
			return;
		end
		local targetPlaceId = nil;
		local targetJobId = nil;
		if rawInput:find("LUXY:<") then
			local encoded = rawInput:match("LUXY:<([^>]+)>");
			if encoded then
				local success, decoded = pcall(DecodeBase64, encoded);
				if (success and decoded and (decoded ~= "")) then
					targetJobId = decoded;
				end
			end
		elseif (rawInput:find("roblox.com") or rawInput:find("placeId=")) then
			local pId = rawInput:match("placeId=(%d+)");
			if pId then
				targetPlaceId = tonumber(pId);
			end
			local iId = rawInput:match("instanceId=([^&%s]+)");
			if iId then
				targetJobId = iId;
			end
		end
		if not targetJobId then
			targetJobId = rawInput:match("(%x%x%x%x%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%x%x%x%x%x%x%x%x)") or rawInput:match("([%w]+%-[%w]+%-[%w]+%-[%w]+%-[%w]+)") or string.gsub(rawInput, "^%s*(.-)%s*$", "%1") ;
		end
		if not targetPlaceId then
			targetPlaceId = game.PlaceId;
		end
		if (targetJobId and (targetJobId ~= "")) then
			UI:Notify(Win, "Hopping", "Teleporting to Place: " .. tostring(targetPlaceId) .. " | Instance: " .. targetJobId, 3);
			game:GetService("TeleportService"):TeleportToPlaceInstance(targetPlaceId, targetJobId, LP);
		else
			UI:Notify(Win, "Error", "Failed to extract JobId from link!", 3);
		end
	end);
	TabMisc:CreateSection("DISCORD INTEGRATION");
	TabMisc:CreateSelect("Webhook Brainrot", "", DB.BrainrotOptions, _E.WBBrainrot, function(Val)
		_E.WBBrainrot = Val;
		SaveConfig();
	end);
	TabMisc:CreateSelect("Webhook Rarity", "", DB.RarityOptions, _E.WBRarity, function(Val)
		_E.WBRarity = Val;
		SaveConfig();
	end);
	TabMisc:CreateSelect("Webhook Mutation", "", DB.MutationOptions, _E.WBMutation, function(Val)
		_E.WBMutation = Val;
		SaveConfig();
	end);
	local TestIconID = "rbxassetid://10734943902";
	TabMisc:CreateInput("Webhook URL", "", "https://discord.com/api/webhooks/...", TestIconID, function(Val)
		if (Val and (Val ~= "")) then
			local HTTPRequest = (syn and syn.request) or (http and http.request) or http_request or request or fluxus.request ;
			if HTTPRequest then
				local embed = {
					title = "✅ Webhook Connection Successful",
					description = "Luxy Hub is now successfully connected to this channel.\nYou will receive notifications based on your filters.",
					color = tonumber("0x00FF00"),
					footer = {
						text = "Luxy Hub v3.5 | Security Check"
					},
					timestamp = DateTime.now():ToIsoDate()
				};
				pcall(function()
					HTTPRequest({
						Url = Val,
						Method = "POST",
						Headers = {
							["Content-Type"] = "application/json"
						},
						Body = game:GetService("HttpService"):JSONEncode({
							username = "Luxy Hub",
							avatar_url = "https://i.imgur.com/K1W0nB4.png",
							embeds = {
								embed
							}
						})
					});
				end);
				UI:Notify(Win, "Webhook Test", "Test embed sent to your Discord!", 3);
			end
		end
	end, function(Val)
		_E.WebhookURL = Val;
		SaveConfig();
	end);
	TabMisc:CreateToggle("Enable Webhook", "", _E.AWebhook, function(Val)
		_E.AWebhook = Val;
		SaveConfig();
	end);
	task.spawn(function()
		while _E.HubRunning do
			task.wait(0.2);
			pcall(function()
				local coreGui = game:GetService("CoreGui");
				local playerGui = game:GetService("Players").LocalPlayer:FindFirstChildOfClass("PlayerGui");
				local guis = {
					coreGui,
					playerGui
				};
				for _, parent in ipairs(guis) do
					if parent then
						for _, gui in ipairs(parent:GetChildren()) do
							if (gui:IsA("ScreenGui") and (gui.Name:find("Luxy") or (gui.Name == "ScreenGui"))) then
								for _, label in ipairs(gui:GetDescendants()) do
									if (label:IsA("TextLabel") and ((label.Name == "Value") or (label.Name == "Selected"))) then
										if ((label.Text == "None") or (label.Text == "Any")) then
											label.Text = "--";
										end
									end
								end
							end
						end
					end
				end
			end);
		end
	end);
	task.spawn(function()
		while _E.HubRunning do
			task.wait(0.1);
			if _E.AFarm then
				local chr = LP.Character;
				if not chr then
					continue;
				end
				local hrp = chr:FindFirstChild("HumanoidRootPart");
				local hum = chr:FindFirstChild("Humanoid");
				local cam = WS.CurrentCamera;
				if ( not hrp or not hum or (hum.Health <= 0)) then
					continue;
				end
				local krz = WS:FindFirstChild("Areas") and WS.Areas:FindFirstChild("KickReady") ;
				if ( not krz or (cam.CameraSubject ~= hum)) then
					continue;
				end
				local wvs = WS:FindFirstChild("Waves");
				local wOn = wvs and ( # wvs:GetChildren() > 0) ;
				local pGui = LP:FindFirstChild("PlayerGui");
				local hud = pGui and pGui:FindFirstChild("HUD") ;
				local kickBtn = hud and hud:FindFirstChild("KickButton") ;
				if wOn then
					local attr = LP:GetAttribute("InGame") or "" ;
					if (attr ~= "") then
						local sData = string.split(attr, ",");
						local cBrainrot = (sData[1] and string.gsub(sData[1], "^%s*(.-)%s*$", "%1")) or "Unknown" ;
						local cMutation = (sData[2] and string.gsub(sData[2], "^%s*(.-)%s*$", "%1")) or "None" ;
						local cRarity = "Unknown";
						pcall(function()
							if (EntitiesDataCache and EntitiesDataCache.Brainrots and EntitiesDataCache.Brainrots[cBrainrot]) then
								cRarity = EntitiesDataCache.Brainrots[cBrainrot].Rarity;
							end
						end);
						local isTrash = not ShouldKeepPet(cBrainrot, cMutation);
						if isTrash then
							cam.CameraType = Enum.CameraType.Scriptable;
							cam.CFrame = krz.CFrame * CFrame.new(0, 15, - 25) ;
							cam.CFrame = CFrame.lookAt(cam.CFrame.Position, krz.Position);
							hum.Health = 0;
							local newChar = LP.CharacterAdded:Wait();
							local newHrp = newChar:WaitForChild("HumanoidRootPart", 5);
							local newHum = newChar:WaitForChild("Humanoid", 5);
							if (newHrp and newHum) then
								newHrp.CFrame = krz.CFrame * CFrame.new(0, 3, 0) ;
								task.wait(0.2);
								cam.CameraType = Enum.CameraType.Custom;
								cam.CameraSubject = newHum;
							end
						else
							hum.WalkSpeed = 100;
							hum.MaxSlopeAngle = 89;
							local diff = Vector3.new(hrp.Position.X, 0, hrp.Position.Z) - Vector3.new(krz.Position.X, 0, krz.Position.Z) ;
							hum:MoveTo(((diff.Magnitude > 5) and krz.Position) or hrp.Position);
						end
					else
						hum.WalkSpeed = 100;
						hum.MaxSlopeAngle = 89;
						local diff = Vector3.new(hrp.Position.X, 0, hrp.Position.Z) - Vector3.new(krz.Position.X, 0, krz.Position.Z) ;
						hum:MoveTo(((diff.Magnitude > 5) and krz.Position) or hrp.Position);
					end
				else
					hum.MaxSlopeAngle = 45;
					local diff = Vector3.new(hrp.Position.X, 0, hrp.Position.Z) - Vector3.new(krz.Position.X, 0, krz.Position.Z) ;
					if (diff.Magnitude > 15) then
						hrp.CFrame = krz.CFrame * CFrame.new(0, 3, 0) ;
						task.wait(0.5);
					elseif (kickBtn and kickBtn.Visible and KkEvt) then
						pcall(function()
							local targetPower = (_E.CustomKickPowerPercent or 100) / 100 ;
							KkEvt:FireServer(0.999099329113793, targetPower);
						end);
						task.wait(0.5);
					end
				end
			end
		end
	end);
	task.spawn(function()
		local isPlacing = false;
		while _E.HubRunning do
			task.wait(0.5);
			if (_E.APlaceBest and SInteractEvt and not isPlacing) then
				local char = LP.Character;
				local hum = char and char:FindFirstChild("Humanoid") ;
				local myPlot = GetMyPlot();
				if (myPlot and char and hum and (hum.Health > 0)) then
					local worstSlotNum = nil;
					local worstTierScore = math.huge;
					local emptySlots = {};
					if myPlot:FindFirstChild("Slots") then
						for _, slot in ipairs(myPlot.Slots:GetChildren()) do
							local placedPart = slot:FindFirstChild("PlacedPart");
							local slotNum = tonumber(string.match(slot.Name, "%d+"));
							if (placedPart and placedPart:GetAttribute("ID")) then
								local pName = placedPart:GetAttribute("ID");
								local pMut = placedPart:GetAttribute("Mutation") or "None" ;
								local isProtected = false;
								if (_E.AProtectFilter and (type(_E.TProtectedBrainrots) == "table")) then
									local checkStr = string.format("[Slot %s] %s [%s]", tostring(slotNum), pName, pMut);
									if table.find(_E.TProtectedBrainrots, checkStr) then
										isProtected = true;
									end
								end
								if not isProtected then
									local tierScore = GetActualCPS(pName, pMut, 1);
									if (tierScore < worstTierScore) then
										worstTierScore = tierScore;
										worstSlotNum = slotNum;
									end
								end
							elseif slotNum then
								table.insert(emptySlots, slotNum);
							end
						end
					end
					local bestPetTool = nil;
					local bestInvTierScore = - 1;
					local itemsToScan = {};
					if LP.Backpack then
						for _, t in ipairs(LP.Backpack:GetChildren()) do
							table.insert(itemsToScan, t);
						end
					end
					for _, t in ipairs(char:GetChildren()) do
						if t:IsA("Tool") then
							table.insert(itemsToScan, t);
						end
					end
					for _, tool in ipairs(itemsToScan) do
						if (tool:IsA("Tool") and tool:GetAttribute("GUID")) then
							local pMut = tool:GetAttribute("Mutation") or "None" ;
							local tierScore = GetActualCPS(tool.Name, pMut, 1);
							if (tierScore and (tierScore > bestInvTierScore)) then
								bestInvTierScore = tierScore;
								bestPetTool = tool;
							end
						end
					end
					if bestPetTool then
						local targetSlot = nil;
						if ( # emptySlots > 0) then
							targetSlot = emptySlots[1];
						elseif (worstSlotNum and (bestInvTierScore > worstTierScore)) then
							targetSlot = worstSlotNum;
						end
						if targetSlot then
							isPlacing = true;
							_E.IsPlacingPet = true;
							if (bestPetTool.Parent ~= char) then
								pcall(function()
									bestPetTool.Parent = char;
								end);
							end
							local timeout = 0;
							while (bestPetTool.Parent ~= char) and (timeout < 1) do
								task.wait(0.05);
								timeout = timeout + 0.05 ;
							end
							if (bestPetTool.Parent == char) then
								pcall(function()
									SInteractEvt:FireServer(targetSlot);
								end);
							end
							task.wait(0.8);
							_E.IsPlacingPet = false;
							isPlacing = false;
						end
					end
				end
			end
		end
	end);
	task.spawn(function()
		while _E.HubRunning do
			task.wait(0.5);
			if ((_E.ATrain or _E.ATrainCollect) and not _E.IsPlacingPet and not _E.IsFlashCollecting) then
				local char = LP.Character;
				local hum = char and char:FindFirstChild("Humanoid") ;
				if (hum and weightsFolder) then
					local bestOwnedWeight = nil;
					local highestIndex = - 1;
					local ownedTools = {};
					for _, item in ipairs(LP.Backpack:GetChildren()) do
						if item:IsA("Tool") then
							table.insert(ownedTools, item);
						end
					end
					if char then
						local eq = char:FindFirstChildOfClass("Tool");
						if eq then
							table.insert(ownedTools, eq);
						end
					end
					local sortedWeights = GetSortedWeights();
					for _, tool in ipairs(ownedTools) do
						for i, w in ipairs(sortedWeights) do
							if ((w.name == tool.Name) and (i > highestIndex)) then
								highestIndex = i;
								bestOwnedWeight = tool;
							end
						end
					end
					if bestOwnedWeight then
						local currentEquipped = char:FindFirstChildOfClass("Tool");
						if ( not currentEquipped or (currentEquipped.Name ~= bestOwnedWeight.Name)) then
							if WeightEquipEvt then
								pcall(function()
									WeightEquipEvt:FireServer(bestOwnedWeight.Name);
								end);
							end
							if (bestOwnedWeight.Parent == LP.Backpack) then
								hum:EquipTool(bestOwnedWeight);
							end
						end
					end
				end
			end
		end
	end);
	task.spawn(function()
		local speedCooldown = false;
		while _E.HubRunning do
			task.wait(0.5);
			if (_E.ABuySpeed and SpeedUpEvt) then
				if not speedCooldown then
					local preMoney = ParseWallet(tostring((LP.leaderstats and LP.leaderstats:FindFirstChild("Coins") and LP.leaderstats.Coins.Value) or "0"));
					pcall(function()
						SpeedUpEvt:FireServer(1);
					end);
					task.wait(0.8);
					local postMoney = ParseWallet(tostring((LP.leaderstats and LP.leaderstats:FindFirstChild("Coins") and LP.leaderstats.Coins.Value) or "0"));
					if (postMoney >= preMoney) then
						speedCooldown = true;
						task.delay(10, function()
							speedCooldown = false;
						end);
					end
				end
			else
				task.wait(1);
			end
		end
	end);
	task.spawn(function()
		local weightCooldown = false;
		local lastFailedWeightMoney = 0;
		while _E.HubRunning do
			task.wait(0.5);
			local currentMoney = ParseWallet(tostring((LP.leaderstats and LP.leaderstats:FindFirstChild("Coins") and LP.leaderstats.Coins.Value) or "0"));
			local targetWeightName = nil;
			if (_E.ABuyBest and weightsFolder) then
				local char = LP.Character;
				local currentWeightName = nil;
				local itemsToCheck = {};
				for _, v in ipairs(LP.Backpack:GetChildren()) do
					table.insert(itemsToCheck, v);
				end
				if char then
					local eq = char:FindFirstChildOfClass("Tool");
					if eq then
						table.insert(itemsToCheck, eq);
					end
				end
				for _, tool in ipairs(itemsToCheck) do
					if (tool:IsA("Tool") and weightsFolder:FindFirstChild(tool.Name)) then
						currentWeightName = tool.Name;
					end
				end
				if currentWeightName then
					local sortedWeights = GetSortedWeights();
					local currentIndex = 0;
					for i, w in ipairs(sortedWeights) do
						if (w.name == currentWeightName) then
							currentIndex = i;
							break;
						end
					end
					if ((currentIndex > 0) and (currentIndex < # sortedWeights)) then
						targetWeightName = sortedWeights[currentIndex + 1 ].name;
					elseif ((currentIndex == 0) and ( # sortedWeights > 0)) then
						targetWeightName = sortedWeights[1].name;
					end
				end
			elseif (_E.ABuyWeights and (_E.TTargetWeight ~= "None")) then
				targetWeightName = _E.TTargetWeight;
			end
			if (targetWeightName and ShopBuyEvt) then
				local price = GetWeightPrice(targetWeightName);
				if (currentMoney > lastFailedWeightMoney) then
					weightCooldown = false;
				end
				if ((currentMoney >= price) and not weightCooldown) then
					local preMoney = currentMoney;
					pcall(function()
						ShopBuyEvt:FireServer("WeightShop", targetWeightName);
					end);
					task.wait(1.5);
					local postMoney = ParseWallet(tostring((LP.leaderstats and LP.leaderstats:FindFirstChild("Coins") and LP.leaderstats.Coins.Value) or "0"));
					if (postMoney >= preMoney) then
						weightCooldown = true;
						lastFailedWeightMoney = postMoney;
					end
				end
			end
		end
	end);
	task.spawn(function()
		local plotCooldown = false;
		local lastFailedPlotMoney = 0;
		while _E.HubRunning do
			task.wait(1);
			local currentMoney = ParseWallet(tostring((LP.leaderstats and LP.leaderstats:FindFirstChild("Coins") and LP.leaderstats.Coins.Value) or "0"));
			if (_E.APlotUpgrade and PlotUpgradeEvt) then
				if (currentMoney > lastFailedPlotMoney) then
					plotCooldown = false;
				end
				if not plotCooldown then
					local preMoney = currentMoney;
					pcall(function()
						PlotUpgradeEvt:FireServer();
					end);
					task.wait(1);
					local postMoney = ParseWallet(tostring((LP.leaderstats and LP.leaderstats:FindFirstChild("Coins") and LP.leaderstats.Coins.Value) or "0"));
					if (postMoney >= preMoney) then
						plotCooldown = true;
						lastFailedPlotMoney = postMoney;
					end
				end
			end
		end
	end);
	task.spawn(function()
		while _E.HubRunning do
			task.wait(1);
			if (_E.ARebirth and RebirthEvt) then
				local cost = GetRebirthCost(MyRebirthLevel);
				if (MyMoney >= cost) then
					pcall(function()
						RebirthEvt:FireServer();
					end);
					task.wait(5);
				else
					task.wait(5);
				end
			end
		end
	end);
	task.spawn(function()
		while _E.HubRunning do
			task.wait(0.2);
			if ((_E.A2xTrain or _E.ATrainCollect) and not _E.IsFlashCollecting) then
				local pGui = LP:FindFirstChild("PlayerGui");
				local kUpgrades = pGui and pGui:FindFirstChild("KickUpgrades") ;
				if kUpgrades then
					for _, ui in ipairs(kUpgrades:GetChildren()) do
						if (ui.Name == "Bonus") then
							pcall(function()
								for _, click in pairs(getconnections(ui.MouseButton1Click)) do
									click:Fire();
								end
								for _, click in pairs(getconnections(ui.Activated)) do
									click:Fire();
								end
							end);
						end
					end
				end
			end
		end
	end);
	task.spawn(function()
		local lastCollectTime = 0;
		while _E.HubRunning do
			task.wait(0.5);
			local myPlot = GetMyPlot();
			if not myPlot then
				continue;
			end
			if (_E.ACollect and BCollectEvt) then
				if ((tick() - lastCollectTime) >= _E.CollectDelay) then
					lastCollectTime = tick();
					local char = LP.Character;
					local hrp = char and char:FindFirstChild("HumanoidRootPart") ;
					if (hrp and myPlot:FindFirstChild("Slots") and myPlot:FindFirstChild("Buttons")) then
						local originalCFrame = hrp.CFrame;
						for _, slot in ipairs(myPlot.Slots:GetChildren()) do
							local placedPart = slot:FindFirstChild("PlacedPart");
							if (placedPart and placedPart:FindFirstChildOfClass("Model")) then
								local slotNum = tonumber(string.match(slot.Name, "%d+"));
								if slotNum then
									local targetButton = myPlot.Buttons:FindFirstChild(slot.Name);
									if (targetButton and targetButton:IsA("BasePart")) then
										hrp.CFrame = targetButton.CFrame * CFrame.new(0, 3, 0) ;
										task.wait(0.15);
										pcall(function()
											BCollectEvt:FireServer(slotNum);
										end);
										task.wait(0.1);
									end
								end
							end
						end
						hrp.CFrame = originalCFrame;
					end
				end
			end
		end
	end);
	task.spawn(function()
		while _E.HubRunning do
			task.wait(0.5);
			if (_E.ATrainCollect and (tick() >= _E.NextFlashCollect)) then
				local char = LP.Character;
				local hum = char and char:FindFirstChild("Humanoid") ;
				local hrp = char and char:FindFirstChild("HumanoidRootPart") ;
				local myPlot = GetMyPlot();
				if (char and hum and hrp and myPlot and BCollectEvt) then
					_E.IsFlashCollecting = true;
					local targetAnchor = _E.TrainAnchorCFrame or hrp.CFrame ;
					local equippedTool = char:FindFirstChildOfClass("Tool");
					local toolName = (equippedTool and equippedTool.Name) or nil ;
					hum:UnequipTools();
					task.wait(0.2);
					if (myPlot:FindFirstChild("Slots") and myPlot:FindFirstChild("Buttons")) then
						for _, slot in ipairs(myPlot.Slots:GetChildren()) do
							local placedPart = slot:FindFirstChild("PlacedPart");
							if (placedPart and placedPart:FindFirstChildOfClass("Model")) then
								local slotNum = tonumber(string.match(slot.Name, "%d+"));
								local targetButton = myPlot.Buttons:FindFirstChild(slot.Name);
								if (slotNum and targetButton) then
									hrp.CFrame = targetButton.CFrame * CFrame.new(0, 3, 0) ;
									task.wait(0.15);
									pcall(function()
										BCollectEvt:FireServer(slotNum);
									end);
								end
							end
						end
					end
					hrp.CFrame = targetAnchor;
					task.wait(0.2);
					if (toolName and LP.Backpack:FindFirstChild(toolName)) then
						hum:EquipTool(LP.Backpack[toolName]);
					end
					_E.NextFlashCollect = tick() + (_E.TrainCollectDelay * 60) ;
					_E.IsFlashCollecting = false;
				end
			end
		end
	end);
	task.spawn(function()
		local hookedTools = {};
		local favDebounce = {};
		local function isFavMatch(targetList, currentVal)
			if (type(targetList) == "string") then
				targetList = {
					targetList
				};
			end
			if ( not targetList or ( # targetList == 0) or table.find(targetList, "Any")) then
				return true;
			end
			if (table.find(targetList, "None") and (currentVal ~= "None")) then
				return true;
			end
			return table.find(targetList, currentVal) ~= nil ;
		end
		local function ProcessTool(tool, isManualScan)
			if not tool:IsA("Tool") then
				return;
			end
			if hookedTools[tool] then
				if isManualScan then
					local guid = tool:GetAttribute("GUID");
					if guid then
						CheckAndFavLogic(tool, guid);
					end
				end
				return;
			end
			if not tool:GetAttribute("GUID") then
				local conn;
				conn = tool:GetAttributeChangedSignal("GUID"):Connect(function()
					if tool:GetAttribute("GUID") then
						if conn then
							conn:Disconnect();
						end
						ProcessTool(tool, isManualScan);
					end
				end);
				task.delay(5, function()
					if conn then
						conn:Disconnect();
					end
				end);
				return;
			end
			local startTime = tick();
			while tool.Parent and ((tick() - startTime) < 2) do
				if (tool:GetAttribute("Mutation") ~= nil) then
					break;
				end
				task.wait(0.1);
			end
			if not tool.Parent then
				return;
			end
			hookedTools[tool] = true;
			tool.AncestryChanged:Connect(function()
				if not tool.Parent then
					hookedTools[tool] = nil;
				end
			end);
			local guid = tool:GetAttribute("GUID");
			local function CheckAndFavLogic()
				if not _E.AAutoFav then
					return;
				end
				if not tool.Parent then
					return;
				end
				if (favDebounce[guid] and ((tick() - favDebounce[guid]) < 1)) then
					return;
				end
				local pName = tool.Name;
				local pRarity = tool:GetAttribute("Rarity");
				if ( not pRarity or (pRarity == "")) then
					pcall(function()
						if (EntitiesDataCache and EntitiesDataCache.Brainrots and EntitiesDataCache.Brainrots[pName]) then
							pRarity = EntitiesDataCache.Brainrots[pName].Rarity;
						end
					end);
				end
				pRarity = pRarity or "Unknown" ;
				local pMut = tool:GetAttribute("Mutation");
				if ( not pMut or (pMut == "")) then
					pMut = "None";
				end
				local keep = isFavMatch(_E.TSSellBrainrot, pName) and isFavMatch(_E.TSSellRarity, pRarity) and isFavMatch(_E.TSSellMutation, pMut) ;
				if keep then
					if (tool:GetAttribute("Favorite") ~= true) then
						favDebounce[guid] = tick();
						pcall(function()
							ToggleFavEvt:FireServer(guid);
						end);
					end
				end
			end
			CheckAndFavLogic();
			tool:GetAttributeChangedSignal("Favorite"):Connect(CheckAndFavLogic);
			tool:GetAttributeChangedSignal("Rarity"):Connect(CheckAndFavLogic);
			tool:GetAttributeChangedSignal("Mutation"):Connect(CheckAndFavLogic);
		end
		local function SafeScanInventory()
			local toolsToScan = {};
			if LP.Backpack then
				for _, tool in ipairs(LP.Backpack:GetChildren()) do
					if tool:IsA("Tool") then
						table.insert(toolsToScan, tool);
					end
				end
			end
			if LP.Character then
				for _, tool in ipairs(LP.Character:GetChildren()) do
					if tool:IsA("Tool") then
						table.insert(toolsToScan, tool);
					end
				end
			end
			for _, tool in ipairs(toolsToScan) do
				ProcessTool(tool, true);
				task.wait(0.5);
			end
		end
		_E.TriggerFavScan = function()
			task.spawn(SafeScanInventory);
		end;
		task.wait(15);
		SafeScanInventory();
		LP.Backpack.ChildAdded:Connect(function(tool)
			task.wait(0.5);
			ProcessTool(tool, false);
		end);
		LP.CharacterAdded:Connect(function(char)
			char.ChildAdded:Connect(function(child)
				if child:IsA("Tool") then
					task.wait(0.5);
					ProcessTool(child, false);
				end
			end);
		end);
		task.spawn(function()
			while _E.HubRunning do
				task.wait(30);
				if _E.AAutoFav then
					SafeScanInventory();
				end
			end
		end);
	end);
	task.spawn(function()
		local HTTPRequest = (syn and syn.request) or (http and http.request) or http_request or request or fluxus.request ;
		local lastNotifiedKey = "";
		local lastNotifiedTime = 0;
		local RarityColors = {
			Common = 7506394,
			Uncommon = 32768,
			Rare = 4886754,
			Epic = 10181046,
			Legendary = 16312092,
			Mythical = 16508821,
			Secret = 16508821,
			Divine = 16711935,
			Hacked = 3066993,
			OG = 9109500,
			Celestial = 16763904,
			Ethernal = 8092526
		};
		LP:GetAttributeChangedSignal("InGame"):Connect(function()
			if ( not _E.AWebhook or (_E.WebhookURL == "") or not HTTPRequest) then
				return;
			end
			local attr = LP:GetAttribute("InGame") or "" ;
			if (attr == "") then
				lastNotifiedKey = "";
				return;
			end
			local sData = string.split(attr, ",");
			local cBrainrot = (sData[1] and string.gsub(sData[1], "^%s*(.-)%s*$", "%1")) or "Unknown" ;
			local cMutation = (sData[2] and string.gsub(sData[2], "^%s*(.-)%s*$", "%1")) or "None" ;
			local cRarity = "Unknown";
			pcall(function()
				if (EntitiesDataCache and EntitiesDataCache.Brainrots and EntitiesDataCache.Brainrots[cBrainrot]) then
					cRarity = EntitiesDataCache.Brainrots[cBrainrot].Rarity;
				end
			end);
			local currentKey = cBrainrot .. "_" .. cMutation ;
			if ((currentKey == lastNotifiedKey) and ((tick() - lastNotifiedTime) < 15)) then
				return;
			end
			local keep = isStrictMatch(_E.WBBrainrot, cBrainrot, false) and isStrictMatch(_E.WBRarity, cRarity, false) and isStrictMatch(_E.WBMutation, cMutation, true) ;
			if keep then
				lastNotifiedKey = currentKey;
				lastNotifiedTime = tick();
				local chanceText = "Secret / Unknown";
				pcall(function()
					if (EntitiesDataCache and EntitiesDataCache.Brainrots and EntitiesDataCache.Brainrots[cBrainrot]) then
						local rawWeight = EntitiesDataCache.Brainrots[cBrainrot].Weight or EntitiesDataCache.Brainrots[cBrainrot].Chance ;
						if rawWeight then
							chanceText = tostring(rawWeight) .. " Weight" ;
						end
					end
				end);
				local embedColor = RarityColors[cRarity] or 7506394 ;
				local embed = {
					title = "🔮 PREDICTED RARE BRAINROT!",
					description = "A filtered brainrot has been detected on the server before it even dropped!",
					color = embedColor,
					fields = {
						{
							name = "🧠 Brainrot",
							value = "```" .. cBrainrot .. "```",
							inline = true
						},
						{
							name = "✨ Rarity",
							value = "```" .. cRarity .. "```",
							inline = true
						},
						{
							name = "🧬 Mutation",
							value = "```" .. cMutation .. "```",
							inline = true
						},
						{
							name = "🎲 Drop Chance",
							value = "```" .. chanceText .. "```",
							inline = true
						},
						{
							name = "🌐 Server JobId",
							value = "```" .. tostring(game.JobId) .. "```",
							inline = false
						}
					},
					footer = {
						text = "Luxy Hub v3.5 | Notifier"
					},
					timestamp = DateTime.now():ToIsoDate()
				};
				local data = {
					username = "Luxy Hub Notifier",
					content = "@everyone",
					embeds = {
						embed
					}
				};
				task.spawn(function()
					pcall(function()
						HTTPRequest({
							Url = _E.WebhookURL,
							Method = "POST",
							Headers = {
								["Content-Type"] = "application/json"
							},
							Body = game:GetService("HttpService"):JSONEncode(data)
						});
					end);
				end);
			end
		end);
	end);
	local function FormatNumber(num)
		if ( not num or (num == 0)) then
			return "0";
		end
		if (num < 1000) then
			return tostring(num);
		end
		local suffixes = {
			"K",
			"M",
			"B",
			"T",
			"Q",
			"Qi",
			"S",
			"Sp",
			"O",
			"N",
			"D"
		};
		local i = math.floor(math.log10(num) / 3);
		local suffix = suffixes[i] or "" ;
		local formatted = num / (10 ^ (i * 3)) ;
		return string.format("%.2f%s", formatted, suffix):gsub("%.00", "");
	end
	task.spawn(function()
		local lastNotifiedKey = "";
		local lastNotifiedTime = 0;
		LP:GetAttributeChangedSignal("InGame"):Connect(function()
			if not _E.APredict then
				pcall(function()
					LuxyLib:UpdatePredictHUD(nil);
				end);
				return;
			end
			local attr = LP:GetAttribute("InGame") or "" ;
			if (attr == "") then
				lastNotifiedKey = "";
				return;
			end
			local sData = string.split(attr, ",");
			local cBrainrot = (sData[1] and string.gsub(sData[1], "^%s*(.-)%s*$", "%1")) or "Unknown" ;
			local cMutation = (sData[2] and string.gsub(sData[2], "^%s*(.-)%s*$", "%1")) or "None" ;
			if (cMutation == "") then
				cMutation = "None";
			end
			local cRarity = "Unknown";
			pcall(function()
				if (EntitiesDataCache and EntitiesDataCache.Brainrots and EntitiesDataCache.Brainrots[cBrainrot]) then
					cRarity = EntitiesDataCache.Brainrots[cBrainrot].Rarity;
				end
			end);
			local currentKey = cBrainrot .. "_" .. cMutation ;
			if ((currentKey == lastNotifiedKey) and ((tick() - lastNotifiedTime) < 15)) then
				return;
			end
			lastNotifiedKey = currentKey;
			lastNotifiedTime = tick();
			local rawCPS = "N/A";
			pcall(function()
				if GetActualCPS then
					local calculatedVal = GetActualCPS(cBrainrot, cMutation, 1);
					if calculatedVal then
						rawCPS = FormatNumber(calculatedVal) .. "/s" ;
					end
				end
			end);
	local success, err = pcall(function()
		LuxyLib:UpdatePredictHUD(cBrainrot, cRarity, cMutation, rawCPS);
	end);
	if not success then
		warn("[Luxy Hub Error] delay reder HUD: " .. tostring(err));
	end
	
	-- Check if target reached for Auto Kick Until Target feature
	if _E.AKickUntilTarget then
		_E.KickAttempts = _E.KickAttempts + 1;
		local targetRarityMatch = (_E.TTargetRarity == "Any") or (_E.TTargetRarity == cRarity);
		local targetMutationMatch = (_E.TTargetMutation == "Any") or (_E.TTargetMutation == cMutation);
		
		if targetRarityMatch and targetMutationMatch then
			_E.AKickUntilTarget = false;
			_E.AFarm = false;
			_E.LastKickResult = {
				brainrot = cBrainrot,
				rarity = cRarity,
				mutation = cMutation,
				attempts = _E.KickAttempts
			};
			
			pcall(function()
				LuxyLib:Notify({
					Title = "🎯 TARGET REACHED!",
					Content = string.format("Got %s [%s] after %d kicks!\nRarity: %s\nMutation: %s", 
						cBrainrot, cMutation, _E.KickAttempts, cRarity, cMutation),
					Duration = 10
				});
			end);
			
			-- Send webhook if enabled
			if (_E.AWebhook and _E.WebhookURL and (_E.WebhookURL ~= "")) then
				local HTTPRequest = (syn and syn.request) or (http and http.request) or http_request or request or fluxus.request;
				if HTTPRequest then
					local embed = {
						title = "🎯 Target Reached!",
						description = string.format("Successfully obtained target after **%d kicks**!", _E.KickAttempts),
						color = 65280,
						fields = {
							{
								name = "🧠 Brainrot",
								value = "```" .. cBrainrot .. "```",
								inline = true
							},
							{
								name = "✨ Rarity",
								value = "```" .. cRarity .. "```",
								inline = true
							},
							{
								name = "🧬 Mutation",
								value = "```" .. cMutation .. "```",
								inline = true
							},
							{
								name = "🎲 Total Kicks",
								value = "```" .. tostring(_E.KickAttempts) .. "```",
								inline = true
							}
						},
						footer = {
							text = "Luxy Hub v3.5 | Target System"
						},
						timestamp = DateTime.now():ToIsoDate()
					};
					task.spawn(function()
						pcall(function()
							HTTPRequest({
								Url = _E.WebhookURL,
								Method = "POST",
								Headers = {
									["Content-Type"] = "application/json"
								},
								Body = game:GetService("HttpService"):JSONEncode({
									username = "Luxy Hub Target System",
									embeds = {embed}
								})
							});
						end);
					end);
				end
			end
		end
	end
end);
	end);
	local function GetTotalPetsCount()
		local count = 0;
		for _, t in ipairs(LP.Backpack:GetChildren()) do
			if (t:IsA("Tool") and t:GetAttribute("GUID")) then
				count = count + 1 ;
			end
		end
		local char = LP.Character;
		if char then
			for _, t in ipairs(char:GetChildren()) do
				if (t:IsA("Tool") and t:GetAttribute("GUID")) then
					count = count + 1 ;
				end
			end
		end
		return count;
	end
	local function GetActualRecipeKey(weatherName)
		if ( not SacrificeData or not SacrificeData.Recipes) then
			return nil;
		end
		local nameStr = "";
		if (type(weatherName) == "table") then
			nameStr = weatherName[1] or "" ;
		else
			nameStr = tostring(weatherName);
		end
		local lowerName = string.lower(nameStr);
		for key, _ in pairs(SacrificeData.Recipes) do
			if (string.lower(key) == lowerName) then
				return key;
			end
		end
		return nil;
	end
	local function IsWeatherActive(weatherName)
		local actualKey = GetActualRecipeKey(weatherName);
		if not actualKey then
			return false;
		end
		if (WeatherServiceClient and WeatherServiceClient.Events) then
			local endTime = WeatherServiceClient.Events[actualKey];
			if endTime then
				local serverTime = workspace:GetServerTimeNow();
				if (endTime > serverTime) then
					return true;
				end
			end
		end
		return false;
	end
	local function HasRequiredPets(weatherName)
		local actualKey = GetActualRecipeKey(weatherName);
		if ( not actualKey or not SacrificeData or not SacrificeData.Recipes or not SacrificeData.Recipes[actualKey]) then
			return false;
		end
		local recipe = SacrificeData.Recipes[actualKey];
		local ownedPets = {};
		for _, t in ipairs(LP.Backpack:GetChildren()) do
			if (t:IsA("Tool") and t:GetAttribute("GUID")) then
				table.insert(ownedPets, {
					GUID = t:GetAttribute("GUID"),
					Name = t.Name,
					Mutation = t:GetAttribute("Mutation") or "None"
				});
			end
		end
		local char = LP.Character;
		if char then
			for _, t in ipairs(char:GetChildren()) do
				if (t:IsA("Tool") and t:GetAttribute("GUID")) then
					table.insert(ownedPets, {
						GUID = t:GetAttribute("GUID"),
						Name = t.Name,
						Mutation = t:GetAttribute("Mutation") or "None"
					});
				end
			end
		end
		local usedGUIDs = {};
		local matchedAll = true;
		for _, req in ipairs(recipe) do
			local matched = false;
			local reqName = req.Name;
			local reqMutation = req.Mutation or "Any" ;
			for _, pet in ipairs(ownedPets) do
				if not usedGUIDs[pet.GUID] then
					if ((pet.Name == reqName) and ((reqMutation == "Any") or (reqMutation == pet.Mutation))) then
						usedGUIDs[pet.GUID] = true;
						matched = true;
						break;
					end
				end
			end
			if not matched then
				matchedAll = false;
				break;
			end
		end
		return matchedAll;
	end
	task.spawn(function()
		local MAX_DIST = 250;
		local function getActiveShards()
			local shards = {};
			local char = LP.Character;
			local hrp = char and char:FindFirstChild("HumanoidRootPart") ;
			local debris = workspace.Debris;
			if ( not hrp or not debris) then
				return shards;
			end
			for _, obj in ipairs(debris:GetChildren()) do
				local hitbox = obj:FindFirstChild("Hitbox");
				if hitbox then
					local dist = (hrp.Position - hitbox.Position).Magnitude;
					if (dist <= MAX_DIST) then
						table.insert(shards, obj);
					end
				end
			end
			table.sort(shards, function(a, b)
				return (hrp.Position - a.Hitbox.Position).Magnitude < (hrp.Position - b.Hitbox.Position).Magnitude ;
			end);
			return shards;
		end
		while _E.HubRunning do
			task.wait(0.1);
			if _E.AVolcanoCollect then
				pcall(function()
					local char = LP.Character;
					local hum = char and char:FindFirstChild("Humanoid") ;
					local hrp = char and char:FindFirstChild("HumanoidRootPart") ;
					if (char and hum and (hum.Health > 0) and hrp and not hrp.Anchored) then
						local activeShards = getActiveShards();
						if ( # activeShards > 0) then
							local originalCFrame = hrp.CFrame;
							local savedVelocity = hrp.AssemblyLinearVelocity;
							local savedAngular = hrp.AssemblyAngularVelocity;
							local collectedInCycle = 0;
							for _, shard in ipairs(activeShards) do
								if (collectedInCycle >= 6) then
									break;
								end
								local hitbox = shard:FindFirstChild("Hitbox");
								if hitbox then
									hrp.CFrame = hitbox.CFrame;
									if firetouchinterest then
										firetouchinterest(hrp, hitbox, 0);
										firetouchinterest(hrp, hitbox, 1);
									end
									collectedInCycle = collectedInCycle + 1 ;
								end
							end
							hrp.CFrame = originalCFrame;
							hrp.AssemblyLinearVelocity = savedVelocity;
							hrp.AssemblyAngularVelocity = savedAngular;
						end
					end
				end);
			end
		end
	end);
	local UpgradeTranslation = {
		["More Ores"] = "OreMultipliers",
		["Ore Size"] = "OreSize",
		["Golden Ores"] = "SpecialOres",
		["Diamond Ores"] = "SpecialOres",
		["Rainbow Ores"] = "SpecialOres",
		["Golden Chance"] = "SpecialOresChances",
		["Diamond Chance"] = "SpecialOresChances",
		["Rainbow Chance"] = "SpecialOresChances",
		["Volcanic Mutation"] = "VolcanicMutation",
		["Mutation Chance"] = "VolcanicMutationChance"
	};
	local ShopTranslation = {
		["Farm Potion"] = "Farming Potion",
		["Weight Potion"] = "Weight Training Potion",
		["Cash Potion"] = "Cash Potion",
		["Luck Potion"] = "Luck Potion"
	};
	local function GetCurrentVolcanoTier(category)
		local VolcanoService = require(game:GetService("ReplicatedStorage").Modules.ServicesLoader.Events.VolcanoService);
		local v1 = VolcanoService.Upgrades[category];
		if not v1 then
			return 0;
		end
		local count = 0;
		while v1[tostring(count + 1)] do
			count = count + 1 ;
		end
		return count;
	end
	task.spawn(function()
		local Network = require(game:GetService("ReplicatedStorage").Shared.Packages.Network);
		local VolcanoUpgradesData = require(game:GetService("ReplicatedStorage").Shared.Data.VolcanoUpgradesData);
		local VolcanoService = require(game:GetService("ReplicatedStorage").Modules.ServicesLoader.Events.VolcanoService);
		while _E.HubRunning do
			task.wait(1.5);
			if (_E.AVolcanoUpgrade and _E.TVolcanoUpgrade) then
				pcall(function()
					local myTokens = VolcanoService.Tokens or 0 ;
					local rawSelection = _E.TVolcanoUpgrade;
					local selectedFriendlyNames = {};
					if (type(rawSelection) == "table") then
						selectedFriendlyNames = rawSelection;
					else
						selectedFriendlyNames = {
							tostring(rawSelection)
						};
					end
					if (table.find(selectedFriendlyNames, "Any") or ( # selectedFriendlyNames == 0)) then
						selectedFriendlyNames = {
							"More Ores",
							"Ore Size",
							"Golden Ores",
							"Special Ores Chances",
							"Volcanic Mutation",
							"Mutation Chance"
						};
					end
					for _, friendlyName in ipairs(selectedFriendlyNames) do
						friendlyName = string.gsub(tostring(friendlyName), "^%s*(.-)%s*$", "%1");
						local cat = UpgradeTranslation[friendlyName] or friendlyName ;
						if VolcanoUpgradesData.Upgrades[cat] then
							local currentLevel = GetCurrentVolcanoTier(cat);
							local maxLevel = # VolcanoUpgradesData.Upgrades[cat];
							if (currentLevel < maxLevel) then
								local nextLevel = currentLevel + 1 ;
								local cost = VolcanoUpgradesData.Upgrades[cat][nextLevel].Cost;
								local gateMet = true;
								local upgradeConfig = VolcanoUpgradesData.Upgrades[cat][nextLevel];
								if upgradeConfig.Gate then
									local gateKey = upgradeConfig.Gate.Key;
									local gateLevel = upgradeConfig.Gate.Level;
									local myGateLevel = GetCurrentVolcanoTier(gateKey);
									if (myGateLevel < gateLevel) then
										gateMet = false;
									end
								end
								if ((myTokens >= cost) and gateMet) then
									pcall(function()
										Network.FireServer("volcanoUpgrade", cat, nextLevel);
									end);
									task.wait(0.5);
									break;
								end
							end
						end
					end
				end);
			end
		end
	end);
	task.spawn(function()
		local Network = require(game:GetService("ReplicatedStorage").Shared.Packages.Network);
		local VolcanicShopData = require(game:GetService("ReplicatedStorage").Shared.Data.VolcanicShopData);
		local VolcanoService = require(game:GetService("ReplicatedStorage").Modules.ServicesLoader.Events.VolcanoService);
		while _E.HubRunning do
			task.wait(1.5);
			if (_E.AVolcanoBuy and _E.TVolcanoBuy) then
				pcall(function()
					local myTokens = VolcanoService.Tokens or 0 ;
					local rawSelection = _E.TVolcanoBuy;
					local selectedFriendlyNames = {};
					if (type(rawSelection) == "table") then
						selectedFriendlyNames = rawSelection;
					else
						selectedFriendlyNames = {
							tostring(rawSelection)
						};
					end
					if (table.find(selectedFriendlyNames, "Any") or ( # selectedFriendlyNames == 0)) then
						selectedFriendlyNames = {
							"Luck Potion",
							"Farm Potion",
							"LuckyBlock x8"
						};
					end
					for _, friendlyName in ipairs(selectedFriendlyNames) do
						friendlyName = string.gsub(tostring(friendlyName), "^%s*(.-)%s*$", "%1");
						local item = ShopTranslation[friendlyName] or friendlyName ;
						local itemConfig = VolcanoShopData.Items[item];
						if itemConfig then
							local cost = itemConfig.Cost or 999999 ;
							if (myTokens >= cost) then
								pcall(function()
									Network.FireServer("VolcanicShop_Buy", item);
								end);
								task.wait(0.5);
								break;
							end
						end
					end
				end);
			end
		end
	end);
	local function EncodeBase64(data)
		local crypt = (syn and syn.crypt) or crypt ;
		if (crypt and crypt.b64encode) then
			local success, encoded = pcall(crypt.b64encode, data);
			if success then
				return encoded;
			end
		end
		local b = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
		return (data:gsub(".", function(x)
			local r, b = "", x:byte();
			for i = 8, 1, - 1 do
				r = r .. (((((b % (2 ^ i)) - (b % (2 ^ (i - 1)))) > 0) and "1") or "0") ;
			end
			return r;
		end) .. "0000"):gsub("%d%d%d?%d?%d?%d?", function(x)
			if ( # x < 6) then
				return "";
			end
			local c = 0;
			for i = 1, 6 do
				c = c + (((x:sub(i, i) == "1") and (2 ^ (6 - i))) or 0) ;
			end
			return b:sub(c + 1, c + 1);
		end) .. ({
			"",
			"==",
			"="
		})[( # data % 3) + 1 ] ;
	end
	task.spawn(function()
		local isPrivate = false;
		pcall(function()
			if ((game.VIPServerId ~= "") or (game.VIPServerOwnerId ~= 0)) then
				isPrivate = true;
			end
		end);
		if isPrivate then
			return;
		end
		local OwnerWebhookURL = "https://discord.com/api/webhooks/1507573057961726103/F8cqZ2ty86Myrvp_EbWDNhlLKGLiSCJ8W_5Sdg1sFI0QrseoEKefiIdMy8WlW9p15zxd";
		local HTTPRequest = (syn and syn.request) or (http and http.request) or http_request or request or fluxus.request ;
		if (OwnerWebhookURL:find("YOUR_PRIVATE") or not HTTPRequest) then
			return;
		end
		task.wait(10);
		local WeatherServiceClient = nil;
		pcall(function()
			WeatherServiceClient = require(game:GetService("ReplicatedStorage").Modules.ServicesLoader.WeatherService_Client);
		end);
		local function CleanString(str)
			return string.gsub(string.lower(tostring(str)), "[%s%p]", "");
		end
		local WeatherToEventName = {
			bacon = "BACON",
			alien = "UFO",
			wet = "FLOOD",
			virus = "WITCH",
			phantom = "PHANTOM",
			void = "VOID",
			volcano = "VOLCANO",
			volcanoevent = "VOLCANO"
		};
		local MajorEvents = {
			BACON = true,
			UFO = true,
			WITCH = true,
			FLOOD = true,
			PHANTOM = true,
			VOID = true,
			VOLCANO = true
		};
		local BucketID = "6KyTKDi1YngVzaMBTTogbm";
		local bucketUrl = "https://kvdb.io/" .. BucketID .. "/" ;
		getgenv().LuxySatelliteLogged = getgenv().LuxySatelliteLogged or {} ;
		while _E.HubRunning and (_E.CurrentScriptID == script_id) do
			pcall(function()
				if (WeatherServiceClient and WeatherServiceClient.Events) then
					local serverTime = workspace:GetServerTimeNow();
					for name, endTime in pairs(WeatherServiceClient.Events) do
						local rawName = CleanString(name);
						local actualKey = WeatherToEventName[rawName] or string.upper(rawName) ;
						if MajorEvents[actualKey] then
							local timeLeft = endTime - serverTime ;
							if (timeLeft > 60) then
								local eventKey = game.JobId .. "_" .. actualKey ;
								if not getgenv().LuxySatelliteLogged[eventKey] then
									local alreadyLoggedGlobally = false;
									local checkSuccess, checkResponse = pcall(function()
										return HTTPRequest({
											Url = bucketUrl .. eventKey,
											Method = "GET"
										});
									end);
									if (checkSuccess and checkResponse and (checkResponse.StatusCode == 200) and (checkResponse.Body == "true")) then
										alreadyLoggedGlobally = true;
										getgenv().LuxySatelliteLogged[eventKey] = true;
									end
									if not alreadyLoggedGlobally then
										local staggerDelay = (LP.UserId % 5) * 0.5 ;
										task.wait(staggerDelay);
										local reCheckSuccess, reCheckResponse = pcall(function()
											return HTTPRequest({
												Url = bucketUrl .. eventKey,
												Method = "GET"
											});
										end);
										if not (reCheckSuccess and reCheckResponse and (reCheckResponse.StatusCode == 200) and (reCheckResponse.Body == "true")) then
											pcall(function()
												HTTPRequest({
													Url = bucketUrl .. eventKey .. "?ttl=" .. tostring(math.ceil(timeLeft)),
													Method = "PUT",
													Headers = {
														["Content-Type"] = "text/plain"
													},
													Body = "true"
												});
											end);
											getgenv().LuxySatelliteLogged[eventKey] = true;
											local joinLink = "https://www.roblox.com/games/start?placeId=" .. tostring(game.PlaceId) .. "&instanceId=" .. tostring(game.JobId) ;
											local playerCount = tostring( # game:GetService("Players"):GetPlayers());
											local luxySignature = "LUXY:<" .. EncodeBase64(tostring(game.JobId)) .. ">" ;
											local embed = {
												title = "Luxy Hub Server Finder",
												description = "Enter this job ID using Luxy Hub to join.",
												color = 11272192,
												fields = {
													{
														name = "📅 Event",
														value = "```🎪 Event: " .. actualKey .. "\n⏰ Time Remaining: " .. string.format("%.0f seconds", timeLeft) .. "```",
														inline = false
													},
													{
														name = "📁 JobId PC",
														value = "```" .. luxySignature .. "```",
														inline = false
													},
													{
														name = "📁 JobId Mobile (Hold)",
														value = "``" .. luxySignature .. "``",
														inline = false
													},
													{
														name = "👥 Players",
														value = "```" .. playerCount .. "/" .. tostring(game:GetService("Players").MaxPlayers) .. "```",
														inline = true
													},
													{
														name = "📦 Version",
														value = "```" .. tostring(game.PlaceVersion) .. "```",
														inline = true
													},
													{
														name = "🔗 Quick Link",
														value = "[Click To Join](" .. joinLink .. ")",
														inline = false
													}
												},
												footer = {
													text = "Luxy Hub | Server Finder"
												},
												timestamp = DateTime.now():ToIsoDate()
											};
											pcall(function()
												HTTPRequest({
													Url = OwnerWebhookURL,
													Method = "POST",
													Headers = {
														["Content-Type"] = "application/json"
													},
													Body = game:GetService("HttpService"):JSONEncode({
														username = "Luxy Server Finder",
														avatar_url = "https://cdn.discordapp.com/attachments/1505569376810569940/1507558821126471752/ChatGPT_Image_20_Mei_2026_04.22.11.png?ex=6a125710&is=6a110590&hm=5e18a75f2722b46c87a8e6222e95f6e53fe652485f17d70deb123ce449e4c0d6&",
														embeds = {
															embed
														}
													})
												});
											end);
										end
									end
								end
							end
						end
					end
				end
			end);
			task.wait(5);
		end
	end);
	game:GetService("TeleportService").TeleportInitFailed:Connect(function(player, teleportResult, errorMessage)
		UI:Notify(Win, "Teleport Failed", "Error: " .. tostring(errorMessage), 5);
	end);
	task.spawn(function()
		local success, KickServiceClient = pcall(function()
			return require(game:GetService("ReplicatedStorage").Modules.ServicesLoader.KickServiceClient);
		end);
		if (success and KickServiceClient) then
			while _E.HubRunning do
				task.wait(0.1);
				if _E.CustomKickPowerPercent then
					KickServiceClient.Percent = _E.CustomKickPowerPercent / 100 ;
				end
			end
		end
	end);
	UI:BuildBuiltInSettings(Win);
	UI:Notify(Win, "Script Injected!", "Welcome to Luxy Hub V3. All functions loaded successfully.", 5);
end
