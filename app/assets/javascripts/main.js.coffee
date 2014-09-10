# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

window.map_styles =[
  {
    "stylers": [
      { "saturation": -43 }
    ]
  }
]

class App
  constructor: ->
    console.log 'we are in constructor'
    @first_lat_lon = {}
    @map_points = []
    @markers = []
    mapOptions = {
      zoom: 6,
      mapTypeId: google.maps.MapTypeId.ROADMAP,
      styles: window.map_styles
    }
    @map = new google.maps.Map(document.getElementById('map-canvas'),
      mapOptions)
    for key, points of window.results
      @first_lat_lon = { lat: points[0].lat, lon: points[0].lng  } if @first_lat_lon = {}
      for point in points
        @add_point(point.lat, point.lng)
        @add_marker(point.lat, point.lng, point.title)
    @map.setCenter new google.maps.LatLng @first_lat_lon.lat, @first_lat_lon.lon
    @initialize()
    @draw_line()
    @hidden = true
    for marker in @markers
      marker.setVisible false
    $('.toggle').click (event)=>
      event.preventDefault()
      if @hidden
        for marker in @markers
          marker.setVisible true
        @hidden = false
      else
        for marker in @markers
          marker.setVisible false
        @hidden = true


  add_marker: (lat, lon, title)=>
    m = new google.maps.Marker({
      map: @map
      position: new google.maps.LatLng(lat, lon) 
      title:title
      icon: 'https://dl.dropboxusercontent.com/u/29482823/lmi_pin.png'
    })
    google.maps.event.addListener m, 'click', =>
      @get_crime(lat, lon)
    @markers.push m

  build_crime_url: (lat, lon)=>
    $.getJSON "/api/crime_ll.json?lat=#{lat}&lng=#{lon}", (data)=>
      $('#popup').hide()
      html = "<table>"
      html += "<tr><th>crime type</th><th>count</th></tr>"
      for type of data.types
        content = true
        html += "<tr><td>#{type}</td><td>#{data.types[type]}</td>"
      html += "</table>"
      $('#popup').html(html).slideDown() if content

  get_crime: (lat, lon)=>
    @build_crime_url lat, lon

  draw_line: =>
    if window.location_to
      lines = [
        new google.maps.LatLng(location_to.lat, location_to.lng),
        new google.maps.LatLng(location_from.lat, location_from.lng)
      ]
      poly = new google.maps.Polyline({ map: @map, path: lines, strokeColor: '#4986E7' })

  add_point: (lat, lon)=>
    @map_points.push new google.maps.LatLng(lat, lon)

  initialize: =>
    console.log 'we are in initialize'
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

ready = ->
  if $('#map-canvas')[0]
    window.app = new App()
  if $('#nl-form')[0]
    nlform = new NLForm document.getElementById 'nl-form'
$(document).ready(ready)
$(document).on('page:load', ready)
