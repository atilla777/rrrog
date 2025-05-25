module RT
  module Unit
    class Base
      attr_reader :color, :health, :damage, :tree_damage, :items, :state

      attr_accessor :scene, :position, :new_position, :grid

      CHAR = '@'
      COLOR = nil
      PASSABLE = false
      UPDATABLE = true
      ACTIONABLE = false
      HEALTH = 1
      DAMAGE = 0
      TREE_DAMAGE = 0
      INITIAL_STATE = nil
      SOUND = nil
      SOUND2 = nil
      SOUND3 = nil

      def initialize(x: nil, y: nil)
        @position = Vector2.new(x, y) if x && y
        @new_position = Vector2.new(position.x, position.y) if x && y
        @char = self.class::CHAR
        @color = self.class::COLOR
        @passable = self.class::PASSABLE
        @actionable = self.class::ACTIONABLE
        @health = self.class::HEALTH
        @damage = self.class::DAMAGE
        @tree_damage = self.class::TREE_DAMAGE
        @items = []
        @state = self.class::INITIAL_STATE

        @sound = Sound.load(self.class::SOUND) if self.class::SOUND
        @sound2 = Sound.load(self.class::SOUND2) if self.class::SOUND2
        @sound3 = Sound.load(self.class::SOUND3) if self.class::SOUND3
      end

      def char = @char

      def action(direction)
        return unless direction

        prepare_new_position(direction)

        if grid.actionable?(new_position)
          grid.take(new_position).act(self)
          cancel_move
        else
          try_move
        end
      end

      def prepare_new_position(direction)
        case direction
        when :left then new_position.x -= 1
        when :right then new_position.x += 1
        when :up then new_position.y -= 1
        when :down then new_position.y += 1
        end
      end

      def try_move
        if grid.passable?(new_position)
          move
        else
          cancel_move
        end
      end

      def move
        grid.move(from: position, to: new_position)

        sound.play if sound
      end

      def cancel_move
        new_position.x = position.x
        new_position.y = position.y
        # block_sound
      end

      def passable? = passable

      def actionable? = actionable

      def not_passable? = !passable

      def act(actor)
        on_act(actor)
        check_health
      end

      def update
        return unless updatable?

        on_update
        action(ai.direction) if ai
      end

      def save_data
        {
          class: self.class.name,
          health: health,
          items: items.map(&:save_data)
        }.tap do |data|
          data[:position] = { x: position.x, y: position.y } if position
          data[:state] = state
        end
      end

      def item(item)
        @items << item
      end

      private

      attr_reader :passable, :actionable, :ai, :sound, :sound2, :sound3

      def updatable? = self.class::UPDATABLE

      def ai
        @ai ||= init_ai
      end

      def on_act(_); end
      def on_update; end

      def check_health
        kill if health < 1
      end

      def kill
        kill_sound
        scene.remove_unit(self)
      end

      def kill_sound; end
      def init_ai; end
    end
  end
end
