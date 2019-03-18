# frozen_string_literal: true

class SendInvitationWorker
  include Sidekiq::Worker

  def perform(params)
    User.find(params).deliver_invitation
  end
end
