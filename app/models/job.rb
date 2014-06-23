class Job < ActiveRecord::Base

  def self.populate_job_geodata

    keywords = ["football", "catering", "teaching", "music", "x-factor", "x factor", "catering", "chef"]
    
    response = HTTParty.get("http://api.lmiforall.org.uk/api/v1/vacancies/search?keywords=#{keywords.first}")
    puts response

    response.each do |job|
      puts job.inspect
      puts job["id"]
      puts
      puts
      puts
      puts
      
      #puts job.id
      #puts job.location.city
      #puts job.location.area
    end

  end

end
