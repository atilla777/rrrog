class MainMenuScene < RT::Scene::MainMenu
  item 'New game', :new_game
  item 'Save game', :save_game, show: :show_save_game?
  item 'Load game', :load_game, show: :show_load_game?
  item 'Options', :options
  item 'Exit', :exit

  private

  def show_save_game? = game.game_run?
  def show_load_game? = File.exist?("./saves/save.json")
end
