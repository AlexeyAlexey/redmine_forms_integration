module API
  class FormsIntegrationController < ApplicationController
    unloadable
    before_filter :check_signtature

    def create
      call_hook(:create_forms_integration, :forms_integration_key => @forms_integration_key)
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
          return true
       else
         render :nothing => true, status: 403
         return
       end
     end
 end
end