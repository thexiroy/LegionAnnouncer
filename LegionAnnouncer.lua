-- The legion release time
reference = time{day=30, year=2016, month=8, min=0, sec=1, hour=0}

refresh = function()

--Tweaking variables
local xPosition = -1000 --x start position of the clock with center as origin
local yPosition = 500 --y start position of the clock with center as origin
local reduceBaseSize = 0.8 --Scales the whole clock
local spaceBetween = 135*reduceBaseSize -- Between the time types: days hours minutes seconds
local spaceBetweenNumbers = 62*reduceBaseSize --Between first and second number
local amountOfNumbers = 4 --Set to how far you would like the clock go, from 1 - 4 (days - seconds)

--Don't touch these
local stringDays
local backgroundWidth = 800
local backgroundHeight = 100
local numberSize = 64*reduceBaseSize

--Calculations for every part of the clock days,hours,minutes, seconds
secondsTillReference = difftime(reference, time())
doubleDays = secondsTillReference / (24 * 60 * 60)
intDays = math.floor(doubleDays)
doubleHours = (doubleDays - intDays) * 24
intHours = math.floor(doubleHours)
doubleMinutes = (doubleHours - intHours) * 60
intMinutes = math.floor(doubleMinutes)
doubleSeconds = (doubleMinutes - intMinutes) * 60
intSeconds = math.floor(doubleSeconds+0.5)

--Graphical shit :)
local displayingTime 
for z=amountOfNumbers, 1, -1
do
	--Display the amount of numbers requested
	if(z == amountOfNumbers) then
		displayingTime = intDays
	elseif(z == amountOfNumbers-1) then
		displayingTime = intHours
	elseif(z == amountOfNumbers-2) then
		displayingTime = intMinutes
	elseif(z == amountOfNumbers-3) then
		displayingTime = intSeconds	
	end

	--First time part
	local f = CreateFrame("Frame", nil, UIParent)
	f:SetFrameStrata("BACKGROUND")
	f:SetWidth(numberSize)
	f:SetHeight(numberSize)
	local frame = CreateFrame("FRAME", "FooAddonFrame")
	f:Show()
	C_Timer.After(1, function() f:Hide() end)
	
	for i=9, 0, -1
	do
		if(math.floor(displayingTime/10) == i) then
			local t = f:CreateTexture(nil,"test")
			t:SetTexture("Interface\\AddOns\\LegionAnnouncer\\numbers\\" .. i .. ".blp")
			t:SetAllPoints(f)
			f.texture = t
			f:SetPoint("CENTER",xPosition+100,yPosition)
		end
	end  
	
	-- second time part
	local f = CreateFrame("Frame", nil, UIParent)
	f:SetFrameStrata("BACKGROUND")
	f:SetWidth(numberSize)
	f:SetHeight(numberSize)
	local frame = CreateFrame("FRAME", "FooAddonFrame")
	f:Show()
	C_Timer.After(1, function() f:Hide() end)
	
	for y=9, 0, -1
	do
		if(displayingTime-(math.floor(displayingTime/10)*10) == y) then
			local t = f:CreateTexture(nil,"test")
			t:SetTexture("Interface\\AddOns\\LegionAnnouncer\\numbers\\" .. y .. ".blp")
			t:SetAllPoints(f)
			f.texture = t
			f:SetPoint("CENTER",xPosition+100+spaceBetweenNumbers,yPosition)
		end
	end  
	
	xPosition = xPosition + spaceBetween -- some space between
end
end

local total = 0
local function onUpdate(self,elapsed)
	total = total + elapsed
    if total >= 1 then
        total = 0
		refresh()
    end
end

local f = CreateFrame("frame")
f:SetScript("OnUpdate", onUpdate)



























