class AddSearchableTextToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :searchable_text, :string, default: ""
  end
end
