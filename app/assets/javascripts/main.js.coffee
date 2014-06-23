# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class App
  constructor: ->
    @first_lat_lon = {}
    @map_points = []
    for key, points of window.results
      @first_lat_lon = { lat: points[0].lat, lon: points[0].lng  } if @first_lat_lon = {}
      @add_point(point.lat, point.lng) for point in points
    mapOptions = {
      zoom: 13,
      center: new google.maps.LatLng(@first_lat_lon.lat, @first_lat_lon.lon),
      mapTypeId: google.maps.MapTypeId.SATELLITE
    }
    @map = new google.maps.Map(document.getElementById('map-canvas'),
      mapOptions)
    @initialize()

  add_point: (lat, lon)=>
    @map_points.push new google.maps.LatLng(lat, lon)

  initialize: =>
    console.log @map_points
    @heatmap = new google.maps.visualization.HeatmapLayer({
      data: new google.maps.MVCArray(@map_points)
    })
    @heatmap.setMap(@map)

  changeGradient: ->
    gradient = [
      'rgba(0, 255, 255, 0)',
      'rgba(0, 255, 255, 1)',
      'rgba(0, 191, 255, 1)',
      'rgba(0, 127, 255, 1)',
      'rgba(0, 63, 255, 1)',
      'rgba(0, 0, 255, 1)',
      'rgba(0, 0, 223, 1)',
      'rgba(0, 0, 191, 1)',
      'rgba(0, 0, 159, 1)',
      'rgba(0, 0, 127, 1)',
      'rgba(63, 0, 91, 1)',
      'rgba(127, 0, 63, 1)',
      'rgba(191, 0, 31, 1)',
      'rgba(255, 0, 0, 1)'
    ]
    @heatmap.set('gradient', @heatmap.get('gradient') ? null : gradient)

  changeRadius: ->
    @heatmap.set('radius', @heatmap.get('radius') ? null : 20)

  changeOpacity: ->
    @heatmap.set('opacity', @heatmap.get('opacity') ? null : 0.2)

$ ->
  if $('#display')[0]
    window.app = new App()
  else
    nlform = new NLForm document.getElementById 'nl-form'
