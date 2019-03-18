# frozen_string_literal: true

class NotificationTemplate::Create < ApplicationOperation
  step Model(NotificationTemplate, :new)
  step :assign_data
  step Contract::Build(constant: NotificationTemplate::Contract::Create)
  step Contract::Validate()
  step Contract::Persist()

  step :notify!
  failure :log_error!

  def assign_data(options, model:, params:, **)
    model.title = params[:title]
    model.project = options[:project]
    model.suitable_roles = options[:suitable_roles]
  end
end
