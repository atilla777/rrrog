require 'rt/event/join'
require 'rt/event/bus'
require 'rt/event/emitter'
require 'rt/event/subscriber'
require 'rt/unit/pickup_mixin'
require 'rt/unit/base'
require 'rt/scene/base'
require 'rt/scene/main_menu'
require 'rt/scene/game'
require 'rt/menu/item'
require 'rt/menu/prepare_items_positions'
require 'rt/menu/renderer'
require 'rt/ascii_renderer'
require 'rt/grid'
require 'rt/ai'
require 'rt/service/save_game'
require 'rt/service/load_game'

module RT
  class Game
    include Event::Subscriber

    MUSIC = nil

    attr_accessor :current_scene, :game_scene

    attr_reader :name, :debugger, :event_bus

    on :new_game, :start_new_game
    on :main_menu, :open_main_menu
    on :save_game, :save_game
    on :load_game, :load_game

    def initialize(name:, debugger: nil)
      @name = name
      @debugger = debugger

      @event_bus = Event::Bus.new
      join_event_bus(event_bus)

      open_main_menu
    end

    def update
      event_bus.calls_events
      current_scene.update
    end

    def draw
      current_scene.draw
      debugger.render if debugger
    end

    def game_run? = !game_scene.nil?

    private

    attr_reader :event_bus

    def open_main_menu
      self.current_scene = main_menu
    end

    def main_menu = raise NotImplementedError

    def start_new_game
      self.game_scene = new_game
      self.current_scene = game_scene
    end

    def new_game = raise NotImplementedError
    def save_game = Service::SaveGame.call(self)
    def load_game = Service::LoadGame.call(self)

    def load_data(data)
      self.game_scene = new_game
      self.current_scene = game_scene

      game_scene.clear_units

      data['units'].each do |unit_data|
        unit_class = Object.const_get(unit_data['class'])
        unit = unit_class.new(x: unit_data['position']['x'], y: unit_data['position']['y'])
        unit.instance_variable_set(:@health, unit_data['health'])
        unit.instance_variable_set(:@state, unit_data['state']) if unit_data['state']

        unit_data['items'].each do |item_data|
          item_class = Object.const_get(item_data['class'])
          item = item_class.new
          item.instance_variable_set(:@health, item_data['health'])
          unit.item(item) if unit.respond_to?(:item)
        end

        game_scene.add_unit(unit)
      end

      player = game_scene.units.find { |unit| unit.is_a?(Player) }
      game_scene.instance_variable_set(:@player, player) if player
      game_scene.grid.player = player if player
    end
  end
end
