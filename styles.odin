package clay_components

import clay "../clay-odin"

Style_Set :: struct {
	border_color:      clay.Color,
	hover_color:       clay.Color,
	active_color:      clay.Color,
	base_color:        clay.Color,
	font_color:        clay.Color,
	regular_text_size: u16,
	header_text_size:  u16,
}

default_theme :: Style_Set {
	border_color      = {0, 0, 0, 255},
	hover_color       = {191, 191, 191, 255},
	active_color      = {127, 127, 127, 255},
	base_color        = {255, 255, 255, 255},
	font_color        = {0, 0, 0, 255},
	regular_text_size = 24,
	header_text_size  = 48,
}

current_theme := default_theme


button_background_color :: proc() -> clay.Color {
	if clay.Hovered() {
		if component_context.mouse_down {
			return current_theme.active_color
		}

		return current_theme.hover_color
	}

	return current_theme.base_color
}

button_styles :: proc() -> clay.ElementDeclaration {
	return clay.ElementDeclaration {
		backgroundColor = button_background_color(),
		border = {width = {2, 2, 2, 2, 0}, color = current_theme.border_color},
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
			color = current_theme.border_color,
		},
		backgroundColor = button_background_color(),
	}
}

radio_inner_selected_styles :: proc() -> clay.ElementDeclaration {
	return {
		layout = {sizing = {clay.SizingFixed(RADIO_SIZE / 2), clay.SizingFixed(RADIO_SIZE / 2)}},
		cornerRadius = clay.CornerRadiusAll(RADIO_SIZE / 4),
		backgroundColor = current_theme.border_color,
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
			color = current_theme.border_color,
		},
		backgroundColor = button_background_color(),
	}
}

togglebox_inner_active_styles :: proc() -> clay.ElementDeclaration {
	return {
		layout = {
			sizing = {clay.SizingFixed(TOGGLEBOX_SIZE / 2), clay.SizingFixed(TOGGLEBOX_SIZE / 2)},
		},
		backgroundColor = current_theme.border_color,
	}
}

togglebox_inner_inactive_styles :: proc() -> clay.ElementDeclaration {
	return {}
}

slider_bar_styles :: proc(id: clay.ElementId) -> clay.ElementDeclaration {
	return {
		id = id,
		layout = {sizing = {width = clay.SizingGrow({}), height = clay.SizingFixed(4)}},
		backgroundColor = current_theme.border_color,
	}
}

slider_ball_styles :: proc() -> clay.ElementDeclaration {
	return {
		layout = {sizing = {width = clay.SizingFixed(32), height = clay.SizingFixed(32)}},
		backgroundColor = button_background_color(),
		border = {width = {4, 4, 4, 4, 0}, color = current_theme.border_color},
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
		border = {color = current_theme.border_color, width = {4, 4, 4, 4, 0}},
		layout = {padding = clay.PaddingAll(8), layoutDirection = .TopToBottom},
	}
}

vertical :: proc() -> clay.ElementDeclaration {
	return {layout = {layoutDirection = .TopToBottom}}
}

default_text: Font
header_text: Font
