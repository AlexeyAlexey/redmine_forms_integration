require File.expand_path('../../../../test_helper', __FILE__)

require 'base64'
require 'openssl'
require 'digest/sha1'

module API
  class V1::FormsIntegrationControllerTest < ActionController::TestCase
    fixtures :projects, :versions, :users, :email_addresses, :roles, :members,
           :member_roles, :issues, :journals, :journal_details,
           :trackers, :projects_trackers, :issue_statuses,
           :enabled_modules, :enumerations, :boards, :messages,
           :attachments, :custom_fields, :custom_values, :time_entries,
           :wikis, :wiki_pages, :wiki_contents, :wiki_content_versions

    def setup
    end
    # Replace this with your real tests.
    def test_truth
      assert true
    end
  end
end
