-- #NoSimplerr#
local bChar = {}

-- Normal Citizen Models with Path, Index for SubMaterial of the Body and Gender. Gonna modify the tbl later on for facemap support.
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
	bChar.frame = vgui.Create("DFrame")
	bChar.frame:SetSize( 650, 350 )
	bChar.frame:SetTitle("")
	bChar.frame:ShowCloseButton( true )
	bChar.frame:SetDraggable( false )
	bChar.frame:SetPos( ScrW()/2 - (bChar.frame:GetWide()/2), ScrH()/2 - (bChar.frame:GetTall()/2))
	bChar.frame.Paint = function( self, w, h )
		bChar.blur( self, 10, 20, 255 )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 30, 30, 30, 200 ) )
		draw.RoundedBox( 0, 0, 0, w, 25, Color( 80, 80, 80, 100 ) )
	end
	bChar.oldPaint = bChar.frame.Paint
	
	local serverName = vgui.Create("DLabel", bChar.frame)
	serverName:SetText( "CharCreation" )
	serverName:SetFont( "bChar_18")
	serverName:SizeToContents()
	serverName:SetPos( 5, 4 )
-- Welcome to SERVERNAME or smth on this lines.
	bChar.welcomeText = vgui.Create("RichText", bChar.frame) 
	bChar.welcomeText:SetSize( bChar.frame:GetWide() - 10, bChar.frame:GetTall() - 60 )
	bChar.welcomeText:SetPos( 5, 30 )
	bChar.welcomeText.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 30, 30, 30, 100 ) )
	end
	bChar.welcomeText.PerformLayout = function( self )
		self:SetFontInternal("bChar_18")
		self:SetFGColor( color_white )
	end
	bChar.welcomeText:SetVerticalScrollbarEnabled(false)
	
	local icon = vgui.Create("DModelPanel", bChar.frame) --need to store it later in bChar for mod reason.
	icon:SetSize( 200, 200 )
	icon:SetModel( bChar.plyModelList[1].model ) -- you can only change colors on playermodels
	function icon:LayoutEntity( Entity ) return end -- disables default rotation
	icon.Entity:SetSubMaterial(bChar.plyModelList[1].skinid, "sheets_female/scrubs1.vmt")

	
	bChar.frame:MakePopup()
end

concommand.Add("testmenu2", bChar.buildBox)

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

	local grid = vgui.Create("DGrid", frame)
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
			frame:Close()
		end
		grid:AddItem( mdlbut )
	end

*/