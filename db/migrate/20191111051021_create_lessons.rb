class CreateLessons < ActiveRecord::Migration[5.2]
  def change
    create_table :lessons do |t|
      t.string :title
      t.datetime :time
      t.string :location
      t.string :photo
      t.string :topic

      t.timestamps
    end
  end
end
