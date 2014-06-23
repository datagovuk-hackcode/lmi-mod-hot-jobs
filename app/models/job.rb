class Job < ActiveRecord::Base
  
  acts_as_mappable

  def self.grouped_by_lat_lng keyword
    where('keyword = ?', keyword).group_by { |job| "#{'%.2f' % [(job.lat * 100).round / 100.0]} #{'%.2f' % [(job.lng * 100).round / 100.0]}"  }
  end

  def self.populate_job_geodata

    keywords = ["football", "catering", "teaching", "music", "x-factor", "x factor", "catering", "chef"]
    #keywords = ["football"]

    keywords.each do |keyword|

      response = HTTParty.get("http://api.lmiforall.org.uk/api/v1/vacancies/search?keywords=#{keyword}")

      response.each do |job|
        
        unless self.where('lmi_vacancy_id = ?', job["id"]).any?
          new_job = self.new
          new_job.keyword = keyword
          
          geo = self.geocode("#{job["location"]["postcode"]}, UK") rescue nil
          
          if geo
            new_job.title = job["title"]
            new_job.lmi_vacancy_id = job["id"]
            new_job.description = job["summary"]
            puts
            puts
            puts geo
            puts
            puts
            new_job.lng = geo.lng
            new_job.lat = geo.lat

            puts "Job saved successfully" if new_job.save
            puts Job.count
            sleep 2
          end
        else
          puts 'This job already exists in the DB.'
        end
        
      end

    end

  end

end
