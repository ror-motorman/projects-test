# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User::Invite do
  let(:project) { Project::Create.call(title: 'Project')['model'] }
  let(:location) { Location::Create.call({ title: 'Location' }, project: project) }
  let! (:notification_template) do
    NotificationTemplate::Create.call({
                                        title: 'NotificationTemplate', content: 'some'
                                      },
                                      project: project,
                                      suitable_roles: %w[admin user])
  end
  let(:invitee_name) { 'Invitee Name' }
  let(:invitee_email) { 'invitee@example.com' }
  let(:inviter_email) { 'inviter@example.com' }
  let(:inviter_user) do
    User::Create.call({ name: 'Inviter Name', email: inviter_email }, role: 'admin', project: project)['model']
  end

  it 'creates a user with invitation and subscription' do
    result = described_class.call(
      {
        name: invitee_name,
        email: invitee_email
      },
      role: 'user',
      project: project,
      inviter: inviter_user
    )
    invitee = result['model']

    expect(invitee).to be_persisted
    expect(invitee.name).to eq invitee_name
    expect(invitee.invited_by.id).to eq inviter_user.id
    expect(SendInvitationWorker.jobs.size).to eq 1
    expect(invitee.notification_templates.count).to eq 1
  end

  it 'should not create a user with unknown role' do
    result = described_class.call(
      {
        name: invitee_name,
        email: invitee_email
      },
      role: 'unknown',
      project: project,
      inviter: inviter_user
    )

    assert result.failure?
    expect(result['model']).not_to be_persisted
    expect(SendInvitationWorker.jobs.size).to eq 1
  end

  it 'should not create a user with existing email' do
    result = described_class.call(
      {
        name: invitee_name,
        email: inviter_user
      },
      role: 'unknown',
      project: project,
      inviter: inviter_user
    )

    assert result.failure?
    expect(result['model']).not_to be_persisted
    expect(SendInvitationWorker.jobs.size).to eq 1
  end
end
