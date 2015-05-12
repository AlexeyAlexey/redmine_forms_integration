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
	end
  end
end