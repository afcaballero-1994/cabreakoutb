// The Swift Programming Language
// https://docs.swift.org/swift-book
import Raylib


func main() {
    let screenWidth: Int32 = 800
    let screenHeight: Int32 = 450
    let backColor: Color = Color(r: 30, g: 40, b: 37, a: 255)
    let textColor: Color = Color(r: 200, g: 100, b: 40, a: 255)

    InitWindow(screenWidth, screenHeight, "Breakout")
    defer {
        CloseWindow()
    }

    SetTargetFPS(60)

    while !WindowShouldClose() {
        BeginDrawing()
        ClearBackground(backColor)
        DrawText("Congrats! You created your first window", 190, 200, 20, textColor)
        EndDrawing()
    }
}

main()
