json.extract! game, :id, :home_team, :away_team, :scheduled_at, :home_team_score, :away_team_score, :week, :season, :created_at, :updated_at
json.url game_url(game, format: :json)
