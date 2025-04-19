package breakout

import rl "vendor:raylib"

main :: proc() {
	rl.SetConfigFlags({.VSYNC_HINT})
	rl.InitWindow(720, 720, "Breakout")
	rl.SetTargetFPS(60)

	for !rl.WindowShouldClose() {
		rl.BeginDrawing()
		rl.ClearBackground({150, 190, 220, 255})
		rl.EndDrawing()
	}

	rl.CloseWindow()
}
