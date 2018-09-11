class ProfileController < ApplicationController
  before_action :authenticate_user!

  def index
    @pools = Pool.where(user_id: current_user.id).order(:season, week: :desc)
  end
end
