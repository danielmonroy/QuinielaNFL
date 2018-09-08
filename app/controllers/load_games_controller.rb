class LoadGamesController < ApplicationController
  require 'json'
  require 'open-uri'

  def get_new_week
    week = params[:week]
    season = params[:season]
    data = JSON.load(open("http://www.nfl.com/liveupdate/scores/scores.json"))

    data.each do |a, b|
      date = DateTime.new(a.slice(0,4).to_i, a.slice(4,2).to_i, a.slice(6,2).to_i)
      home_team_id = Team.where(short_name: b['home']['abbr']).first.id
      away_team_id = Team.where(short_name: b['away']['abbr']).first.id
=begin
      puts "Juego: " + b['away']['abbr'] + " vs " + b['home']['abbr']
      #puts "Fecha: " + a.slice(0,4) + "-" + a.slice(4,2) + "-" + a.slice(6,2)
      puts "Fecha: " + date.strftime("%B %d, %Y, %A")
      if (b['qtr'] == 'Final')
        puts "Score: " + b['away']['score']['T'].to_s + " - " + b['home']['score']['T'].to_s
        if ((b['away']['score']['T']).to_i > (b['home']['score']['T']).to_i)
          puts b['away']['abbr'] + " WIN!!"
        elsif ((b['away']['score']['T']).to_i < (b['home']['score']['T']).to_i)
          puts b['home']['abbr'] + " WIN!!"
        else
          puts "It's a DRAW!"
        end
      end
=end
      Game.create(id: a.to_i, home_team: home_team_id, away_team: away_team_id,
        scheduled_at: date, home_team_score: (b['home']['score']['T']).to_i,
        away_team_score: (b['away']['score']['T']).to_i, week: week, season: season)
    end
    redirect_to games_path
  end

end
