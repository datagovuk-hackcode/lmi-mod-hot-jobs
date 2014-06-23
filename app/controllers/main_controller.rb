class MainController < ApplicationController
  def search
    #this method provides the search form
  end

  def results
    #this method returns a grouped collection of jobs to the collection
    
    if results_params[:location_from] && results_params[:location_to]
      
      @location_from = results_params[:location_from]
      @location_to = results_params[:location_to]

      @location_from_origin = Job.geocode("#{@location_from}, UK") rescue nil
      @location_to_origin = Job.geocode("#{@location_to}, UK") rescue nil

      if @location_from_origin && @location_to_origin
        @response = HTTParty.get("http://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=#{@location_from_origin.lat},#{@location_from_origin.lng}&destinations=#{@location_to_origin.lat},#{@location_to_origin.lng}")
        @distance = @response["rows"][0]["elements"][0]["distance"]["text"]
      end

    end

    @keyword = results_params[:keyword]
    @results = Job.grouped_by_lat_lng(@keyword)

  end

  private
  
  def results_params
    params.permit(:keyword, :location_from, :location_to)
  end

end
