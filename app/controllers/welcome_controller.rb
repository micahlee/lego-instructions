class WelcomeController < ApplicationController
  def index
    @latest_sets = LegoSet.order('updated_at DESC').limit(3).all
  end
end
