import SpriteKit

class LevelOne: Level {

    override func initLevel() {

        initSounds()

        let target = Target()
        target.position = CGPoint(x: 100, y: 500)
        target.initTarget()
        addChild(target)
        targets = [target]
        let target2 = Target()
        target2.position = CGPoint(x: 300, y: 500)
        target2.initTarget()
        addChild(target2)
        targets?.append(target2)

        let spike = Spike()
        spike.position = CGPoint(x: 350.0, y: 5.0)
        spike.initSpike()
        addChild(spike)
        spikes = [spike]
        let spike2 = Spike()
        spike2.position = CGPoint(x: 150.0, y: 5.0)
        spike2.initSpike()
        addChild(spike2)
        spikes?.append(spike2)
        let spike3 = Spike()
        spike3.position = CGPoint(x: 250.0, y: 5.0)
        spike3.initSpike()
        addChild(spike3)
        spikes?.append(spike3)

        initLeft()

        for i in 0...3 {
            let newSpike = Spike()
            newSpike.position = CGPoint(x: 54 + (100 * i), y: 731)
            newSpike.initSpike()
            newSpike.yScale = -1
            addChild(newSpike)
            spikes?.append(newSpike)
        }

        initRight()

        let goal = Goal()
        goal.position = CGPoint(x: 50.0, y: 5.0)
        goal.initGoal()
        addChild(goal)
        levelGoal = goal

        let spike24 = Spike()
        spike24.position = CGPoint(x: 200.0, y: 50.0)
        spike24.initSpike()
        spike24.yScale = -1
        spike24.zRotation = CGFloat(.pi/2.0)
        addChild(spike24)
        spikes?.append(spike24)
        let spike25 = Spike()
        spike25.position = CGPoint(x: 200.0, y: 150.0)
        spike25.initSpike()
        spike25.yScale = -1
        spike25.zRotation = CGFloat(.pi/2.0)
        addChild(spike25)
        spikes?.append(spike25)
        let spike26 = Spike()
        spike26.position = CGPoint(x: 200.0, y: 250.0)
        spike26.initSpike()
        spike26.yScale = -1
        spike26.zRotation = CGFloat(.pi/2.0)
        addChild(spike26)
        spikes?.append(spike26)

        player?.position = CGPoint(x: 300, y: 100)
    }

}
