# frozen_string_literal: true

require_relative 'spec_helper'
require_relative '../configuration.rb'

RSpec.describe Configuration do
    let(:gmail) { Configuration.client }

    it 'should create a new label' do
        label_id = "test_label_#{SecureRandom.hex(4)}"
        label = Google::Apis::GmailV1::Label.new
        label.name = label_id
        label.label_list_visibility = 'labelShow'
        label.message_list_visibility = 'show'
        gmail.create_user_label('me', label)
        labels = gmail.list_user_labels('me')
        expect(labels.labels.any? { |l| l.name == label_id }).to be true
    end
end