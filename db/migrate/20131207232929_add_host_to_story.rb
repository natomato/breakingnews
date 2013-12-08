class AddHostToStory < ActiveRecord::Migration
  def change
    add_column :stories, :host, :string
    add_index :stories, :host
  end
end
