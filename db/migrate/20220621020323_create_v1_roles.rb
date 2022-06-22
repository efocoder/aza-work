class CreateV1Roles < ActiveRecord::Migration[7.0]
  def change
    create_table :roles do |t|
      t.string :name
      t.jsonb :permissions

      t.timestamps
    end
  end
end
