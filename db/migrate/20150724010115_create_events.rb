class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.datetime :starts_at
      t.references :place, index: true
      t.references :user, index: true
      t.text :description

      t.timestamps
    end
  end
end
