# frozen_string_literal: true

require_relative 'spec_helper'
require_relative '../configuration'

RSpec.describe 'send mail' do
  let(:gmail) { Configuration.client }
  let(:mail) { Mail.new }
  let(:recipient) { 'gdtesting001@gmail.com' }
  let(:subject) { "Testing email #{Random.rand(0..100)}" }
  let(:body) { "This is a test email #{Random.rand(0..100)} send using rspec." }
  let(:message_id) { @message_id }

  before(:example) do
    mail.to = recipient
    mail.subject = subject
    mail.part content_type: 'multipart/alternative' do |part|
      part.html_part = Mail::Part.new(body: body, content_type: 'text/html')
      part.text_part = Mail::Part.new(body: body)
    end
    message_to_send = Google::Apis::GmailV1::Message.new(raw: mail.to_s)
    response = gmail.send_user_message('me', message_to_send)
    expect(response).to be_truthy
    @message_id = response.id
  end

  it 'verify that message was sent' do
    message = gmail.get_user_message('me', message_id)
    expect(message.payload.headers.any? { |h| h.name == 'To' && h.value == recipient }).to be true
    expect(message.payload.headers.any? { |h| h.name == 'Subject' && h.value == subject }).to be true
  end
end
