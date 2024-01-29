class AddDetailsToBooks < ActiveRecord::Migration[7.1]
  def change
    add_column :books, :price, :integer  
    add_column :books, :date_posted, :datetime  
    add_column :books, :author, :string  
  end
end
