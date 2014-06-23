class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.float :lat
      t.float :lng
      t.text :location
      t.text :title
      t.integer :lmi_vacancy_id
      t.text :description
      t.text :keyword

      t.timestamps
    end
  end
end
