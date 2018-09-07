class LoadGamesController < ApplicationController
  require 'json'
  require 'open-uri'

  def get_new_week
    data = JSON.load(open("http://www.nfl.com/liveupdate/scores/scores.json"))
    data.each do |a, b|
      Game.create(home_team: b['home']['abbr'], away_team: b['away']['abbr'], scheduled_at: DateTime.civil_from_format :local, a.slice(0,4), a.slice(4,2), a.slice(6,2))
    end
  end

end
