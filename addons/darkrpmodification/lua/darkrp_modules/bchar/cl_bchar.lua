-- #NoSimplerr#
local bChar = {}

-- Normal Citizen Models with Path, Index for SubMaterial of the Body and Gender. Gonna modify the tbl later on for facemap support.
/*
bChar.plyModelList = {
{model = "models/player/Group01/female_01.mdl", skinid = 2, gender = "female"},
{model = "models/player/Group01/female_02.mdl", skinid = 3, gender = "female"},
{model = "models/player/Group01/female_03.mdl", skinid = 3, gender = "female"},
{model = "models/player/Group01/female_04.mdl", skinid = 1, gender = "female"},
{model = "models/player/Group01/female_05.mdl", skinid = 2, gender = "female"},
{model = "models/player/Group01/female_06.mdl", skinid = 4, gender = "female"},
{model = "models/player/Group01/male_01.mdl", skinid = 3, gender = "male"},
{model = "models/player/Group01/male_02.mdl", skinid = 2, gender = "male"},
{model = "models/player/Group01/male_03.mdl", skinid = 4, gender = "male"},
{model = "models/player/Group01/male_04.mdl", skinid = 4, gender = "male"},
{model = "models/player/Group01/male_05.mdl", skinid = 4, gender = "male"},
{model = "models/player/Group01/male_06.mdl", skinid = 4, gender = "male"},
{model = "models/player/Group01/male_07.mdl", skinid = 4, gender = "male"},
{model = "models/player/Group01/male_08.mdl", skinid = 0, gender = "male"},
{model = "models/player/Group01/male_09.mdl", skinid = 2, gender = "male"},
}
*/
bChar.plyModelList = {
{model = "models/player/zelpa/female_01.mdl", gender = "female", torso_bgid = 1, torso_bgsid = 2, torso_skinid = 5, legs_bgid = 2, legs_bgsid = 7, legs_skinid = 9},
{model = "models/player/zelpa/female_02.mdl", gender = "female", torso_bgid = 1, torso_bgsid = 2, torso_skinid = 6, legs_bgid = 2, legs_bgsid = 7, legs_skinid = 10},
{model = "models/player/zelpa/female_03.mdl", gender = "female", torso_bgid = 1, torso_bgsid = 2, torso_skinid = 5, legs_bgid = 2, legs_bgsid = 7, legs_skinid = 9},
{model = "models/player/zelpa/female_04.mdl", gender = "female", torso_bgid = 1, torso_bgsid = 2, torso_skinid = 5, legs_bgid = 2, legs_bgsid = 7, legs_skinid = 9},
{model = "models/player/zelpa/female_06.mdl", gender = "female", torso_bgid = 1, torso_bgsid = 2, torso_skinid = 5, legs_bgid = 2, legs_bgsid = 7, legs_skinid = 9},
{model = "models/player/zelpa/female_07.mdl", gender = "female", torso_bgid = 1, torso_bgsid = 2, torso_skinid = 5, legs_bgid = 2, legs_bgsid = 7, legs_skinid = 9},
{model = "models/player/zelpa/male_01.mdl", gender = "male", torso_bgid = 1, torso_bgsid = 2, torso_skinid = 5, legs_bgid = 2, legs_bgsid = 5, legs_skinid = 8}
}

-- Ripped eChat Fonts
surface.CreateFont( "bChar_18", {
font = "Roboto Lt",
size = 18,
weight = 500,
antialias = true,
} )
surface.CreateFont( "bChar_16", {
font = "Roboto Lt",
size = 16,
weight = 500,
antialias = true,
} )

function bChar.buildBox()
bChar.curModel = 1
local curTorso = 0
local curLegs = 0
bChar.Frame = vgui.Create("DFrame")
bChar.Frame:SetSize( 800, 600 )
bChar.Frame:SetTitle("")
bChar.Frame:ShowCloseButton( true )
bChar.Frame:SetDraggable( false )
bChar.Frame:SetPos( ScrW()/2 - (bChar.Frame:GetWide()/2), ScrH()/2 - (bChar.Frame:GetTall()/2))
bChar.Frame.Paint = function( self, w, h )
bChar.blur( self, 10, 20, 255 )
draw.RoundedBox( 0, 0, 0, w, h, Color( 30, 30, 30, 200 ) )
draw.RoundedBox( 0, 0, 0, w, 25, Color( 80, 80, 80, 100 ) )
end
bChar.Frame:MakePopup()
local title = vgui.Create("DLabel", bChar.Frame)
title:SetText( "Char Creation" )
title:SetFont( "bChar_18" )
title:SizeToContents()
title:SetPos( 5, 4 )

local TextEntry = vgui.Create( "DTextEntry", bChar.Frame )	-- create the form as a child of frame
TextEntry:SetPos( 250, 50 )
TextEntry:SetSize( 100, 25 )
TextEntry:SetText( "Vorname" )
local TextEntry2 = vgui.Create( "DTextEntry", bChar.Frame )	-- create the form as a child of frame
TextEntry2:SetPos( 450, 50 )
TextEntry2:SetSize( 100, 25 )
TextEntry2:SetText( "Nachname" )

bChar.icon = vgui.Create("DModelPanel", bChar.Frame)
bChar.icon:SetSize( 200, 450 )
bChar.icon:SetPos( 300, 25 )
bChar.icon:SetModel( bChar.plyModelList[bChar.curModel].model )
function bChar.icon:LayoutEntity( Entity ) return end
-- Adjust the position of the entity
bChar.icon.Entity:SetPos( Vector( 25, 25, 0 ) )
bChar.icon.Entity:SetAngles( Angle( 0, 40, 0 ) )
bChar.icon.Entity:SetBodygroup(bChar.plyModelList[bChar.curModel].torso_bgid, bChar.plyModelList[bChar.curModel].torso_bgsid)
bChar.icon.Entity:SetBodygroup(bChar.plyModelList[bChar.curModel].legs_bgid, bChar.plyModelList[bChar.curModel].legs_bgsid)
local modelbuttonforward = vgui.Create("DButton", bChar.Frame)
modelbuttonforward:SetPos(550, 150)
modelbuttonforward:SetSize( 100, 50 )
modelbuttonforward:SetText("Next Body")
modelbuttonforward:SetFont( "bChar_18")
modelbuttonforward.Paint = function( self, w, h )
draw.RoundedBox( 0, 0, 0, w, h, Color( 50, 50, 50, 200 ) )
end
modelbuttonforward.DoClick = function()
	if bChar.curModel >= #bChar.plyModelList then
		bChar.curModel = 1
	else
		bChar.curModel = bChar.curModel + 1
	end
	bChar.icon:Remove()
	bChar.icon = nil
	bChar.ReCreateModelPanel()
	bChar.icon.Entity:SetModel(bChar.plyModelList[bChar.curModel].model)
	bChar.icon.Entity:SetSubMaterial(bChar.plyModelList[bChar.curModel].torso_skinid, "sheets_"..bChar.plyModelList[bChar.curModel].gender.."/sheet_0"..curTorso..".vmt")
	bChar.icon.Entity:SetSubMaterial(bChar.plyModelList[bChar.curModel].legs_skinid, "sheets_"..bChar.plyModelList[bChar.curModel].gender.."/sheet_0"..curLegs..".vmt")
	print("bChar.curModel model:" .. bChar.curModel)
end
local torsobuttonforward = vgui.Create("DButton", bChar.Frame)
torsobuttonforward:SetPos(550, 250)
torsobuttonforward:SetSize( 100, 50 )
torsobuttonforward:SetText("Next Torso")
torsobuttonforward:SetFont( "bChar_18")
torsobuttonforward.Paint = function( self, w, h )
draw.RoundedBox( 0, 0, 0, w, h, Color( 50, 50, 50, 200 ) )
end
torsobuttonforward.DoClick = function()
	if curTorso >= 9 then
		curTorso = 1
	else
		curTorso = curTorso + 1
	end
	bChar.icon.Entity:SetSubMaterial(bChar.plyModelList[bChar.curModel].torso_skinid, "sheets_"..bChar.plyModelList[bChar.curModel].gender.."/sheet_0"..curTorso..".vmt")
	print("CurTorso:" .. curTorso)
end
local legbuttonforward = vgui.Create("DButton", bChar.Frame)
legbuttonforward:SetPos(550, 350)
legbuttonforward:SetSize( 100, 50 )
legbuttonforward:SetText("Next Legs")
legbuttonforward:SetFont( "bChar_18")
legbuttonforward.Paint = function( self, w, h )
draw.RoundedBox( 0, 0, 0, w, h, Color( 50, 50, 50, 200 ) )
end
legbuttonforward.DoClick = function()
	if curLegs >= 9 then
		curLegs = 1
	else
		curLegs = curLegs + 1
	end
	bChar.icon.Entity:SetSubMaterial(bChar.plyModelList[bChar.curModel].legs_skinid, "sheets_"..bChar.plyModelList[bChar.curModel].gender.."/sheet_0"..curLegs..".vmt")
	print("CurLegs:" .. curLegs)
end
local modelbuttonbackwards = vgui.Create("DButton", bChar.Frame)
modelbuttonbackwards:SetPos(150, 150)
modelbuttonbackwards:SetSize( 100, 50 )
modelbuttonbackwards:SetText("Prev Body")
modelbuttonbackwards:SetFont( "bChar_18")
modelbuttonbackwards.Paint = function( self, w, h )
draw.RoundedBox( 0, 0, 0, w, h, Color( 50, 50, 50, 200 ) )
end
modelbuttonbackwards.DoClick = function()
	if bChar.curModel <= 1 then
		bChar.curModel = #bChar.plyModelList
	else
		bChar.curModel = bChar.curModel - 1
	end
	bChar.icon:Remove()
	bChar.icon = nil
	bChar.ReCreateModelPanel()
	bChar.icon.Entity:SetModel(bChar.plyModelList[bChar.curModel].model)
	bChar.icon.Entity:SetSubMaterial(bChar.plyModelList[bChar.curModel].torso_skinid, "sheets_"..bChar.plyModelList[bChar.curModel].gender.."/sheet_0"..curTorso..".vmt")
	bChar.icon.Entity:SetSubMaterial(bChar.plyModelList[bChar.curModel].legs_skinid, "sheets_"..bChar.plyModelList[bChar.curModel].gender.."/sheet_0"..curLegs..".vmt")
	print("bChar.curModel model:" .. bChar.curModel)
end
local torsobuttonbackwards = vgui.Create("DButton", bChar.Frame)
torsobuttonbackwards:SetPos(150, 250)
torsobuttonbackwards:SetSize( 100, 50 )
torsobuttonbackwards:SetText("Prev Torso")
torsobuttonbackwards:SetFont( "bChar_18")
torsobuttonbackwards.Paint = function( self, w, h )
draw.RoundedBox( 0, 0, 0, w, h, Color( 50, 50, 50, 200 ) )
end
torsobuttonbackwards.DoClick = function()
	if curTorso <= 1 then
		curTorso = 9
	else
		curTorso = curTorso - 1
	end
	bChar.icon.Entity:SetSubMaterial(bChar.plyModelList[bChar.curModel].torso_skinid, "sheets_"..bChar.plyModelList[bChar.curModel].gender.."/sheet_0"..curTorso..".vmt")
	print("CurTorso:" .. curTorso)
end
local legbuttonbackwards = vgui.Create("DButton", bChar.Frame)
legbuttonbackwards:SetPos(150, 350)
legbuttonbackwards:SetSize( 100, 50 )
legbuttonbackwards:SetText("Prev Legs")
legbuttonbackwards:SetFont( "bChar_18")
legbuttonbackwards.Paint = function( self, w, h )
draw.RoundedBox( 0, 0, 0, w, h, Color( 50, 50, 50, 200 ) )
end
legbuttonbackwards.DoClick = function()
	if curLegs <= 1 then
		curLegs = 9
	else
		curLegs = curLegs - 1
	end
	bChar.icon.Entity:SetSubMaterial(bChar.plyModelList[bChar.curModel].legs_skinid, "sheets_"..bChar.plyModelList[bChar.curModel].gender.."/sheet_0"..curLegs..".vmt")
	print("CurLegs:" .. curLegs)
end
local confirm = vgui.Create("DButton", bChar.Frame)
confirm:SetPos(350, 550)
confirm:SetSize( 100, 50 )
confirm:SetText("")
--confirm:SetFont( "bChar_18")
confirm.Paint = function( self, w, h )
draw.RoundedBox( 0, 0, 0, w, h, Color( 50, 50, 50, 200 ) )
draw.SimpleText("Confirm", bChar_18, w/2, h/2, Color(200,200,200,255), TEXT_ALIGN_CENTER , TEXT_ALIGN_CENTER )
end
confirm.DoClick = function()
	local tbl = bChar.plyModelList[bChar.curModel]
	tbl.torso_sheet = curTorso
	tbl.legs_sheet = curLegs
	tbl.firstname = TextEntry:GetValue()
	tbl.secondname = TextEntry2:GetValue()
	local checkname = tbl.firstname .. " " .. tbl.secondname
	if not string.match(checkname, "^[a-zA-Z0-9 ]+$") then return end
	net.Start("bChar_RPNameCheck")
	net.WriteString(checkname)
	net.WriteTable(tbl)
	net.SendToServer()
end

bChar.Frame:MakePopup()
end
net.Receive("bChar_RPNameCheck", function()
local bool = net.ReadString()
local tbl = net.ReadTable()
if bool == "true" then 
	net.Start("bChar_Confirm")
	net.WriteTable(tbl)
	net.SendToServer()
	bChar.Frame:Remove()
else
	print("error")
end
end)
concommand.Add("testmenu2", bChar.buildBox)

function bChar.ReCreateModelPanel()
	bChar.icon = vgui.Create("DModelPanel", bChar.Frame)
	bChar.icon:SetSize( 200, 450 )
	bChar.icon:SetPos( 300, 25 )
	bChar.icon:SetModel( bChar.plyModelList[bChar.curModel].model )
	function bChar.icon:LayoutEntity( Entity ) return end
	-- Adjust the position of the entity
	bChar.icon.Entity:SetPos( Vector( 25, 25, 0 ) )
	bChar.icon.Entity:SetAngles( Angle( 0, 40, 0 ) )
	bChar.icon.Entity:SetBodygroup(bChar.plyModelList[bChar.curModel].torso_bgid, bChar.plyModelList[bChar.curModel].torso_bgsid)
	bChar.icon.Entity:SetBodygroup(bChar.plyModelList[bChar.curModel].legs_bgid, bChar.plyModelList[bChar.curModel].legs_bgsid)
end
--// Panel based blur function by Chessnut from NutScript
local blur = Material( "pp/blurscreen" )
function bChar.blur( panel, layers, density, alpha )
	-- Its a scientifically proven fact that blur improves a script
	local x, y = panel:LocalToScreen(0, 0)

	surface.SetDrawColor( 255, 255, 255, alpha )
	surface.SetMaterial( blur )

	for i = 1, 3 do
		blur:SetFloat( "$blur", ( i / layers ) * density )
		blur:Recompute()

		render.UpdateScreenEffectTexture()
		surface.DrawTexturedRect( -x, -y, ScrW(), ScrH() )
	end
end
--// Everything below this line isn't currently used, but are important later on.
/*
net.Receive("Baus_plymdl", function(len, ply)
	local mdl = net.ReadTable()
	ply.Baus_gender = mdl.gender
	ply.Baus_plymdl = mdl.model
	ply.Baus_skinid = mdl.skinid
	ply:SetModel(ply.Baus_plymdl) -- So that the default random model is changed to the choosen one.
end)

	local grid = vgui.Create("DGrid", bChar.Frame)
	grid:SetPos(10, 30)
	grid:SetCols( 8 )
	grid:SetColWide( 80 )
	grid:SetRowHeight( 80 )
	for i = 1, #PlyModelList do
		local mdlbut = vgui.Create( "DModelPanel" )
		function mdlbut:LayoutEntity( Entity ) return end
		mdlbut:SetModel(PlyModelList[i].model)
		mdlbut:SetSize( 80, 80 )
		mdlbut.Entity:SetPos( mdlbut.Entity:GetPos() - Vector( 0, 0, 4 ) )
		mdlbut:SetCamPos( CamPos )
		mdlbut:SetLookAt( LookAt )
		mdlbut.skinid = PlyModelList[i].skinid
		mdlbut.gender = PlyModelList[i].gender
		mdlbut.DoClick = function(self)
			local tbl = {model = self:GetModel(), skinid = self.skinid, gender = self.gender}
			net.Start("Baus_plymdl")
			net.WriteTable(tbl)
			net.SendToServer()
			surface.PlaySound("UI/buttonclick.wav")
			bChar.Frame:Close()
		end
		grid:AddItem( mdlbut )
	end

*/