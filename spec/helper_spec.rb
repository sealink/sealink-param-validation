# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SealinkParamValidation::ValidationHelper do
  context '.generate_error_message' do
    let(:errors) { schema.call(params) }
    subject { SealinkParamValidation::ValidationHelper.generate_error_message(errors) }

    context 'flat schema' do
      let(:schema) {
        Dry::Schema.Params {
          required(:id).filled(:integer)
          required(:name).filled(:string)
        }
      }
      let(:params) { {} }
      it { is_expected.to eq 'id is missing, name is missing' }
    end

    context 'nested schema' do
      let(:schema) {
        Dry::Schema.Params {
          required(:id).filled(:integer)
          required(:type).hash {
            required(:id).filled(:integer)
          }
        }
      }
      let(:params) { { type: {} } }
      it { is_expected.to eq 'id is missing, id is missing' }
    end

    context 'arrays' do
      let(:schema) {
        Dry::Schema.Params {
          required(:ids).array(:integer)
        }
      }
      let(:params) { { ids: [ 1, 'a', 'b' ] } }
      it { is_expected.to eq '1 must be an integer, 2 must be an integer' }
    end
  end

  context '.generate_humanized_error_message' do
    let(:errors) { schema.call(params) }
    subject { SealinkParamValidation::ValidationHelper.generate_humanized_error_message(errors) }

    context 'flat schema' do
      let(:schema) {
        Dry::Schema.Params {
          required(:id).filled(:integer)
          required(:name).filled(:string)
        }
      }
      let(:params) { {} }
      it { is_expected.to eq 'Id is missing and Name is missing' }
    end

    context 'nested schema' do
      let(:schema) {
        Dry::Schema.Params {
          required(:id).filled(:integer)
          required(:type).hash {
            required(:id).filled(:integer)
          }
        }
      }
      let(:params) { { type: {} } }
      it { is_expected.to eq 'Id is missing and Type.Id is missing' }
    end
  end
end
