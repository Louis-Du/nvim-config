require('smear_cursor').setup({
  -- Fire hazard style
  cursor_color = "#ff6600",  -- Color naranja/rojo intenso
  smear = {
    enabled = true,
    color = "#ff6600",
    amount = 5,
  },
  stiffness = 0.8,
  trailing_distance = 0.5,
  distance_stop_animating = 0.1,
  max_sliding_duration = 0.3,
  min_movement_distance = 0.1,
})
