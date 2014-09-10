class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.float :lat
      t.float :lng
      t.text :city
      t.text :area
      t.text :postcode
      t.text :country
      t.text :title
      t.integer :lmi_vacancy_id
      t.text :description
      t.text :keyword
      t.datetime :job_start
      t.datetime :job_end
      t.datetime :job_last_updated

      t.timestamps
    end
  end
end
