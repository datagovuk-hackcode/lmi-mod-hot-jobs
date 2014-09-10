class PropertyValues
  include Virtus::Model
  extend ActiveModel::Model
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attribute :average_sold_price_7year, Float
  attribute :street, String
  attribute :town, String
  attribute :number_of_sales_5year, Float
  attribute :average_sold_price_1year, Float
  attribute :number_of_sales_1year, Float
  attribute :latitude, Float
  attribute :prices_url, String
  attribute :postcode, String
  attribute :average_sold_price_5year, Float
  attribute :country, String
  attribute :longitude, Float
  attribute :number_of_sales_7year, Float
  attribute :area_name, Float
  attribute :number_of_sales_3year, Float
  attribute :turnover, Float
  attribute :average_sold_price_3year, Float
  attribute :county, String
  attribute :longitude_min, Float
  attribute :latitude_min, Float
  attribute :longitude_max, Float
  attribute :latitude_max, Float

  def initialize(lat, lng)
    res = Geokit::Geocoders::GoogleGeocoder.reverse_geocode("#{lat}, lng",[{}])
    res.inspect
  end

  def get_zoopla_data(postcode_area)
    # get a postcode area from the loaction value
    # make a call to Zoopla for the postcode area
    response = HTTParty.get("http://api.zoopla.co.uk/api/v1/average_area_sold_price.js?area=#{postcode_area}&api_key#{ENV['ZOOPLA_API_KEY']}")

    puts response.inspect
    # assign values to properties
  end

end


# average_sold_price_7year: "176823"
# street: ""
# town: ""
# number_of_sales_5year: "2724"
# average_sold_price_1year: "181621"
# number_of_sales_1year: "571"
# latitude: 52.062877
# prices_url: "http://www.zoopla.co.uk/home-values/ip4"
# postcode: "IP4"
# average_sold_price_5year: "178089"
# country: "England"
# longitude: 1.18754
# number_of_sales_7year: "3770"
# area_name: " IP4"
# number_of_sales_3year: "1641"
# turnover: "14.8"
# average_sold_price_3year: "181364"
# county: "Suffolk"
# bounding_box: {
# longitude_min: "1.14673"
# latitude_min: "52.047077"
# longitude_max: "1.22835"
# latitude_max: "52.078677"
# }-
# }