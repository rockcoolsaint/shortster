class CreateLinks < ActiveRecord::Migration[6.1]
  def change
    create_table :links do |t|
      t.string :url
      t.string :shortcode
      t.datetime :last_accessed
      t.integer :access_count, default: 0

      t.timestamps
    end
  end
end
