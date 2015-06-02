module API
  module V1
  	class RequestFromFormController < ApplicationController
  	  unloadable
        before_filter :check_signtature

        def create
          call_hook(:create_forms_integration, {:forms_integration_key => @forms_integration_key, :signature => @signature})
          render :nothing => true, status: 200
        end

        private 
          def check_signtature
            @forms_integration_key = FormsIntegrationKey.find_by_id(params[:access_key_id])
            @secret_key = @forms_integration_key.access_token

            @signature = Base64.encode64(
              OpenSSL::HMAC.digest(OpenSSL::Digest::Digest.new('sha1'), @secret_key, params[:policy])
            ).gsub("\n","")
           
            if @signature == params[:signature]
              begin
                @policy_json = JSON.parse(Base64.decode64(params[:policy]))
              rescue
                render :nothing => true, status: 400
                return
              end
              #{access_key_id: @access_key_id, policy: @policy, signature: @signature}
              unless check_expiration(@policy_json)
                render :nothing => true, status: 406
                return
              end
              if FormsIntegrationKeySignature.exists?(:signature => @signature)
                render :nothing => true, status: 203
                return
              end
              return true
            else
              render :nothing => true, status: 403
              return
            end
          end

          def check_expiration(policy_json)
            begin
              settings_expiration = Setting['plugin_redmine_forms_integration'][:expiration_time].to_i
            rescue
              settings_expiration = 0
            end
            settings_expiration = 0 if settings_expiration < 0
            begin
              check_time = Time.now.utc - Time.parse(policy_json['expiration']).utc
            rescue
              check_time = 0
            end
            unless check_time >= 0 && check_time < settings_expiration
              return false
            end
            return true
          end
  	end
  end
end