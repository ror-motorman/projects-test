# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User::RemoveFromProject do
  let(:project) { Project::Create.call(title: 'Project1')['model'] }
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

  it 'deletes user from project with subscriptions' do
    User::RemoveFromProject.call({ user: invitee_user }, project: project, role_title: 'user')

    expect(inviter_user).to be_persisted
    expect(invitee_user).to be_persisted

    expect(invitee_user.notification_templates.for_role('user').count).to eq 0
    expect(inviter_user.notification_templates.for_role('admin').count).to eq 1
    expect(project.notification_templates.count).to eq 1
  end
end
