class WelcomeController < ApplicationController
  def index
    @latest_sets = current_user.lego_sets.order('updated_at DESC').limit(3).all
  end
end
