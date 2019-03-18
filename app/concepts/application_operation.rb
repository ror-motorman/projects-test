# frozen_string_literal: true

class ApplicationOperation < Trailblazer::Operation
  def notify!(_options, model:, **)
    Rails.logger.info("#{self.class.name} processed")
    true
  end

  def log_error!(options, params:, **)
    Rails.logger.info("#{self.class.name} error")
    ar_errors = begin
      options['model'].errors.messages
                rescue StandardError => e
                  { message: e }
    end
    validator_errors = begin
      options['contract.default'].errors.messages
                       rescue StandardError => e
                         { message: e }
    end
    errs = ar_errors.merge(validator_errors)

    Rails.logger.error(errs)
    false
  end

  private

  def self.active_record_transaction
    ->(*, &block) { ActiveRecord::Base.transaction { block.call; false } }
  end
end
