class ChangeWebsiteDataType < ActiveRecord::Migration
  def self.up
    change_column :stories, :website, :text
  end

  def self.down
    change_column :stories, :website, :string
  end
end
