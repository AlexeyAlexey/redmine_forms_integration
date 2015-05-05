ActionDispatch::Callbacks.to_prepare do
    require_dependency 'forms_integration_association_to_issue'
    require_dependency 'forms_integration_association_to_project'
    
    Issue.send(:include, Redmine::FormsIntegration::IssueModelPatch)
    Project.send(:include, Redmine::FormsIntegration::ProjectPatch)
end
Redmine::Plugin.register :redmine_forms_integration do
  name 'Redmine Forms Integration plugin'
  author 'Alexey Kkondratenko'
  description 'Form Integration To Redmine'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'
end
