import Raylib

struct Game {
    var rows: Int32
    var columns: Int32
    var level: [Paddel]
    var player: Player
    var ball: Ball
    var scrw: Int32
    var scrh: Int32
    var pw: Int32
    var ph: Int32
    var isPlaying: Bool = true
    let gravity: Vector2D

    init(
        rows: Int32, columns: Int32, pw: Int32 = 100, ph: Int32 = 50,
        gravity: Vector2D = Vector2D(x: 0, y: 0)
    ) {
        self.pw = pw
        self.ph = ph
        self.gravity = gravity
        self.rows = rows
        self.columns = columns
        scrw = pw * rows
        scrh = ph * columns * 4
        InitWindow(scrw, scrh, "Hello")
        player = Player(
            pos: Vector2D(x: Float(scrw / 2), y: Float(scrh / 2) + 200),
            mass: 200, w: 200, h: 50, color: Color(r: 38, g: 39, b: 100, a: 255),
            acceleration: 30, vel: Vector2D(x: 10, y: 10),
        )
        ball = Ball(
            pos: Vector2D(x: Float(scrw / 2), y: Float(scrh / 2)),
            radius: 50, mass: 5, color: Color(r: 29, g: 30, b: 24, a: 255),
            vel: Vector2D(x: 220, y: -300),
        )
        level = [Paddel]()
        generateLevel()
        SetTargetFPS(60)
    }

    func draw() {
        ClearBackground(Color(r: 200, g: 30, b: 60, a: 255))
        let dt = GetFrameTime()
        DrawText("\(dt)", 0, 0, 22, Color(r: 0, g: 29, b: 60, a: 255))
        for e in level {
            if e.isAlive {
                e.draw()
            }
        }
        player.draw()
        ball.draw()
    }

    mutating func update(dt: Float) {
        if isPlaying {
            simulate(dt: dt, gravity: gravity)
        }

    }

    mutating func run() {
        while !WindowShouldClose() {
            BeginDrawing()
            let dt = GetFrameTime()
            update(dt: dt)
            inputHandling()
            draw()
            EndDrawing()
        }
    }
    mutating func inputHandling() {
        if IsKeyDown(Int32(KEY_A.rawValue)) {
            player.pos.x -= 20
        }

        if IsKeyDown(Int32(KEY_F.rawValue)) {
            player.pos.x += 20
        }
        if IsKeyDown(Int32(KEY_S.rawValue)) {
            isPlaying = !isPlaying
        }
        if player.pos.x < 0 {
            player.pos.x = 0
        }

        if player.pos.x + Float(player.w) > Float(scrw) {
            player.pos.x = Float(scrw - player.w)
        }
    }

    mutating func simulate(dt: Float, gravity: Vector2D) {
        ball.simulate(dt: dt, gravity: gravity)
        for (i, _) in level.enumerated() {
            ball.handleCollision(r: &level[i])
        }
        ball.handleCollision(r: &player)
        ball.handleWallCollision(w: Float(scrw), h: Float(scrh))
    }

    mutating func generateLevel() {
        level.reserveCapacity(Int(rows * columns))
        let width: Int32 = 100
        let height: Int32 = 50
        for row in 0..<rows {
            for column in 0..<columns {
                level.append(
                    Paddel(
                        pos: Vector2D(
                            x: Float(row * width),
                            y: Float(50 + column * height)),
                        vel: Vector2D(x: 20, y: 20), mass: 500,
                        w: width - 2, h: height - 2,
                        color: Color(r: 140, g: 10, b: 50, a: 255)
                    ))
            }
        }
    }

    func destroy() {
        CloseWindow()
    }
}
