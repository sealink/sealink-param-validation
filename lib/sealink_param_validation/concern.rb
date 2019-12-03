# frozen_string_literal: true

require 'active_support/concern'

module SealinkParamValidation
  module Concern
    extend ActiveSupport::Concern

    included do
      # Accessor for validation results hash
      attr_reader :validation_result
      class_attribute :schemas
      self.schemas = {}

      def self.schema_for(action, schema = nil)
        schemas[action.to_sym] = schema if schema
        before_action :ensure_schema
      end
    end

    private

    def ensure_schema!
      @validation_result = schema_for_action.call(params.to_unsafe_h)
      return if @validation_result.success?
      error = SealinkParamValidation::Helper.generate_humanized_error_message(@validation_result)
      fail SealinkParamValidation::InvalidInputError, error
    end

    def ensure_schema
      schema = schema_for_action
      return unless schema.present?
      @validation_result = schema.call(params.to_unsafe_h)
      return if @validation_result.success?
      render json: {error: SealinkParamValidation::Helper.generate_error_message(@validation_result)}, status: 422
    end

    def action
      params['action'].to_sym
    end

    def schema_for_action
      self.class.schemas[action]
    end
  end
end
