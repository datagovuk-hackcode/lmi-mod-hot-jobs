class MainController < ApplicationController
  def search
    #this method provides the search form
  end

  def results
    #this method returns a grouped collection of jobs to the collection
    
    @results = Job.grouped_by_lat_lng "football"

    # @results = {
    #   '39.828 -104.983' => [
    #     {
    #       lat: 39.828,
    #       lon: -104.983,
    #       title: 'Teacher needed',
    #       summary: 'Please view the details below of our Primary Teacher job',
    #       company: 'CareerBuilder UK'
    #     },
    #     {
    #       lat: 39.828,
    #       lon: -104.983,
    #       title: 'Teacher Job available',
    #       summary: 'Please view the details below of our Highschool teacher job',
    #       company: 'Mr Smith Jobs'
    #     },
    #     {
    #       lat: 39.828,
    #       lon: -104.983,
    #       title: 'Teacher job',
    #       summary: 'There is a summary here',
    #       company: 'A Job search'
    #     }
    #   ],
    #   '38.710 -102.650' => [
    #     {
    #       lat: 38.710,
    #       lon: -102.650,
    #       title: 'Teacher thing',
    #       summary: 'Please view the details below of our Primary Teacher job',
    #       company: 'CareerBuilder UK'
    #     },
    #     {
    #       lat: 38.710,
    #       lon: -102.650,
    #       title: 'Teacher availability',
    #       summary: 'Please view the details below of our Highschool teacher job',
    #       company: 'Mr Smith Jobs'
    #     },
    #     {
    #       lat: 38.710,
    #       lon: -102.650,
    #       title: 'Teacher option',
    #       summary: 'There is a summary here',
    #       company: 'A Job search'
    #     }
    #   ]
    # }
  end
end
