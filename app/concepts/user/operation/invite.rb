# frozen_string_literal: true

class User::Invite < ApplicationOperation
  step Nested(User::Create)

  # step Nested(Role::Create)

  step :send_invitation

  failure :log_error!
  step :notify!

  def send_invitation(options, model:, **)
    p '====='
    pp options[:current_user]
    pp model
    p '====='

    model.invite!(options[:current_user])
  end
end

# User::Invite.({name: 'qqqq', email: 'qwe1@qwe.qwe1134'}, role: 'admin', project: Project.first, current_user: User.last)
