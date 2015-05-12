class Hooks < Redmine::Hook::ViewListener
  def create_forms_integration(context={})
    ActiveRecord::Base.transaction do
      forms_integration_key_signature = context[:forms_integration_key].forms_integration_key_signatures.new
      forms_integration_key_signature.signature = context[:signature]
      forms_integration_key_signature.save!       
    end
  end
end
