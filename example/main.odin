package example

import cc ".."
import clay "../../clay-odin"
import "base:runtime"
import "core:fmt"
import "core:strconv"
import rl "vendor:raylib"

err_handler :: proc "c" (data: clay.ErrorData) {
	context = runtime.default_context()
	fmt.println(data)
}

main :: proc() {
	min_memory_size := clay.MinMemorySize()
	memory := make([^]u8, min_memory_size)
	arena: clay.Arena = clay.CreateArenaWithCapacityAndMemory(uint(min_memory_size), memory)
	clay.Initialize(arena, {width = 800, height = 800}, {handler = err_handler})
	clay.SetMeasureTextFunction(measure_text, nil)

	rl.InitWindow(800, 800, "Clay components demo")
	rl.SetTargetFPS(60)

	append(&raylib_fonts, rl.LoadFontEx("./resources/NotoSans-Regular.ttf", 24, nil, 0))
	append(&raylib_fonts, rl.LoadFontEx("./resources/NotoSans-Bold.ttf", 48, nil, 0))

	cc.set_font(&cc.default_text_styles, {fontId = 0, fontSize = 24, textColor = cc.BLACK})
	cc.set_font(&cc.default_header_styles, {fontId = 1, fontSize = 48, textColor = cc.BLACK})

	for !rl.WindowShouldClose() {
		commands := layout()
		render(&commands)
		free_all(context.temp_allocator)
	}
}

slider_val: f32 = 0
radio_group := cc.Radio_Group{}
togglebox_toggled := false

count := 0

layout :: proc() -> clay.ClayArray(clay.RenderCommand) {
	clay.SetPointerState(rl.GetMousePosition(), rl.IsMouseButtonDown(.LEFT))
	cc.set_state(rl.IsMouseButtonDown(.LEFT), rl.GetMousePosition())
	clay.SetLayoutDimensions({f32(rl.GetRenderWidth()), f32(rl.GetRenderHeight())})
	clay.BeginLayout()

	if clay.UI()(
	{
		layout = {
			sizing = {clay.SizingGrow({}), clay.SizingGrow({})},
			layoutDirection = .TopToBottom,
			childGap = 4,
		},
	},
	) {
		if cc.section("Sliders!") {
			if clay.UI()({layout = {layoutDirection = .TopToBottom}}) {
				cc.horizontal_spacer(400)
				cc.slider(&slider_val, 0, 10)
				cc.label_dynamic(fmt.tprintf("%f", slider_val))
			}
		}
		if cc.section("Buttons") {
			if clay.UI()(cc.vertical()) {
				if clay.UI()({layout = {childGap = 8}}) {
					if cc.button("+1") do count += 1
					if cc.button("-1") do count -= 1
				}
				cc.label_dynamic(fmt.tprintf("Count: %d", count))
			}
		}

		if cc.section("Radio Buttons") {
			if clay.UI()({layout = {layoutDirection = .TopToBottom, childGap = 4}}) {
				cc.radio_button(&radio_group, 0)
				cc.radio_button(&radio_group, 1)
				cc.radio_button(&radio_group, 2)
				cc.radio_button(&radio_group, 3)
			}

			cc.label_dynamic(fmt.tprintf("Current: %d", radio_group.selected))
		}

		if cc.section("Toggles!") {
			if cc.togglebox(&togglebox_toggled) {
				cc.horizontal_spacer(16)
				cc.label("Toggled!")
			}
		}

	}


	return clay.EndLayout()
}

render :: proc(commands: ^clay.ClayArray(clay.RenderCommand)) {
	rl.ClearBackground(rl.WHITE)
	rl.BeginDrawing()

	clay_raylib_render(commands)

	rl.EndDrawing()
}
