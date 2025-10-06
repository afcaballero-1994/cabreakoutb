import Foundation

struct Vector2D {
    var x: Float
    var y: Float

    mutating func set(v: Vector2D) {
        x = v.x
        y = v.y
    }

    func clone() -> Vector2D{
        return Vector2D(x: x, y: y)
    }

    mutating func add(v: Vector2D, s: Float = 1.0) -> Vector2D{
        x += v.x * s
        y += v.y * s

        return self
    }

    mutating func substract(v: Vector2D, s: Float = 1.0) -> Vector2D{
        x -= v.x * s
        y -= v.y * s

        return self
    }

    func length() -> Float{
        return sqrt(x * x + y * y)
    }

    mutating func scale(s: Float){
        x *= s
        y *= s
    }

    func dot(v: Vector2D) -> Float{
        return x * v.x + y * v.y
    }

    static func +(l: Vector2D, r: Vector2D) -> Vector2D{
        return Vector2D(x: l.x + r.x, y: l.y + r.y)
    }

    static func -(l: Vector2D, r: Vector2D) -> Vector2D{
        return Vector2D(x: l.x - r.x, y: l.y - r.y)
    }

    
}
