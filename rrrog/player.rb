class Player < RT::Unit::Base
  CHAR = '@'
  COLOR = YELLOW
  HEALTH = 8
  DAMAGE = 1
  SOUND = './assets/Minifantasy_Dungeon_SFX/16_human_walk_stone_2.wav'
  SOUND2 = './assets/Minifantasy_Dungeon_SFX/11_human_damage_3.wav'
  SOUND3 = './assets/Minifantasy_Dungeon_SFX/14_human_death_spin.wav'
  UPDATABLE = false
  ACTIONABLE = true

  def update
    super

    $game.debugger.message(:health, health)
    $game.debugger.message(:items, items.map { _1.class.name }.join(' '))
  end

  private


  def on_act(actor)
    @health -= actor.damage
  end

  def play_damage
    sound2.play
  end

  def kill_sound
    sound3.play
  end
end
