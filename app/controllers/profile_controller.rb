class ProfileController < ApplicationController
  before_action :authenticate_user!

  def index
    @pools = Pool.where(user_id: current_user.id).order(:season, week: :desc)
    @players = User.all
    total_points = 0
    @pools.each do |p|
      total_points = total_points + p.total_points.to_i
    end
    @total_points = total_points
  end
end
