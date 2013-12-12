class ChangePositionToStories < ActiveRecord::Migration
  def change
    change_column :stories, :position, :string
  end
end
