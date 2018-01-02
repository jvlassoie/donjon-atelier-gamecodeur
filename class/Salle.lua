Salle = {}

Salle.__index = Salle

function Salle.new(lin,col)
	
	local mySalle = {}
	
	setmetatable(mySalle, Salle)

	mySalle.col = col
	mySalle.lin = lin

	mySalle.isOpen = false
	
	
	mySalle.doorUp = false
	mySalle.doorRight = false
	mySalle.doorDown = false
	mySalle.doorLeft = false
	
	
	
	
	return mySalle	
	
end



function Salle:porteDraw(x, y, caseW, caseH) 
	
	local doorW = 6
	local doorH = 6

	love.graphics.setColor(93,64,55)

	if self.doorUp == true then 

		love.graphics.rectangle("fill", x + caseW / 2 - doorW / 2 , y - doorH / 2 , doorW, doorH)

	end

	if self.doorRight == true then 

		love.graphics.rectangle("fill", x + caseW - doorW / 2 , y + caseH / 2 - doorH / 2, doorW, doorH)

	end

	if self.doorDown == true then 

		love.graphics.rectangle("fill", x + caseW / 2 - doorW / 2 , y + caseH - doorH / 2  , doorW, doorH)

	end

	if self.doorLeft == true then 

		love.graphics.rectangle("fill", x - doorW / 2, y + caseH / 2 - doorH / 2, doorW, doorH)
		
	end

	love.graphics.setColor(255,255,255)


end