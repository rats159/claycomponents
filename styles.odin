package clay_components

import clay "../clay-odin"

BLACK :: clay.Color{0, 0, 0, 255}
WHITE :: clay.Color{255, 255, 255, 255}
LIGHTGRAY :: clay.Color{191, 191, 191, 255}
GRAY :: clay.Color{127, 127, 127, 255}
RED :: clay.Color{255, 0, 0, 255}

button_background_color :: proc() -> clay.Color {
	if clay.Hovered() {
		if component_context.mouse_down {
			return GRAY
		}

		return LIGHTGRAY
	}

	return WHITE
}

button_styles :: proc() -> clay.ElementDeclaration {
	return clay.ElementDeclaration {
		backgroundColor = button_background_color(),
		border = {width = {2, 2, 2, 2, 0}, color = BLACK},
		layout = {padding = clay.PaddingAll(4)},
	}
}

slider_styles :: proc() -> clay.ElementDeclaration {
	return clay.ElementDeclaration {
		layout = {
			sizing = {height = clay.SizingFixed(32), width = clay.SizingGrow({})},
			childAlignment = {y = .Center},
		},
	}
}

RADIO_SIZE :: 24

radio_outer_styles :: proc() -> clay.ElementDeclaration {
	return {
		layout = {
			sizing = {clay.SizingFixed(RADIO_SIZE), clay.SizingFixed(RADIO_SIZE)},
			childAlignment = {.Center, .Center},
		},
		cornerRadius = clay.CornerRadiusAll(RADIO_SIZE / 2),
		border = {
			width = {RADIO_SIZE / 8, RADIO_SIZE / 8, RADIO_SIZE / 8, RADIO_SIZE / 8, 0},
			color = BLACK,
		},
		backgroundColor = button_background_color(),
	}
}

radio_inner_selected_styles :: proc() -> clay.ElementDeclaration {
	return {
		layout = {sizing = {clay.SizingFixed(RADIO_SIZE / 2), clay.SizingFixed(RADIO_SIZE / 2)}},
		cornerRadius = clay.CornerRadiusAll(RADIO_SIZE / 4),
		backgroundColor = BLACK,
	}
}

radio_inner_unselected_styles :: proc() -> clay.ElementDeclaration {
	return {}
}

TOGGLEBOX_SIZE :: 24

togglebox_styles :: proc() -> clay.ElementDeclaration {
	return {
		layout = {
			sizing = {clay.SizingFixed(TOGGLEBOX_SIZE), clay.SizingFixed(TOGGLEBOX_SIZE)},
			childAlignment = {.Center, .Center},
		},
		border = {
			width = {
				TOGGLEBOX_SIZE / 8,
				TOGGLEBOX_SIZE / 8,
				TOGGLEBOX_SIZE / 8,
				TOGGLEBOX_SIZE / 8,
				0,
			},
			color = BLACK,
		},
		backgroundColor = button_background_color()
	}
}

togglebox_inner_active_styles :: proc() -> clay.ElementDeclaration {
	return {
		layout = {
			sizing = {clay.SizingFixed(TOGGLEBOX_SIZE / 2), clay.SizingFixed(TOGGLEBOX_SIZE / 2)},
		},
		backgroundColor = BLACK,
	}
}

togglebox_inner_inactive_styles :: proc() -> clay.ElementDeclaration {
	return {}
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

section_styles :: proc() -> clay.ElementDeclaration {
	return {
		border = {color = BLACK, width = {4, 4, 4, 4, 0}},
		layout = {padding = clay.PaddingAll(8), layoutDirection = .TopToBottom},
	}
}

vertical :: proc() -> clay.ElementDeclaration {
	return {layout = {layoutDirection = .TopToBottom}}
}

default_text_styles: Font

default_header_styles: Font
