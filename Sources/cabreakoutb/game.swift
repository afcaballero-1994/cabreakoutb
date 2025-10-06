import Raylib

struct Game{
    var rows: Int32
    var columns: Int32
    var level:[Paddel]

    init(rows: Int32, columns: Int32) {
        self.rows = rows
        self.columns = columns
        InitWindow(100 * rows, 50 * columns * 4, "Hello")
        level = Array<Paddel>()
        generateLevel()
        SetTargetFPS(60)
    }

    func draw(){
        for e in level{
            e.draw()
        }
    }

    func update() {
        while !WindowShouldClose(){
            BeginDrawing()
            ClearBackground(Color(r: 200, g: 30, b: 60, a: 255))
            let dt = GetFrameTime()
            DrawText("\(dt)", 0, 0, 22, Color(r: 0, g: 29, b: 60, a: 255))
            draw()
            EndDrawing()
        }
    }
    
    mutating func generateLevel(){
        level.reserveCapacity(Int(rows * columns))
        let width: Int32 = 100
        let height: Int32 = 50
        for row in 0..<rows{
            for column in 0..<columns{
                level.append(Paddel(pos: Vector2D(x: Float(row * width),
                                                  y: Float(column * height)),
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
