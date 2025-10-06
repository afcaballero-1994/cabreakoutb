let game: Game = Game(rows: 14, columns: 6)
game.update()

defer {
    game.destroy()
}
