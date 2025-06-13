package clay_components

import clay "../clay-odin"

Component_Context :: struct {
	mouse_down:     bool, // Left mouse button is held down
	mouse_pressed:  bool, // Left mouse button was pressed this frame
	mouse_released: bool, // Left mouse button was released this frame
	mouse_position: [2]f32,
}

Font :: struct {
	id:          u16,
	initialized: bool,
}

Radio_Group :: struct {
	selected: u8,
}

component_context := Component_Context{}

set_state :: proc(pointer_down: bool, pointer_pos: [2]f32) {
	component_context.mouse_position = pointer_pos

	component_context.mouse_pressed = pointer_down && !component_context.mouse_down
	component_context.mouse_released = !pointer_down && component_context.mouse_down

	component_context.mouse_down = pointer_down
}

set_font :: proc(font: ^Font, id: u16) {
	font.initialized = true
	font.id = id
}
