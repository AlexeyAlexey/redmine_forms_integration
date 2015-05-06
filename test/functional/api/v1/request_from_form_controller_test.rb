require File.expand_path('../../../../test_helper', __FILE__)

require 'base64'
require 'openssl'
require 'digest/sha1'

module API
  class V1::RequestFromFormControllerTest < ActionController::TestCase
    # Replace this with your real tests.
    fixtures :projects, :versions, :users, :email_addresses, :roles, :members,
           :member_roles, :issues, :journals, :journal_details,
           :trackers, :projects_trackers, :issue_statuses,
           :enabled_modules, :enumerations, :boards, :messages,
           :attachments, :custom_fields, :custom_values, :time_entries,
           :wikis, :wiki_pages, :wiki_contents, :wiki_content_versions

    def setup
      #@controller = API::FormsIntegrationController.new

      @project = Project.find(1)
      @project_key = @project.forms_integration_keys.build
      @project_key.save
      @project_key.reload

      @access_key_id = @project_key.id
      @secret_key = @project_key.access_token
      policy_document = {"expiration": "2015-01-01T00:00:00Z",
        "conditions": []
      }
      @policy = Base64.encode64(policy_document.to_json).gsub("\n","")

      @signature = Base64.encode64(
        OpenSSL::HMAC.digest(OpenSSL::Digest::Digest.new('sha1'), @secret_key, @policy)
      ).gsub("\n","")
    end
    # Replace this with your real tests.
    def test_truth
      assert true
    end

    def test_post_from_forms
      post :create, {access_key_id: @access_key_id, policy: @policy, signature: @signature}
      assert_response :success
      #assert_equal 200, response.status
    end

    def test_post_from_forms_permission_denide
      fake_policy_document = {"expiration": "2015-01-01T00:00:00Z",
        "fake": []
      }
      fake_policy = Base64.encode64(fake_policy_document.to_json).gsub("\n","")
      post :create, {access_key_id: @access_key_id, policy: fake_policy, signature: @signature}
      
  	  assert_response 403
    end
  end
end