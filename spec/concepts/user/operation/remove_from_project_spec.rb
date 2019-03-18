# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User::RemoveFromProject do
  include_examples 'shared data'

  it 'deletes user from project with subscriptions' do
    User::RemoveFromProject.call({ user: invitee_user }, project: project, role_title: 'user')

    expect(inviter_user).to be_persisted
    expect(invitee_user).to be_persisted

    expect(invitee_user.notification_templates.for_role('user').count).to eq 0
    expect(inviter_user.notification_templates.for_role('admin').count).to eq 1
    expect(project.notification_templates.count).to eq 1
  end
end
