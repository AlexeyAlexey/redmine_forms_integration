class FormsIntegrationKeySignature < ActiveRecord::Base
  unloadable
  belongs_to :forms_integration_key
end
