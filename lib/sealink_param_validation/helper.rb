# frozen_string_literal: true

module SealinkParamValidation
  class Helper
    def self.generate_error_message(result)
      result.errors(full: true).to_h.values.map { |v|
        v.is_a?(Hash) ? v.values : v
      }.flatten.join(', ')
    end

    def self.generate_humanized_error_message(result)
      build_humanized_errors(result.errors.to_h).to_sentence
    end

    def self.build_humanized_errors(errors, parent = nil)
      errors.to_h.flat_map { |field, messages|
        if messages.is_a?(Hash)
          build_humanized_errors(messages, field)
        else
          generate_humanized_error(parent, field, messages)
        end
      }
    end
    private_class_method :build_humanized_errors

    def self.generate_humanized_error(parent, field, messages)
      return "#{parent.to_s.humanize}.#{field.to_s.humanize} #{messages.join}" if parent.present?
      "#{field.to_s.humanize} #{messages.join}"
    end
    private_class_method :generate_humanized_error
  end
end
