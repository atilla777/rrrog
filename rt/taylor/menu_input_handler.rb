module RT
  module Taylor
    class MenuInputHandler
      def call(items)
        action = mouse_action
        mouse_position = get_mouse_position
        items.each { handle_item_input(_1, action, mouse_position) }
      end

      private

      def mouse_action
        :click if mouse_button_pressed?(MOUSE_LEFT_BUTTON)
      end

      def handle_item_input(item, action, mouse_position)
        if mouse_on_item?(item, mouse_position)
          item.focus = true
          item.act if action == :click
        else
          item.focus = false
        end
      end

      def mouse_on_item?(item, mouse_position)
        mouse_position.x.between?(item.outline_position.x, item.outline_position.x + item.outline_width) &&
          mouse_position.y.between?(item.outline_position.y + 1, item.outline_position.y + item.outline_height)
      end
    end
  end
end
