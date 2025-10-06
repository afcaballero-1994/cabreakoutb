import Raylib

protocol Entity {
    var pos: Vector2D {get}
    var w: Int32 {get}
    var h: Int32 {get}
}

struct Paddel: Entity{
    var pos: Vector2D
    let w: Int32
    let h: Int32
    var color: Color

    func draw(){
        DrawRectangle(
          Int32(pos.x), Int32(pos.y), w, h, color,
        )
    }
}

struct Player: Entity{
    var pos: Vector2D
    let w: Int32
    let h: Int32
    let color: Color
    let acceleration: Float
    var vel: Vector2D

    func draw(){
        DrawRectangle(
          Int32(pos.x), Int32(pos.y), w, h, color
        )
    }
}

struct Ball{
    var pos: Vector2D
    let radius: Float
    var color: Color
    var vel: Vector2D

    func draw(){
        DrawCircle(Int32(pos.x), Int32(pos.y), radius, color)
    }

    mutating func simulate(dt: Float, gravity: Vector2D){
        vel = vel.add(v: gravity, s: dt)
        pos = pos.add(v: vel, s: dt)
    }

    mutating func handleWallCollision(w: Float, h: Float) {
        if pos.x < radius{
            pos.x = radius
            vel.x = -vel.x
        }
        if pos.x > w - radius{
            pos.x = w - radius
        }

        if pos.y < radius {
            pos.y = radius
            vel.y = -vel.y
        }
    }

    mutating func handleCollision(r: Entity) {
        if !checkCollision(r: r){
            return
        }
    }

    func checkCollision(r: Entity) -> Bool{

        var collision = false

        let recCenterX: Float = r.pos.x + Float(r.w/2)
        let recCenterY: Float = r.pos.y + Float(r.h/2)

        let dx: Float = abs(pos.x - recCenterX)
        let dy: Float = abs(pos.y - recCenterY)

        if dx > Float(r.w / 2) + radius {
            return false
        }
        if dy > Float(r.h / 2) + radius {
            return false
        }

        if dx <= Float(r.w / 2){
            return true
        }
        if dy <= Float(r.h / 2){
            return true
        }

        let dx1 = dx - Float(r.w/2)
        let dy1 = dy - Float(r.h/2)
        let cordis: Float = dx1 * dx1 + dy1 * dy1

        collision = cordis <= radius * radius
        return collision
    }
}

