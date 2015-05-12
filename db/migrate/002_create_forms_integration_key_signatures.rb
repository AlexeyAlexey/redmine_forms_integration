class CreateFormsIntegrationKeySignatures < ActiveRecord::Migration
  def change
    create_table :forms_integration_key_signatures do |t|
      t.text       :signature, null: false
      t.belongs_to :forms_integration_key
      t.timestamps null: false
    end
  end
end
