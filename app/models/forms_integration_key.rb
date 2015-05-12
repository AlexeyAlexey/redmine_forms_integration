class FormsIntegrationKey < ActiveRecord::Base
  unloadable
  has_many :forms_integration_key_signatures, dependent: :destroy

  belongs_to :object, :polymorphic => true, required: true
  
  validates_uniqueness_of :object_type, scope: :object_id

  before_create :generate_access_token



  private
    def generate_access_token
      begin
        self.access_token = SecureRandom.hex(40)
      end while self.class.exists?(access_token: access_token)

      self.expires_at = 90.days.from_now.utc if self.expires_at.nil?
    end
end
