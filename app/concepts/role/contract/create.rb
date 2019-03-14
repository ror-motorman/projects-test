# frozen_string_literal: true

class Role::Contract::Create < Reform::Form
  feature Reform::Form::Dry

  property :title
  property :user_id
  property :notification_template_id

  validation do
    required(:title).included_in?(Role::POSSIBLE_TITLES)
    required(:user_id) { int? & gt?(0) }
    required(:notification_template_id) { int? & gt?(0) }
  end
end
