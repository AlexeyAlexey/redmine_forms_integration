class CreateFormsIntegrationKeys < ActiveRecord::Migration
  def change
    create_table :forms_integration_keys do |t|
      t.integer    :object_id,    null: false
      t.string     :object_type,  null: false
      t.string     :access_token, null: false
      t.datetime   :expires_at
      t.boolean    :blocked
      t.timestamps null: false
    end

    add_index :forms_integration_keys, [:object_id, :object_type], unique: true
    add_index :forms_integration_keys, [:access_token],  unique: true
  end

  def self.down
    drop_table :forms_integration_keys
  end
end
