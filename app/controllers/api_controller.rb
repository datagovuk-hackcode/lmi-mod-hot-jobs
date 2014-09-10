class ApiController < ApplicationController
  def distances_by_name
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
  end

  def latlng_params
    results_params[:to_lat] && results_params[:to_lng] && results_params[:from_lat] && results_params[:from_lng]
  end

  def distances_by_latlng
    if latlng_params
      @location_from_origin = [results_params[:to_lat], results_params[:to_lng]]
      @location_to_origin = [results_params[:from_lat], results_params[:from_lng]]
      if @location_from_origin && @location_to_origin
        @response = HTTParty.get("http://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=#{@location_from_origin.lat},#{@location_from_origin.lng}&destinations=#{@location_to_origin.lat},#{@location_to_origin.lng}")
        @distance = @response["rows"][0]["elements"][0]["distance"]["text"]
        @cost = number_to_currency( ((@distance[0..-4].to_f) * 0.24), unit: '£')
        response = { distance: @distance, cost: @cost }
      else
        response = { error: 'broked' }
      end
    else
      response = { error: 'no params' }
    end
    respond_to do |format|
      format.json  { render :json, response }
    end
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

  def map
    @keyword = results_params[:keyword]
    @results = Job.grouped_by_lat_lng(@keyword)
  end

  private
  
  def results_params
    params.permit(:keyword, :location_from, :location_to)
  end

end
