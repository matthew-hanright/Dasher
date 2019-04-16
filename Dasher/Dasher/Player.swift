import SpriteKit

class Player: SKSpriteNode {

    public var goalPoint: CGPoint?
    public let baseSpeed = 0.7
    public var isMoving = false
    public var hasMoved = false
    public var xSpeed: Float = 0.0
    public var ySpeed: Float = 0.0
    public let driftSpeed: Float = 1.0
    public var xDrift = 0.0
    public var yDrift = 0.0
    public var xDir = 0
    public var yDir = 0
    public var viewWidth = CGFloat(0)
    public var viewHeight = CGFloat(0)

    func initPlayer() {
        //Set the player's image and size
        let playerImage = SKSpriteNode(imageNamed: "player")
        addChild(playerImage)
        self.zPosition = 10
        size = playerImage.size
        //Default goalPoint, so the player doesn't move
        goalPoint = position
    }

    func update() {
        if isMoving {
            //This rotates the player towards the goal location
            let v1 = CGVector(dx: 0, dy: 1)
            let v2 = CGVector(dx: (goalPoint?.x)! - position.x, dy: (goalPoint?.y)! - position.y)
            let angle = atan2(v2.dy, v2.dx) - atan2(v1.dy, v1.dx)
            zRotation = angle
            if xDir != 0 {
                //The x speed is the percent of the total distance in the x direction, multiplied by the base speed
                let xDis = (goalPoint?.x)! - position.x
                let totDis = distance(pointA: goalPoint!, pointB: position)
                xSpeed = Float(abs(((100 * xDis) / totDis) * CGFloat(baseSpeed)))
                //Ensure the goal point is never met, to keep the player moving until collision
                goalPoint?.x += CGFloat(xSpeed * -Float(xDir))
                xSpeed *= -Float(xDir)
                position.x += CGFloat(xSpeed)
                //The player has moved at least once now
                hasMoved = true
            }
            if yDir != 0 {
                //The y speed is the percent of the total distance in the y direction, multiplied by the base speed
                let yDis = (goalPoint?.y)! - position.y
                let totDis = distance(pointA: goalPoint!, pointB: position)
                ySpeed = Float(abs(((100 * yDis) / totDis) * CGFloat(baseSpeed)))
                goalPoint?.y += CGFloat(ySpeed * -Float(yDir))
                ySpeed *= -Float(yDir)
                position.y += CGFloat(ySpeed)
                hasMoved = true
            }
            if yDir == 0 && xDir == 0 {
                isMoving = false
            }
        } else if hasMoved { //Player is no longer moving, but has moved, drift
            if xDrift == -1.0 {
                position.x += CGFloat(xSpeed / 10)
            } else if xDrift == 1.0 {
                position.x += CGFloat(xSpeed / 10)
            }
            if yDrift == -1.0 {
                position.y += CGFloat(ySpeed / 10)
            } else if yDrift == 1.0 {
                position.y -= CGFloat(ySpeed / 10)
            }
        }
    }

    func distance(pointA: CGPoint, pointB: CGPoint) -> CGFloat { //Function to find distance between two cgpoints
        let xDist = pointA.x - pointB.x
        let yDist = pointA.y - pointB.y
        return CGFloat(sqrt((xDist * xDist) + (yDist * yDist)))
    }

}
