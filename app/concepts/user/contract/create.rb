# frozen_string_literal: true

class User::Contract::Create < Reform::Form
  feature Reform::Form::Dry

  property :email
  property :name

  validation do
    configure do
      def self.messages
        super.merge(en: { errors: { email: 'already taken' } })
      end
    end

    required(:email).filled
    required(:name).filled

    validate(email: %i[email]) do |email|
      User.where(email: email).count.zero?
    end
  end
end
