# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'SealinkParamValidation::Concern', type: :controller do
  before(:all) do
    class DummyController < ActionController::Base
      include SealinkParamValidation::Concern

      schema_for :index, Dry::Schema.Params { required(:data).value(eql?: 'text') }
      def index
        head :ok
      end

      def show
        head :ok
      end

      schema_for :new, Dry::Schema.Params { required(:key).value(eql?: 'text') }
      def new
        head :ok
      end
    end

    Rails.application.routes.draw do
      get 'index' => 'dummy#index'
      get 'show' => 'dummy#show'
      get 'new' => 'dummy#new'
    end

    @controller = DummyController.new
  end

  describe 'validation' do
    context 'successful validation' do
      let(:params) { { 'data' => 'text' } }
      before { get :index, params: params }
      it { expect(response.status).to eq 200 }
    end

    context 'successful validation on second schema' do
      let(:params) { { 'key' => 'text' } }
      before { get :new, params: params }
      it { expect(response.status).to eq 200 }
    end

    context 'unprotected route' do
      let(:params) { { 'data1' => 'text' } }
      before { get :show, params: params }
      it { expect(response.status).to eq 200 }
    end

    context 'failed validation' do
      let(:params) { { 'data1' => 'text1' } }
      before { get :index, params: params }

      it 'should return a 422' do
        expect(response.status).to eq 422
      end

      it 'should return a json body with error' do
        expect(JSON.parse(response.body)['error']).to eq 'data is missing'
      end
    end
  end
end
