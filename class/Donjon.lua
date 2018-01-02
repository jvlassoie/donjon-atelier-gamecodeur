Donjon = {}

Donjon.__index = Donjon

function Donjon.new(col,lin)
	
	local myDonjon = {}
	
	setmetatable(myDonjon, Donjon)
	
	myDonjon.col = col
	myDonjon.lin = lin

	myDonjon.caseH = 13
	myDonjon.caseW = 34
	myDonjon.caseS = 5
	
	myDonjon.doorDonjon = true
	
	myDonjon.roomStart = nil
	
	myDonjon.donjon = {}

	for i=1,myDonjon.lin do
		
		myDonjon.donjon[i] = {}
		
		for j=1,myDonjon.col do
			
			
			myDonjon.donjon[i][j] = Salle.new(i,j)
			
		end	
	end	
	
	
	
	--Génère donjon
	
	local listRooms = {}
	local nbRooms = 20
	
	--crée la salle de départ
	
	local lineStart, columnStart
	
	math.randomseed(os.time())

	lineStart = math.random(1, myDonjon.lin)
	
	columnStart = math.random(1, myDonjon.col)


	local roomStart = myDonjon.donjon[lineStart][columnStart]
	roomStart.isOpen = true
	table.insert(listRooms,roomStart)
	
	--mémoriser salle de départ dans donjon
	
	myDonjon.roomStart = roomStart

	
	--générer autre salles
	
	while #listRooms < nbRooms do
		
		local nRoom = math.random(1 , #listRooms)
		local room = listRooms[nRoom]
		
		local newRoom = nil
		
		local direction = math.random(1,4)
		
		local addRoom = false
		
		
		if direction == 1 and room.lin > 1 then
			
			newRoom = myDonjon.donjon[room.lin - 1][room.col]
			
			if newRoom.isOpen == false  then
				
				newRoom.doorDown = true
				room.doorUp = true
				
				addRoom = true
				
			end
			

		end
		
		
		if direction == 2 and room.col < myDonjon.col then
			
			newRoom = myDonjon.donjon[room.lin][room.col + 1]
			
			if newRoom.isOpen == false  then
				
				newRoom.doorLeft = true
				room.doorRight = true
				
				addRoom = true
				
			end
			

		end
		
		
		if direction == 3 and room.lin < myDonjon.lin then
			
			newRoom = myDonjon.donjon[room.lin + 1][room.col]
			
			if newRoom.isOpen == false  then
				
				newRoom.doorUp = true
				room.doorDown = true
				
				addRoom = true
				
			end
			

		end
		
		
		if direction == 4 and room.col > 1 then
			
			newRoom = myDonjon.donjon[room.lin][room.col - 1]
			
			if newRoom.isOpen == false  then
				
				newRoom.doorRight = true
				room.doorLeft = true
				
				addRoom = true
				
			end
			

		end
		
		
		if addRoom and newRoom ~= nil then
			
			newRoom.isOpen = true
			table.insert(listRooms,newRoom)
	

		end
		
	end

	return myDonjon	
	
end

function Donjon:draw(myX,myY, elRoom)

	local x,y
	
	x = myX 
	y = myY 
	

	for i=1,self.lin do

		x = myX 

		for j=1,self.col do
			
			local myRoom = self.donjon[i][j]
			
			if myRoom.isOpen == false then
				
				love.graphics.setColor(50, 50, 50)
				
				love.graphics.rectangle("fill", x , y, self.caseW, self.caseH)
				
			else
				
				
				--dessine salle courante en vert
				
				if elRoom == myRoom then
					
					love.graphics.setColor(25, 255, 25)

				else

					love.graphics.setColor(255, 255, 255)

				end
				
				love.graphics.rectangle("fill", x , y, self.caseW, self.caseH)
				
				
				
				if self.doorDonjon then
				    
					myRoom:porteDraw(x, y, self.caseW, self.caseH)
				
				end
				
				
				
			end
			
			x = x + self.caseW + self.caseS
			
		end
		
		y = y + self.caseH + self.caseS	

	end
	
		love.graphics.setColor(255,255,255)



end


