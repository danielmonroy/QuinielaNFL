require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  setup do
    @game = games(:one)
  end

  test "visiting the index" do
    visit games_url
    assert_selector "h1", text: "Games"
  end

  test "creating a Game" do
    visit games_url
    click_on "New Game"

    fill_in "Away Team", with: @game.away_team
    fill_in "Away Team Score", with: @game.away_team_score
    fill_in "Home Team", with: @game.home_team
    fill_in "Home Team Score", with: @game.home_team_score
    fill_in "Scheduled At", with: @game.scheduled_at
    fill_in "Season", with: @game.season
    fill_in "Week", with: @game.week
    click_on "Create Game"

    assert_text "Game was successfully created"
    click_on "Back"
  end

  test "updating a Game" do
    visit games_url
    click_on "Edit", match: :first

    fill_in "Away Team", with: @game.away_team
    fill_in "Away Team Score", with: @game.away_team_score
    fill_in "Home Team", with: @game.home_team
    fill_in "Home Team Score", with: @game.home_team_score
    fill_in "Scheduled At", with: @game.scheduled_at
    fill_in "Season", with: @game.season
    fill_in "Week", with: @game.week
    click_on "Update Game"

    assert_text "Game was successfully updated"
    click_on "Back"
  end

  test "destroying a Game" do
    visit games_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Game was successfully destroyed"
  end
end
