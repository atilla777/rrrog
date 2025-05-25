require 'rt/game'

require 'rt/taylor/debugger'
require 'rt/taylor/font'
require 'rt/taylor/game_input_handler'
require 'rt/taylor/menu_input_handler'
require 'rt/taylor/music_player'

require 'rrrog/player'
require 'rrrog/main_menu_scene'
require 'rrrog/game_scene'
require 'rrrog/enemies/wolf'
require 'rrrog/enemies/rabbit'
require 'rrrog/statics/oak'
require 'rrrog/items/key'
require 'rrrog/items/sword'
require 'rrrog/items/chest'

class Rrrog < RT::Game
  NAME = 'Rrrog!'

  RENDERER_CLASS = RT::ASCIIRenderer
  GAME_INPUT_HANDLER_CLASS = RT::Taylor::GameInputHandler
  MENU_INPUT_HANDLER_CLASS = RT::Taylor::MenuInputHandler
  MENU_RENDERER_CLASS = RT::Menu::Renderer
  DEBUGGER_CLASS = RT::Taylor::Debugger

  FONT_CLASS = RT::Taylor::Font
  # FONT_PATH = './assets/square.ttf'
  FONT_PATH = './assets/Kitchen Sink v1.2/Kitchen Sink.ttf'
  FONT_SIZE = 24

  MUSIC_PLAYER_CLASS = RT::Taylor::MusicPLayer
  MUSIC_FILE = './assets/Minifantasy_Dungeon_Music/Goblins_Den_(Regular).mp3'

  WINDOW_WIDTH = 640
  WINDOW_HEIGHT = 480

  def initialize
    super(name: NAME, debugger: game_debugger)
  end

  private

  def game_input_handler = GAME_INPUT_HANDLER_CLASS.new
  def menu_input_handler = MENU_INPUT_HANDLER_CLASS.new
  def game_renderer = RENDERER_CLASS.new(font:, font_size: FONT_SIZE)
  def main_menu_music_player = MUSIC_PLAYER_CLASS.new(MUSIC_FILE)
  def game_debugger = DEBUGGER_CLASS.new

  def menu_renderer
    MENU_RENDERER_CLASS.new(font:, font_size: FONT_SIZE, screen_width: WINDOW_WIDTH, screen_height: WINDOW_HEIGHT)
  end

  def font
    @font ||= FONT_CLASS.new(FONT_PATH)
  end

  def main_menu
    MainMenuScene.new(
      game: self, renderer: menu_renderer, input_handler: menu_input_handler, music_player: main_menu_music_player
    )
  end

  def new_game = GameScene.new(game: self, renderer: game_renderer, input_handler: game_input_handler)
end
