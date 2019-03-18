# frozen_string_literal: true

class User::RemoveFromProject < ApplicationOperation
  step Wrap(active_record_transaction) {
    step :delete_role
  }
  step :notify!
  failure :log_error!

  def delete_role(options, params:, **)
    user = params[:user]
    project = options[:project]
    role_title = options[:role_title]
    project.roles.where(user_id: user, title: role_title).destroy_all
  end
end

# User::RemoveFromProject.({user: User.find(4)}, project: Project.find(1),role_title: 'qwe')
