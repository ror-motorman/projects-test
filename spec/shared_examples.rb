# frozen_string_literal: true

RSpec.shared_examples 'shared data' do
  let(:project) { Project::Create.call(title: 'Project')['model'] }
  let(:location) { Location::Create.call({ title: 'Location' }, project: project) }

  let! (:notification_template) do
    NotificationTemplate::Create.call({
                                        title: 'NotificationTemplate', content: 'some'
                                      },
                                      project: project,
                                      suitable_roles: %w[admin user])
  end

  let(:inviter_name) { 'Inviter Name' }
  let(:inviter_email) { 'inviter@example.com' }

  let(:invitee_name) { 'Invitee Name' }
  let(:invitee_email) { 'invitee@example.com' }

  let(:inviter_user) do
    User::Create.call({ name: inviter_name, email: inviter_email }, role: 'admin', project: project)['model']
  end
  let(:invitee_user) do
    User::Create.call({ name: invitee_name, email: invitee_email }, role: 'user', project: project)['model']
  end
end
