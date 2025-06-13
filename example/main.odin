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

	cc.set_font(&cc.default_text, 0)
	cc.set_font(&cc.header_text, 1)

	for !rl.WindowShouldClose() {
		commands := layout()
		render(&commands)
		free_all(context.temp_allocator)
	}
}

DARK := cc.Style_Set {
	active_color      = {191, 191, 191, 255},
	base_color        = {31, 31, 31, 255},
	border_color      = {127, 127, 127, 255},
	hover_color       = {63, 63, 63, 255},
	font_color        = {192, 192, 192, 255},
	header_text_size  = 48,
	regular_text_size = 24,
}

RED := cc.Style_Set {
	active_color      = {239, 189, 189, 255},
	base_color        = {160, 62, 62, 255},
	border_color      = {73, 36, 36, 255},
	hover_color       = {183, 100, 100, 255},
	font_color        = {249, 164, 164, 255},
	header_text_size  = 48,
	regular_text_size = 24,
}

PINKYPURPLEY := cc.Style_Set {
	active_color      = {226, 189, 239, 255},
	base_color        = {112, 10, 81, 255},
	border_color      = {40, 1, 29, 255},
	hover_color       = {167, 53, 173, 255},
	font_color        = {246, 179, 249, 255},
	header_text_size  = 48,
	regular_text_size = 24,
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
		backgroundColor = cc.current_theme.base_color,
	},
	) {
		if cc.section("Sliders!") {
			if clay.UI()({layout = {layoutDirection = .TopToBottom}}) {
				cc.horizontal_spacer(400)
				cc.slider(&slider_val, 0, 1)
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
				theme_button(&radio_group, 0, "Light Theme")
				theme_button(&radio_group, 1, "Dark Theme")
				theme_button(&radio_group, 2, "Red Theme")
				theme_button(&radio_group, 3, "Pinkypurpley Theme")
			}
		}

		if cc.section("Toggles!") {
			if cc.togglebox(&togglebox_toggled) {
				cc.horizontal_spacer(16)
				cc.label("Toggled!")
			}
		}

		if cc.section("Theme Overrides") {
			if clay.UI()({layout = {childGap = 8}}) {
				current_theme := cc.current_theme
				set_theme(0)
				cc.button("Always light!")
				set_theme(1)
				cc.button("Always dark!")
				set_theme(2)
				cc.button("Always red!")
				set_theme(3)
				cc.button("Always pink!")
				cc.current_theme = current_theme
			}
		}

	}


	return clay.EndLayout()
}

set_theme :: proc(index: u8) {
	switch index {
	case 0:
		cc.current_theme = &cc.default_theme
	case 1:
		cc.current_theme = &DARK
	case 2:
		cc.current_theme = &RED
	case 3:
		cc.current_theme = &PINKYPURPLEY
	}
}

theme_button :: proc(group: ^cc.Radio_Group, index: u8, label: string) {
	if clay.UI()({}) {
		current_theme := cc.current_theme
		set_theme(index)
		switched := cc.radio_button(group, index)
		cc.label_dynamic(label)

		if !switched {
			cc.current_theme = current_theme
		}
	}
}

render :: proc(commands: ^clay.ClayArray(clay.RenderCommand)) {
	rl.ClearBackground(rl.WHITE)
	rl.BeginDrawing()

	clay_raylib_render(commands)

	rl.EndDrawing()
}
