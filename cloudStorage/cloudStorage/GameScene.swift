//
//  GameScene.swift
//  cloudStorage
//
//  Created by macOS on 1/21/22.
//

import SpriteKit

var bird:SKSpriteNode = SKSpriteNode(imageNamed: "flappyBird")
var otherBird:SKSpriteNode = SKSpriteNode(imageNamed: "holmabear")

class GameScene: SKScene {
override func didMove(to view: SKView) {

    //SETTING SIZE OF THE SPRITE TO THE SIZE OF THE TILE SIZE
    guard let mapOne = childNode(withName: "backGround") as? SKTileMapNode else {
        fatalError("Background not loaded")
    }
    //ACCESSING THE TILESIZE OF THE MAP TO SET THE BIRD TO THE SAME SIZE
    let tileSize:CGSize = mapOne.tileSize
    let birdSize:CGSize = CGSize(width: tileSize.width, height: tileSize.height)
    //SCALING THEIR SIZE
    bird.scale(to: birdSize)
    otherBird.scale(to: birdSize)

    //ADDING THEM TO THE SCENE
    addChild(bird)
    addChild(otherBird)
    
    //SETTING UP PHYSICS BODY FOR BIRD
    bird.physicsBody = SKPhysicsBody(rectangleOf: birdSize)
    bird.physicsBody?.affectedByGravity = false
    bird.physicsBody?.allowsRotation = false
    bird.physicsBody?.collisionBitMask = 0b0001
    
    //SETTING UP PHYSICS BODY FOR OTHERBIRD
    otherBird.physicsBody = SKPhysicsBody(rectangleOf: birdSize)
    otherBird.physicsBody?.affectedByGravity = false
    otherBird.physicsBody?.allowsRotation = false
    otherBird.physicsBody?.collisionBitMask = 0b0001
    
    
    //GETTING READY TO HAVE SPRITE MENU ENABLED
    bird.name = "flappyBird"
    bird.isUserInteractionEnabled = true
    


    } //func didMove()

override func update(_ currentTime: TimeInterval) {
    // Called before each frame is rendered
    }

override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    if let touch = touches.first {
        //SETTING USER TOUCH LOCATION TO VARIABLE LOCATION
        var location = touch.location(in: self)
        print(location)
        
        guard let tileMap = childNode(withName: "backGround") as? SKTileMapNode else {
            fatalError("Background not loaded")
        }
        
        let tileSize:CGSize = tileMap.tileSize
        let birdSize:CGSize = CGSize(width: tileSize.width, height: tileSize.height)

        
        let row = tileMap.tileRowIndex(fromPosition: location)
        let col = tileMap.tileColumnIndex(fromPosition: location)
        location = tileMap.centerOfTile(atColumn: col, row: row)
        print(location)
        

        //INITIALIZING ACTION
        let action:SKAction = SKAction.move(to: location, duration: 2)
        
    
        //RUNNING ACTION, AND THEN CLEARING ACTIONSTACK AFTERWARDS
        bird.run(action)
        bird.run(action,
            completion: {
            bird.removeAllActions()
            print("CLEARING STACK")
            
        //CREATING AN ARRAY THAT HOLDS ALL THE BODIES THAT ARE IN CONTACT WITH BIRD
        var bodyCount = bird.physicsBody?.allContactedBodies()
// CHECK IF ANY OF THE BODIES COME IN CONTACT WITH ANY OTHER SPRITENODES
for body in bodyCount!{
if otherBird.physicsBody?.collisionBitMask == body.node?.physicsBody?.collisionBitMask{
print("IN CONTACT")
}
    }

            }
            )
            
        }
        
    }
}

