class AdminController < ApplicationController
  before_action :authenticate_user!
  require 'json'
  require 'open-uri'

  def index
    if current_user.role != 5
      redirect_to root_path
    end
  end

  def get_new_week
    week = params[:week]
    season = params[:season]
    data = JSON.load(open("http://www.nfl.com/liveupdate/scores/scores.json"))

    data.each do |a, b|
      date = DateTime.new(a.slice(0,4).to_i, a.slice(4,2).to_i, a.slice(6,2).to_i)
      home_team_id = Team.where(short_name: b['home']['abbr']).first.id
      away_team_id = Team.where(short_name: b['away']['abbr']).first.id
      Game.create(id: a.to_i, home_team: home_team_id, away_team: away_team_id,
        scheduled_at: date, home_team_score: (b['home']['score']['T']).to_i,
        away_team_score: (b['away']['score']['T']).to_i, week: week, season: season)
    end
    create_pools(week, season)
    redirect_to games_path
  end

  def create_pools(week, season)
    @users = User.all
    @users.each do |user|
      Pool.create(user_id: user.id, week: week, season: season)
    end
  end

  def count_week_points
    week = params[:week]
    season = params[:season]
    data = JSON.load(open("http://www.nfl.com/liveupdate/scores/scores.json"))
    winners_hash = who_win(data)
    @pools = Pool.where(week: week, season: season)
    @pools.each do |pool|
      points = 0
      pool.forecasts.each do |forecast|
        if(forecast.selection == winners_hash[forecast.game_id.to_s])
          points = points + 1
        end
      end
      pool.total_points = points
      pool.save
    end
    redirect_to pools_path
  end

  def who_win(data)
    data_hash = Hash.new
    data.each do |a, b|
      if((b['home']['score']['T']).to_i > (b['away']['score']['T']).to_i)
        data_hash[a] = 'home'
      elsif ((b['home']['score']['T']).to_i < (b['away']['score']['T']).to_i)
        data_hash[a] = 'away'
      else
        data_hash[a] = 'draw'
      end
    end
    return data_hash
  end

end
