# frozen_string_literal: true

class NotificationTemplate::Contract::Create < Reform::Form
  feature Reform::Form::Dry

  property :title
  property :content
  property :project_id
  property :suitable_roles

  validation do
    required(:title).filled
    required(:content).filled
    required(:project_id) { int? & gt?(0) }
    required(:suitable_roles) { array? }
  end
end
