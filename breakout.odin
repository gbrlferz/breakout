package breakout

import rl "vendor:raylib"

SCREEN_SIZE :: 320
PADDLE_WIDTH :: 50
PADDLE_HEIGHT :: 6
PADDLE_POS_Y :: 260
PADDLE_SPEED :: 200

paddle_pos_x: f32

restart :: proc() {
	paddle_pos_x = SCREEN_SIZE / 2 - PADDLE_WIDTH / 2
}

main :: proc() {
	rl.SetConfigFlags({.VSYNC_HINT})
	rl.InitWindow(960, 960, "Breakout")
	rl.SetTargetFPS(60)

	restart()

	for !rl.WindowShouldClose() {

		// UPDATE
		dt := rl.GetFrameTime()

		paddle_move_velocity: f32

		if rl.IsKeyDown(.LEFT) || rl.IsKeyDown(.A) {
			paddle_move_velocity -= PADDLE_SPEED
		}
		if rl.IsKeyDown(.RIGHT) || rl.IsKeyDown(.D) {
			paddle_move_velocity += PADDLE_SPEED
		}
		if rl.IsKeyPressed(.R) {
			restart()
		}

		paddle_pos_x += paddle_move_velocity * dt
		paddle_pos_x = clamp(paddle_pos_x, 0, SCREEN_SIZE - PADDLE_WIDTH)

		// DRAWING

		rl.BeginDrawing()
		rl.ClearBackground({150, 190, 220, 255})

		camera := rl.Camera2D {
			zoom = f32(rl.GetScreenHeight() / SCREEN_SIZE),
		}

		rl.BeginMode2D(camera)

		paddle_rect := rl.Rectangle {
			x      = paddle_pos_x,
			y      = PADDLE_POS_Y,
			width  = PADDLE_WIDTH,
			height = PADDLE_HEIGHT,
		}

		rl.DrawRectangleRec(paddle_rect, {50, 150, 90, 255})

		rl.EndMode2D()
		rl.EndDrawing()
	}

	rl.CloseWindow()
}
