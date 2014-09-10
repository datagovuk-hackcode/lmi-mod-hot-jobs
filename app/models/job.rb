class Job < ActiveRecord::Base
  
  geocoded_by :postcode, :latitude  => :lat, :longitude => :lng
  after_validation :geocode
  # acts_as_mappable
  #include GeoKit::Geocoders

  def self.grouped_by_lat_lng keyword
    Job.populate_job_geodata(keyword)
    where('keyword = ?', keyword).group_by { |job| "#{'%.2f' % [(job.lat * 100).round / 100.0]} #{'%.2f' % [(job.lng * 100).round / 100.0]}" if job.lat && job.lng }
  end

  def self.populate_job_geodata(keyword)

    #keywords = ["football", "catering", "teaching", "music", "x-factor", "x%20factor", "chef", "engineer", "factory", "marketing", "media", "customer%20service", "banking", "farm", "farming"]
    #keywords = ["football"]

    #keywords.each do |keyword|

      response = HTTParty.get("http://api.lmiforall.org.uk/api/v1/vacancies/search?keywords=#{keyword}")

      response.each do |job|
        
        unless self.where('lmi_vacancy_id = ?', job["id"]).any?
          new_job = self.new
          new_job.keyword = keyword
         
          new_job.title = job["title"]
          new_job.lmi_vacancy_id = job["id"]
          new_job.description = job["summary"]
          new_job.city = job["location"]["city"]
          new_job.area = job["location"]["area"]
          new_job.postcode = job["location"]["postcode"]
          new_job.country = job["location"]["country"]
          new_job.job_start = job["activedate"]["start"]
          new_job.job_end = job["activedate"]["end"]
          new_job.job_last_updated = job["activedate"]["updated"]

          puts "Job saved successfully" if new_job.save
          puts Job.count
          
        else
          puts 'This job already exists in the DB.'
        end
        
      end

    #end

  end

end
