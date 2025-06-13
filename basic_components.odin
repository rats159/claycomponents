package clay_components

import clay "../clay-odin"
import "core:fmt"
import "core:math"
// All components inside this file require no custom render commands

slider :: proc(value: ^$T, min: T, max: T) {
	if clay.UI()(slider_styles()) {
		id := clay.ID_LOCAL("Slider Bar")
		if clay.UI()(slider_bar_styles(id)) {}
		if clay.UI()(floating_horizontal_fill_styles()) {
			bar_hovered := clay.Hovered()
			if clay.UI()(slider_spacer_styles((value^ - min) / (max - min))) {
				if clay.UI()(slider_ball_styles()) {
					if bar_hovered && component_context.mouse_pressed {
						bounds := clay.GetElementData(id).boundingBox
						normalized_value :=
							(component_context.mouse_position.x - bounds.x) / bounds.width
						value^ = clamp((normalized_value + min) * (max - min), min, max)
					}
					if clay.Hovered() && component_context.mouse_down {
						bounds := clay.GetElementData(id).boundingBox
						normalized_value :=
							(component_context.mouse_position.x - bounds.x) / bounds.width
						value^ = clamp((normalized_value + min) * (max - min), min, max)
					}
				}
			}
		}
	}
}

button :: proc(name: string, loc := #caller_location) -> bool {
	if clay.UI()(button_styles()) {
		label_dynamic(name, loc)
		if clay.Hovered() && component_context.mouse_pressed {
			return true
		}
	}
	return false
}

radio_button :: proc(group: ^Radio_Group, index: u8) -> bool {
	if clay.UI()(radio_outer_styles()) {
		if group.selected == index {
			if clay.UI()(radio_inner_selected_styles()) {}
		} else {
			if clay.UI()(radio_inner_unselected_styles()) {}
		}

		if clay.Hovered() && component_context.mouse_pressed {
			if group.selected != index {
				group.selected = index
				return true
			}
			group.selected = index
		}
	}

	return false
}

label :: proc($text: string, loc := #caller_location) {
	if !default_text.initialized {
		panic("Default font not initialized!", loc)
	}
	clay.Text(
		text,
		clay.TextConfig(
			{
				fontId = default_text.id,
				textColor = current_theme.font_color,
				fontSize = current_theme.regular_text_size,
			},
		),
	)
}

label_dynamic :: proc(text: string, loc := #caller_location) {
	if !default_text.initialized {
		panic("Default font not initialized!", loc)
	}
	clay.TextDynamic(
		text,
		clay.TextConfig(
			{
				fontId = default_text.id,
				textColor = current_theme.font_color,
				fontSize = current_theme.regular_text_size,
			},
		),
	)
}

header :: proc($text: string) {
	if !header_text.initialized {
		panic("Header font not initialized!", loc)
	}
	clay.Text(
		text,
		clay.TextConfig(
			{
				fontId = header_text.id,
				textColor = current_theme.font_color,
				fontSize = current_theme.header_text_size,
			},
		),
	)
}

header_dynamic :: proc(text: string, loc := #caller_location) {
	if !header_text.initialized {
		panic("Header font not initialized!", loc)
	}
	clay.TextDynamic(
		text,
		clay.TextConfig(
			{
				fontId = header_text.id,
				textColor = current_theme.font_color,
				fontSize = current_theme.header_text_size,
			},
		),
	)
}

togglebox :: proc(active: ^bool) -> bool {
	if clay.UI()(togglebox_styles()) {
		if active^ {
			if clay.UI()(togglebox_inner_active_styles()) {}
		} else {
			if clay.UI()(togglebox_inner_inactive_styles()) {}
		}

		if clay.Hovered() && component_context.mouse_pressed {
			active^ = !active^
		}
	}
	return active^
}

@(private = "file")
double_close :: proc() {
	clay._CloseElement()
	clay._CloseElement()
}

// Technically this uses the private API, but it's in the bindings so I say it's fair game.
@(deferred_none = double_close)
section :: proc(text: string, loc := #caller_location) -> bool {
	clay._OpenElement()
	clay.ConfigureOpenElement(section_styles())
	header_dynamic(text, loc)
	clay._OpenElement()
	clay.ConfigureOpenElement({})
	return true
}

horizontal_fill :: proc() {
	if clay.UI()({layout = {sizing = {width = clay.SizingGrow({})}}}) {

	}
}

horizontal_spacer :: proc(width: f32) {
	if clay.UI()({layout = {sizing = {width = clay.SizingFixed(width)}}}) {}
}
