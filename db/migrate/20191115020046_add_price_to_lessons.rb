class AddPriceToLessons < ActiveRecord::Migration[5.2]
  def change
    add_column :lessons, :price, :integer
  end
end
