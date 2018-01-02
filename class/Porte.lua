Porte = {}

Porte.__index = Porte


function Porte.new(x,y,width,height, type)

	local myPorte = {}
	
	setmetatable(myPorte, Porte)

	myPorte.x = x
	myPorte.y = y
	myPorte.width = width
	myPorte.height = height
	myPorte.type = type
	
	return myPorte

end


