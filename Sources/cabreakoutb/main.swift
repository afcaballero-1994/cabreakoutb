var game: Game = Game(rows: 14, columns: 6)

game.run()

defer {
    game.destroy()
}
