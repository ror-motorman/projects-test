# frozen_string_literal: true

class User::Invite < ApplicationOperation
  step Wrap(active_record_transaction) {
    step Nested(User::Create)

    # step Nested(Role::Create)

    step :queue_invitation
  }
  step :notify!
  failure :log_error!

  def queue_invitation(options, model:, **)
    model.skip_invitation = true
    model.invite!(options[:inviter])
    SendInvitationWorker.perform_async(model.id)
  end
end
