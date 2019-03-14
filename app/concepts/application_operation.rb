# frozen_string_literal: true

class ApplicationOperation < Trailblazer::Operation
  def incoming_data(options, model: nil, params: nil, **)
    p 'Options:'
    pp options
    p 'Model:'
    pp model
    p 'Params:'
    pp params
  end

  def notify!(_options, model:, **)
    Rails.logger.info("#{self.class.name} processed")
  end

  def log_error!(options, params:, **)
    ar_errors = begin
                  options['model'].errors.messages
                rescue StandardError
                  {}
                end
    validator_errors = begin
                         options['contract.default'].errors.messages
                       rescue StandardError
                         {}
                       end
    errs = ar_errors.merge(validator_errors)
    Rails.logger.error(errs)
    errs
  end
end
