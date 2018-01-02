Sprite = {}

Sprite.__index = Sprite

function Sprite.new(x,y,name,isSpriteSheet, nbImg)
	
	local mySprite = {}
	
	setmetatable(mySprite, Sprite)
	
	mySprite.name = name
	mySprite.isSpriteSheet = isSpriteSheet
	mySprite.path = "assets/img/"
	
	
	mySprite.x = x
	mySprite.y = y
	
	mySprite.vx = 0
	mySprite.vy = 0
	
	mySprite.col = 0
	mySprite.lin = 0
	
	
	
	mySprite.vitesse = 70
	
	
	
	--old place
	
	mySprite.oldX = 0
	mySprite.oldY = 0
	
	--anim
	
	mySprite.animation = {}
	mySprite.nbImg = nbImg
	mySprite.frame = {}
	mySprite.flip = 1
	mySprite.frameChangeTime = 1.02
	mySprite.frameChangeTimeTmp = 1
	mySprite.currentAnim = 1
	mySprite.tmpFrameLaps = 1
	
	--img
	
	mySprite.img = {}
	
	
	
	if isSpriteSheet then
		
		--on charge l'image
		
		--on coupe en quad
		
	else
		
		for i=1, mySprite.nbImg do
			
			mySprite.img[i] =  love.graphics.newImage(mySprite.path..name.."-"..i..".png")
			
		end
		
		
	end
	
	mySprite.width = mySprite.img[1]:getWidth()
	mySprite.height = mySprite.img[1]:getHeight()
	
	return mySprite	
	
end



function Sprite:addAnimation(name, listAnim)

	self.frame[name] = #listAnim
	self.animation[name] = listAnim


end


function Sprite:animationPlay(name, dt)
	
	
	
	self.frameChangeTimeTmp = self.frameChangeTimeTmp + self.frameChangeTimeTmp * dt
	
	if #self.animation[name] > 1 then
		
		if self.frameChangeTimeTmp > self.frameChangeTime then
			
			self.tmpFrameLaps = (self.tmpFrameLaps == self.frame[name]) and 1 or self.tmpFrameLaps + 1
			
			self.currentAnim = self.animation[name][self.tmpFrameLaps] 
			
			self.frameChangeTimeTmp = 1
			
		end	
		
		
	else
		
		self.currentAnim = self.animation[name][1] 
		
	end
	
	
	
	
end


function Sprite:draw()
	
	local imgCurrent =  self.img[self.currentAnim]
	
	love.graphics.draw(self.img[self.currentAnim] , self.x, self.y, 0 , self.flip, 1, imgCurrent:getWidth() / 2, imgCurrent:getHeight() / 2)
	
	
end