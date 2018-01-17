
require 'rest-client'

class LegoSetsController < ApplicationController
  
  def index 
    @lego_sets = LegoSet.all
  end

  def cards
    @lego_sets = LegoSet.all
  end

  def show
    @lego_set = LegoSet.find(params[:id])
  end

  def card
    @lego_set = LegoSet.find(params[:id])
  end
  
  def new
    @lego_set = LegoSet.new
  end

  def create
    @lego_set = LegoSet.new(lego_set_params)
    
    @lego_set.instructions_url = instructions_url(@lego_set.set_id)

    @lego_set.save
    redirect_to @lego_set
  end

  def destroy
    @lego_set = LegoSet.find(params[:id])
    @lego_set.destroy

    redirect_to lego_sets_path
  end

  private
    def lego_set_params
      params.require(:lego_set).permit(:set_id, :name, :thumbnail_url)
    end

    def instructions_url(set_id)
      base_url = 'http://lego.brickinstructions.com'
      clean_set_id = set_id.split('_')[0]

      search_url = "#{base_url}/search/general/send"

      # We expect a 302 here
      begin
        response = RestClient.post search_url, { set: clean_set_id.to_i }
      rescue RestClient::ExceptionWithResponse => err
        instructions_location = err.response.headers[:location]
      end

      "#{base_url}#{instructions_location}"
    end
end
