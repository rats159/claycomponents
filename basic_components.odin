package clay_components

import clay "../clay-odin"
import "core:fmt"
import "core:math"
// All components inside this file require no custom render commands

slider :: proc(value: ^$T, min: T, max: T) -> bool {
	if clay.UI()(slider_styles()) {
		id := clay.ID_LOCAL("Slider Bar")
		if clay.UI()(slider_bar_styles(id)) {}
		if clay.UI()(floating_horizontal_fill_styles()) {
			if clay.UI()(slider_spacer_styles((value^ - min) / (max - min))) {
				if clay.UI()(slider_ball_styles()) {
					if clay.Hovered() && component_context.mouse_pressed {
						bounds := clay.GetElementData(id).boundingBox
						normalized_value := (component_context.mouse_position.x - bounds.x) / bounds.width
						value^ = clamp((normalized_value + min) * (max - min),min,max)
                    }
				}
			}
		}
	}
	return false
}
