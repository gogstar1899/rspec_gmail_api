# frozen_string_literal: true

require_relative 'spec_helper'
require_relative '../configuration'

RSpec.describe 'gmail labels' do
  let(:gmail) { Configuration.client }
  let(:label) { Google::Apis::GmailV1::Label.new }
  let(:label_name) { "test_label_#{Random.rand(0..10)}" }
  let(:label_id) { @label_id }

  before(:example) do
    label.name = label_name
    label.label_list_visibility = 'labelShow'
    label.message_list_visibility = 'show'
    response = gmail.create_user_label('me', label)
    @label_id = response.id
  end

  it 'creates a new label' do
    labels = gmail.list_user_labels('me')
    expect(labels.labels.any? { |l| l.name == label_name }).to be true
    gmail.delete_user_label('me', @label_id)
  end

  it 'deletes the new label' do
    gmail.delete_user_label('me', @label_id)
    labels = gmail.list_user_labels('me')
    expect(labels.labels.any? { |l| l.name == label_name }).to be false
  rescue Google::Apis::ClientError => e
    puts "Delete label failed with status code #{e.status_code} and message #{e.message}"
    expect(e.status_code).to eq(204)
  end
end
