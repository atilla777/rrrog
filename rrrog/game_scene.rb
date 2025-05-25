class GameScene < RT::Scene::Game
  attr_reader :player

  def initialize(...)
    super

    @player = Player.new(x: 10, y: 10)
    add_unit(player)
    grid.player = player

    add_unit(Enemies::Rabbit.new(x: 1, y: 1))
    add_unit(Statics::Oak.new(x: 1, y: 2))
    add_unit(Statics::Oak.new(x: 2, y: 2))
    add_unit(Enemies::Wolf.new(x: 2, y: 3))
    add_unit(Statics::Oak.new(x: 3, y: 2))
    add_unit(Enemies::Rabbit.new(x: 3, y: 4))
    add_unit(Items::Sword.new(x: 7, y: 7))
    add_unit(Statics::Oak.new(x: 8, y: 8))
    add_unit(Statics::Oak.new(x: 13, y: 12))
    add_unit(Statics::Oak.new(x: 13, y: 13))
    add_unit(Enemies::Rabbit.new(x: 18, y: 18))
    chest = Items::Chest.new(x: 19, y: 19)
    chest.item(Items::Key.new)
    add_unit(chest)
  end
end
