class CreateWidgetsTable < ActiveRecord::Migration[7.0]
  def change
    create_table :widgets, id: :uuid do |t|
      t.string :name, null: false
      t.timestamps null: false
      t.references :user, type: :uuid, index: true
    end
  end
end
