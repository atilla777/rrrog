module RT
  module Taylor
    class GameInputHandler
      include Event::Emitter

      MENU_ACTIONS = {
        KEY_ESCAPE => :main_menu
      }.freeze
      PLAYER_TURN_ACTIONS = {
        KEY_H => :left,
        KEY_L => :right,
        KEY_K => :up,
        KEY_J => :down,
      }.freeze
      ACTIONS_MAPPING = {
        **PLAYER_TURN_ACTIONS,
        **MENU_ACTIONS
      }.freeze

      def call(player)
        pressed_key = get_key_pressed
        action = ACTIONS_MAPPING[pressed_key]
        return unless action

        return call_menu(action) if MENU_ACTIONS.keys.include?(pressed_key)

        player_act(player, action)
      end

      private

      attr_reader :scene, :event_bus

      def player_act(player, action)
        player.action(action)

        true
      end

      def call_menu(action)
        emit :main_menu if action == :main_menu

        false
      end
    end
  end
end
