class AddPositionToStories < ActiveRecord::Migration
  def change
    add_column :stories, :position, :integer
    add_index :stories, :position
  end
end
