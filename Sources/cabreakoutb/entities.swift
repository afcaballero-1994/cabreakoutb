import Raylib

protocol Entity {
    var pos: Vector2D { get set }
    var vel: Vector2D { get set }
    var mass: Float { get set }
    var isAlive: Bool { get set }
    var isPlayer: Bool { get }
    var w: Int32 { get }
    var h: Int32 { get }
}

struct Paddel: Entity {
    var pos: Vector2D
    var vel: Vector2D
    var mass: Float
    var isAlive: Bool = true
    let isPlayer: Bool = false
    let w: Int32
    let h: Int32
    var color: Color

    func draw() {
        DrawRectangle(
            Int32(pos.x), Int32(pos.y), w, h, color,
        )
    }
}

struct Player: Entity {
    var pos: Vector2D
    var isAlive: Bool = true
    let isPlayer: Bool = true
    var mass: Float
    let w: Int32
    let h: Int32
    let color: Color
    let acceleration: Float
    var vel: Vector2D

    func draw() {
        DrawRectangle(
            Int32(pos.x), Int32(pos.y), w, h, color
        )
    }

}

struct Ball {
    var pos: Vector2D
    let radius: Float
    var mass: Float
    var color: Color
    var vel: Vector2D

    func draw() {
        DrawCircle(Int32(pos.x), Int32(pos.y), radius, color)
    }

    mutating func simulate(dt: Float, gravity: Vector2D) {
        pos = pos.add(v: vel, s: dt)
    }

    mutating func handleWallCollision(w: Float, h: Float) {
        if pos.x < radius {
            pos.x = radius
            vel.x = -vel.x
        }
        if pos.x > w - radius {
            pos.x = w - radius
            vel.x = -vel.x
        }

        if pos.y < radius {
            pos.y = radius
            vel.y = -vel.y
        }

        if pos.y > h - radius {
            pos.y = h - radius
            vel.y = -vel.y
        }
    }

    mutating func handleCollision<T: Entity>(r: inout T, restitution: Float = 1.0) {
        if !checkCollision(r: r) {
            return
        }
        //let cr = Vector2D(x: Float(r.w) / 2 + r.pos.x + pos.x,
        //                  y: Float(r.h) / 2 + r.pos.y + pos.y)
        //
        //var dir: Vector2D = cr - pos
        //let d: Float = dir.length()
        //
        //dir.scale(s: 1.0 / d)
        //
        //let v1: Float = vel.dot(v: dir)
        //let v2: Float = r.vel.dot(v: dir)
        //
        //let m1: Float = mass
        //let m2: Float = r.mass
        //
        //let newV = (m1 * v1 + m2 * v2 - m2 * (v1 - v2) * restitution) / (m1 + m2)
        //vel = vel.add(v: dir, s: newV - v1)

        vel.y = -vel.y
        if r.isAlive && !r.isPlayer {
            r.isAlive = false
            vel.scale(s: 1.007)
        }
    }

    func checkCollision<T: Entity>(r: T) -> Bool {
        if r.isAlive == false {
            return false
        }

        var collision = false

        let recCenterX: Float = r.pos.x + Float(r.w / 2)
        let recCenterY: Float = r.pos.y + Float(r.h / 2)

        let dx: Float = abs(pos.x - recCenterX)
        let dy: Float = abs(pos.y - recCenterY)

        if dx > Float(r.w / 2) + radius {
            return false
        }
        if dy > Float(r.h / 2) + radius {
            return false
        }

        if dx <= Float(r.w / 2) {
            return true
        }
        if dy <= Float(r.h / 2) {
            return true
        }

        let dx1 = dx - Float(r.w / 2)
        let dy1 = dy - Float(r.h / 2)
        let cordis: Float = dx1 * dx1 + dy1 * dy1

        collision = cordis <= radius * radius
        return collision
    }
}
