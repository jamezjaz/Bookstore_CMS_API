class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.string :category
      t.integer :chapters
      t.integer :complete_chapters

      t.timestamps
    end
  end
end
