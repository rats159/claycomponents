package clay_components

import clay "../clay-odin"

BLACK :: clay.Color{0, 0, 0, 255}
WHITE :: clay.Color{255, 255, 255, 255}
LIGHTGRAY :: clay.Color{191, 191, 191, 255}
GRAY :: clay.Color{127, 127, 127, 255}
RED :: clay.Color{255, 0, 0, 255}

button_background_color :: proc() -> clay.Color {
	if clay.Hovered() {
		if component_context.mouse_pressed {
			return GRAY
		}

		return LIGHTGRAY
	}

	return WHITE
}

slider_styles :: proc() -> clay.ElementDeclaration {
	return clay.ElementDeclaration {
		layout = {
			sizing = {height = clay.SizingFixed(32), width = clay.SizingGrow({})},
			childAlignment = {y = .Center},
		},
	}
}

slider_bar_styles :: proc(id: clay.ElementId) -> clay.ElementDeclaration {
	return {
		id = id,
		layout = {sizing = {width = clay.SizingGrow({}), height = clay.SizingFixed(4)}},
		backgroundColor = BLACK,
	}
}

slider_ball_styles :: proc() -> clay.ElementDeclaration {
	return {
		layout = {sizing = {width = clay.SizingFixed(32), height = clay.SizingFixed(32)}},
		backgroundColor = button_background_color(),
		border = {width = {4, 4, 4, 4, 0}, color = BLACK},
		floating = {
			attachTo = .Parent,
			attachment = {element = .CenterCenter, parent = .RightCenter},
		},
		cornerRadius = clay.CornerRadiusAll(16),
	}
}

slider_spacer_styles :: proc(value_percentage: f32) -> clay.ElementDeclaration {
	return {layout = {sizing = {width = clay.SizingPercent(value_percentage)}}}
}

floating_horizontal_fill_styles :: proc() -> clay.ElementDeclaration {
	return {
		floating = {attachTo = .Parent},
		layout = {
			sizing = {width = clay.SizingGrow({}), height = clay.SizingFixed(32)},
			childAlignment = {y = .Center},
		},
	}
}
