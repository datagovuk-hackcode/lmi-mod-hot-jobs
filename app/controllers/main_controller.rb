class MainController < ApplicationController
  def search
    #this method provides the search form
  end

  def results
    #this method returns a grouped collection of jobs to the collection
    
    @keyword = results_params[:keyword]
    @location_from = results_params[:location_from]
    @location_to = results_params[:location_to]
    @results = Job.grouped_by_lat_lng(@keyword)

  end

  private
  
  def results_params
    params.permit(:keyword, :location_from, :location_to)
  end

end
