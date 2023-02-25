# frozen_string_literal: true

require_relative 'spec_helper'
require_relative '../configuration'

RSpec.describe 'mail box' do
  let(:gmail) { Configuration.client }
  let(:batch) { Google::Apis::GmailV1::BatchModifyMessagesRequest.new }
  let(:last_ten_messages) { gmail.list_user_messages('me', max_results: 10).messages }

  it 'returns the last 10 messages' do
    expect(last_ten_messages.count).to eq(10)
  end

  it 'returns the number of unread messages' do
    response = gmail.list_user_messages('me', q: 'is:unread')
    expect(response.result_size_estimate).to be >= 0
  end

  it 'marks the message as read' do
    message_list = gmail.list_user_messages('me')
    message_ids = message_list.messages.map(&:id)
    message_id = message_ids.sample
    remove_label_hash = { remove_label_ids: ['UNREAD'] }
    mark_as_read = gmail.modify_message('me', message_id, remove_label_hash )
    expect(mark_as_read.label_ids).not_to include('UNREAD')
  end

  it 'returns the message name' do
    last_ten_messages_names = last_ten_messages.map do |message|
      gmail.get_user_message('me', message.id).payload.headers.find { |h| h.name == 'Subject' }.value
    end
    expect(last_ten_messages_names).not_to be_empty
  end
end
