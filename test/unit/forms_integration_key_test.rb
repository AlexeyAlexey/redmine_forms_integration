require File.expand_path('../../test_helper', __FILE__)


class FormsIntegrationKeyTest < ActiveSupport::TestCase
  fixtures :projects

  def test_sould_not_create_record_without_object
    record = FormsIntegrationKey.new   
   
    assert_raises(ActiveRecord::RecordInvalid){
      record.save!
    }
  end

  def test_should_autho_genarate_key
    project = Project.find(1)
    project_key = project.forms_integration_keys.build
    project_key.save
    
    assert_not_nil project_key.access_token
  end

  def test_should_set_default_expires_at_same_90_days
    project = Project.find(1)
    #key = FormsIntegrationKey.new
    project_key = project.forms_integration_keys.build
    project_key.save

    assert (project_key.expires_at <= 90.days.from_now.utc)
  end

  def test_sould_not_create_same_key
    project = Project.find(1)
    project_key = project.forms_integration_keys.build
    project_key.save

    sql = "INSERT INTO forms_integration_keys (object_id, object_type, created_at, updated_at, access_token, expires_at) VALUES ('1', 'Project', '2015-04-08 22:39:30', '2015-04-08 22:39:30', '#{project_key.access_token}', '2015-07-07 22:39:30')"
    
    assert_raises(ActiveRecord::RecordNotUnique){
      ActiveRecord::Base.connection.execute(sql)
    }
  end
end
