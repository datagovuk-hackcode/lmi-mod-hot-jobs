class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :lat
      t.string :lon
      t.string :location
      t.string :title
      t.string :description

      t.timestamps
    end
  end
end
