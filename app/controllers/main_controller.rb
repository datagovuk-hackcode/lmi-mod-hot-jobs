class MainController < ApplicationController
  def search
    #this method provides the search form
  end

  def results
    #this method returns a grouped collection of jobs to the collection
    
    puts 'WE ARE IN RESULTS'

    if results_params[:location_from] && results_params[:location_to]
      
      puts 'we are now in the location stuff'

      @location_from = results_params[:location_from]
      @location_to = results_params[:location_to]

      @location_from_origin = Geocoder.coordinates("#{@location_from}, UK")# rescue nil
      @location_to_origin = Geocoder.coordinates("#{@location_to}, UK")# rescue nil

      puts '####################################'
      puts 'location_from_origin:'
      puts @location_from_origin.inspect
      puts 'location_to_origin:'
      puts @location_to_origin.inspect

      if !@location_from_origin.nil? && !@location_to_origin.nil?
        puts 'we are about to make the call to google'
        @response = HTTParty.get("http://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=#{@location_from_origin[0]},#{@location_from_origin[1]}&destinations=#{@location_to_origin[0]},#{@location_to_origin[1]}")
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
