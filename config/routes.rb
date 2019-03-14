# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { invitations: 'users/invitations' }
  root to: 'controller#action'
end
