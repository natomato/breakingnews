class ChangeParagraphDataTypeInStories < ActiveRecord::Migration
  def self.up
    change_column :stories, :lead_paragraph, :text
  end

  def self.down
    change_column :stories, :lead_paragraph, :string
  end
end
