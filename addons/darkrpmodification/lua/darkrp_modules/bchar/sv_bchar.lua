-- #NoSimplerr#
util.AddNetworkString( "bChar_Confirm" )
util.AddNetworkString("bChar_RPNameCheck")
net.Receive("bChar_RPNameCheck", function(len, ply)
print("gotchec_sv")
local newname = net.ReadString()
print(newname)
local tbl = net.ReadTable()
local canChangeName
DarkRP.retrieveRPNames(newname,function(taken)
local bool
if taken then bool = "false"
else
bool = "true"
end
net.Start("bChar_RPNameCheck")
net.WriteString(bool)
net.WriteTable(tbl)
net.Send(ply)
end)
end)
net.Receive( "bChar_Confirm", function(len, ply)
	local tbl = net.ReadTable()
	ply.bChar = {}
	ply.bChar.model = tbl.model
	ply.bChar.gender = tbl.gender
	ply.bChar.torso_bgid = tbl.torso_bgid
	ply.bChar.torso_bgsid = tbl.torso_bgsid
	ply.bChar.torso_skinid = tbl.torso_skinid
	ply.bChar.legs_bgid = tbl.legs_bgid
	ply.bChar.legs_bgsid = tbl.legs_bgsid
	ply.bChar.legs_skinid = tbl.legs_skinid
	print("Char Table:")
	PrintTable(ply.bChar)
	print("Char Table end")
	ply:setRPName(tbl.firstname.." "..tbl.secondname)
	ply:SetModel(ply.bChar.model)
	ply:SetBodygroup(ply.bChar.torso_bgid, ply.bChar.torso_bgsid)
	ply:SetBodygroup(ply.bChar.legs_bgid, ply.bChar.legs_bgsid)
	ply:SetSubMaterial(ply.bChar.torso_skinid, "sheets_"..ply.bChar.gender.."/sheet_0"..tbl.torso_sheet..".vmt")
	ply:SetSubMaterial(ply.bChar.legs_skinid, "sheets_"..ply.bChar.gender.."/sheet_0"..tbl.legs_sheet..".vmt")

end)