package clay_components

import clay "../clay-odin"
import rl "vendor:raylib"

main :: proc() {

	min_memory_size := clay.MinMemorySize()
	memory := make([^]u8, min_memory_size)
	arena: clay.Arena = clay.CreateArenaWithCapacityAndMemory(uint(min_memory_size), memory)
	clay.Initialize(arena, {width = 800, height = 800}, {})

	rl.InitWindow(800, 800, "Clay components demo")
	rl.SetTargetFPS(60)

	for !rl.WindowShouldClose() {
		commands := layout()
		render(&commands)
	}
}

layout :: proc() -> clay.ClayArray(clay.RenderCommand) {
	clay.SetPointerState(rl.GetMousePosition(), rl.IsMouseButtonDown(.LEFT))
	clay.SetLayoutDimensions({f32(rl.GetRenderWidth()), f32(rl.GetRenderHeight())})
	clay.BeginLayout()
	component_context.mouse_pressed = rl.IsMouseButtonDown(.LEFT)
	component_context.mouse_position = rl.GetMousePosition()

	@(static) slider_val: f32 = 0

	if clay.UI()({layout = {sizing = {width = clay.SizingFixed(600)}}}) {
		slider(&slider_val, 0, 10)
	}


	return clay.EndLayout()
}

render :: proc(commands: ^clay.ClayArray(clay.RenderCommand)) {
	rl.ClearBackground(rl.WHITE)
	rl.BeginDrawing()

	clay_raylib_render(commands)

	rl.EndDrawing()
}
