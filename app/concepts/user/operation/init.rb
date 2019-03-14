# frozen_string_literal: true

class User::Operation::Init < ApplicationOperation
  step :incoming_data
  step Model(User, :new)
  step :assign_data
  step Contract::Build(constant: User::Contract::Create)

  failure :log_error!
  step :notify!

  def assign_data(_options, model:, params:, **)
    model.name = params[:name]
    model.email = params[:email]
  end
end
