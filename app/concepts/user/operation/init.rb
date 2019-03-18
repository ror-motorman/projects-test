# frozen_string_literal: true

class User::Operation::Init < ApplicationOperation
  step Model(User, :new)
  step :assign_data
  step Contract::Build(constant: User::Contract::Create)

  def assign_data(_options, model:, params:, **)
    model.name = params[:name]
    model.email = params[:email]
    true
  end
end
