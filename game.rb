# Add the path ./vendor so we can easily require third party libraries.
$: << './vendor'

set_config_flags(FLAG_WINDOW_RESIZABLE)

require 'rrrog/rrrog'

# Open up a window
init_window(640, 480, 'Rrrog!')

# Setup audio so we can play sounds
init_audio_device

# Get the current monitor frame rate and set our target framerate to match.
set_target_fps(get_monitor_refresh_rate(get_current_monitor))

$game = Rrrog.new

# Define your main method
def main
  # Get the amount of time passed since the last frame was rendered
  delta = get_frame_time

  # Your update logic goes here
  # $game.input_handle
  $game.update

  drawing do
    # Your drawing logic goes here
    $game.draw
  end

  clear(colour: BLACK)
end

if browser?
  set_main_loop 'main'
else
  # Detect window close button or ESC key
  # main until window_should_close?
  loop { main }
end

close_audio_device
close_window
