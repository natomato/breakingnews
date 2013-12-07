class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.string :website
      t.string :headline
      t.string :lead_paragraph

      t.timestamps
    end
  end
end
