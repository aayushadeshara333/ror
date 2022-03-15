class ChangesToTables < ActiveRecord::Migration[7.0]
  def change
    add_column :books, :year, :integer
    rename_column :books, :title, :book_title
  end
end
