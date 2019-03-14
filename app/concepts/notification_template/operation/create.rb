# frozen_string_literal: true

class NotificationTemplate::Create < ApplicationOperation
  step Model(NotificationTemplate, :new)
  step :assign_data
  step Contract::Build(constant: NotificationTemplate::Contract::Create)
  step Contract::Validate()
  step Contract::Persist()

  failure :log_error!
  step :notify!

  def assign_data(options, model:, params:, **)
    model.title = params[:title]
    model.project = options[:project]
  end
end

# NotificationTemplate::Create.({title: 'NotificationTemplate', content: 'some'}, project: Project.last)
