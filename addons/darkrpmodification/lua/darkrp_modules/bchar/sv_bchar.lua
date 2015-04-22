-- #NoSimplerr#
util.AddNetworkString( "bChar_Confirm" )
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
	PrintTable(ply.bChar)
end)