-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf('no')

-- Empèche Love de filtrer les contours des images quand elles sont redimentionnées
-- Indispensable pour du pixel art
love.graphics.setDefaultFilter("nearest")

local screenWidth = love.graphics.getWidth()
local screenHeight = love.graphics.getHeight()


require "Autoload"

local myDonjon

local player

local salleDonjon

local currentRoom = {}

currentRoom.listDoor = {}

local tileSize = 64

function initPlayer()
	
	player = Sprite.new(screenWidth / 2, screenHeight / 2, "player", false, 11)
	
	
	player:addAnimation("walk", {1,2,3,4,5,6,7,8,9,10,11} )
	player:addAnimation("idle", {1} )


end


function loadRoom(room)
	
	currentRoom.room = room
	
	local pushForCollide = 5
	
	if room.doorUp then

		local door = Porte.new(screenWidth / 2 - tileSize  , 0 + pushForCollide ,tileSize * 2, tileSize * 2, "doorUp")
		
		
		table.insert(currentRoom.listDoor, door)
		
		
	end
	
	if room.doorRight then
		
		local door = Porte.new(screenWidth - tileSize * 2 - pushForCollide , screenHeight / 2 - tileSize ,tileSize * 2, tileSize * 2, "doorRight")
		
		
		table.insert(currentRoom.listDoor, door)
		
		
	end
	
	if room.doorDown then
		
		
		local door = Porte.new(screenWidth / 2 - tileSize  , screenHeight - tileSize * 2 - pushForCollide ,tileSize * 2, tileSize * 2, "doorDown")
		
		
		table.insert(currentRoom.listDoor, door)
		
		
		
	end
	
	if room.doorLeft then
		
		
		local door = Porte.new(0 + pushForCollide , screenHeight / 2 - tileSize  ,tileSize * 2, tileSize * 2, "doorLeft")
		
		
		table.insert(currentRoom.listDoor, door)
		
		
		
	end
	

end


function getTypeDoor(obj)
	
	for i=1,#currentRoom.listDoor do
		
		local room = currentRoom.listDoor[i]
		
		if room.x < obj.x  and room.x + room.width > obj.x and room.y < obj.y + obj.height / 2 and room.y + room.height > obj.y then
			
			return room.type
			
		end
	end
	
end


function initGame()
	
	myDonjon = Donjon.new(9,6)
	myDonjon.doorDonjon = true
	
	salleDonjon = {}
	salleDonjon.image = love.graphics.newImage("assets/img/salle.png")
	salleDonjon.map = {}
	salleDonjon.map[1] =   {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}
	salleDonjon.map[2] =   {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}
	salleDonjon.map[3] =   {1,1,0,0,0,0,0,0,0,0,0,0,0,0,1,1}
	salleDonjon.map[4] =   {1,1,0,0,0,0,0,0,0,0,0,0,0,0,1,1}
	salleDonjon.map[5] =   {1,1,0,0,0,0,0,0,0,0,0,0,0,0,1,1}
	salleDonjon.map[6] =   {1,1,0,0,0,0,0,0,0,0,0,0,0,0,1,1}
	salleDonjon.map[7] =   {1,1,0,0,0,0,0,0,0,0,0,0,0,0,1,1}
	salleDonjon.map[8] =   {1,1,0,0,0,0,0,0,0,0,0,0,0,0,1,1}
	salleDonjon.map[9] =   {1,1,0,0,0,0,0,0,0,0,0,0,0,0,1,1}
	salleDonjon.map[10] =  {1,1,0,0,0,0,0,0,0,0,0,0,0,0,1,1}
	salleDonjon.map[11] =  {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}
	salleDonjon.map[12] =  {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}
	
	loadRoom(myDonjon.roomStart)
	
	initPlayer()
	
	imagePorteUp = love.graphics.newImage("assets/img/porteUp.png")
	imagePorteRight = love.graphics.newImage("assets/img/porteRight.png")
	imagePorteDown = love.graphics.newImage("assets/img/porteDown.png")
	imagePorteLeft = love.graphics.newImage("assets/img/porteLeft.png")
end



--------------------------------------------------------------------------

---------------------------------GAMELOOP---------------------------------

--------------------------------------------------------------------------

function love.load()
	
	
	
	initGame()
	
	
	
end


function love.update(dt)


	player.oldX = player.x
	player.oldY = player.y

	
	local animationBool = false
	
	
	
	if love.keyboard.isDown("up") then
		
		animationBool = true
		
		player.vy = player.vy - player.vitesse * dt
		
		
		
	end
	
	if love.keyboard.isDown("right") then
		
		animationBool = true
		
		player.vx = player.vx + player.vitesse * dt
		
		player.flip =  1
		
	end
	
	if love.keyboard.isDown("down") then
		
		animationBool = true
		
		player.vy = player.vy + player.vitesse * dt
		
		
	end
	
	if love.keyboard.isDown("left") then
		
		animationBool = true
		
		player.vx = player.vx - player.vitesse * dt
		
		
		player.flip =  - 1
		
	end
	
	if animationBool then
		
		player:animationPlay("walk", dt)



	else
		
		player:animationPlay("idle", dt)

	end
	
	--diminué la vélocité
	
	player.vx = player.vx * 0.94
	player.vy = player.vy * 0.94
	
	
	--reinit sa velocité a 0
	
	if math.abs(player.vx) < 0.01 then player.vx = 0 end

	if math.abs(player.vy) < 0.02 then 	player.vy = 0 end

	
	--position
	
	player.x = player.x + player.vx
	player.y = player.y + player.vy
	
	--collision
	
	player.col = math.floor(player.x / tileSize + 1)
	player.lin = math.floor((player.y + player.height / 2 - 6) / tileSize + 1)
	
	
	if salleDonjon.map[player.lin][player.col] == 1 then


		player.x = player.oldX
		player.y = player.oldY
		player.vx = 0
		player.vy = 0
		
		
	end 


--changement de salle


local typeRoom = getTypeDoor(player)
local newRoom = nil
local newX = screenWidth / 2
local newY = screenHeight / 2


if typeRoom == "doorUp" then
	
	newRoom = myDonjon.donjon[currentRoom.room.lin - 1][currentRoom.room.col]
	newX = player.x 
	newY = screenHeight / 2 + tileSize * 3
	

end

if typeRoom == "doorRight" then

	newRoom = myDonjon.donjon[currentRoom.room.lin][currentRoom.room.col + 1]
	newX = screenWidth / 2 - tileSize * 5
	newY = player.y  
	
end

if typeRoom == "doorDown" then

	newRoom = myDonjon.donjon[currentRoom.room.lin + 1][currentRoom.room.col]
	newX = player.x 
	newY = screenHeight / 2 - tileSize * 3
	
end

if typeRoom == "doorLeft" then

	newRoom = myDonjon.donjon[currentRoom.room.lin][currentRoom.room.col - 1]
	newX = screenWidth / 2 + tileSize * 5
	newY = player.y

end

if newRoom ~= nil then
	
	
	currentRoom.listDoor = {}
	
	loadRoom(newRoom)
	
	player.x = newX
	player.y = newY
	
end



end


function love.draw()

	
	
	
	love.graphics.draw(salleDonjon.image, 0, 0)
	
	
	
	
	--affichage des portes
	local imagePorte
	
	for i=1,#currentRoom.listDoor do
		
		local door = currentRoom.listDoor[i]
		
		
		if door.type == "doorUp" then
			
			imagePorte = imagePorteUp	
			
		end
		
		if door.type == "doorRight" then
			
			imagePorte = imagePorteRight	
			
		end
		
		if door.type == "doorDown" then
			
			imagePorte = imagePorteDown	
			
		end
		
		if door.type == "doorLeft" then
			
			imagePorte = imagePorteLeft	
			
		end
		
		love.graphics.draw(imagePorte, door.x, door.y)
		
			--love.graphics.rectangle("line", door.x , door.y, door.width, door.height)
			
		end
		
		player:draw()
		
		myDonjon:draw(5,5, currentRoom.room)

	end

	function love.keypressed(key)
		
		if(key == "space") then 

			--myDonjon = Donjon.new(9,6)
			

		end 

	end