# frozen_string_literal: true
class Zendesk2::CreateCategory
  include Zendesk2::Request

  request_method :post
  request_path do |_| '/categories.json' end
  request_body do |r| { 'category' => r.params['category'] } end

  def self.accepted_attributes
    %w(id name description position)
  end

  def mock
    identity = cistern.serial_id

    record = {
      'id'         => identity,
      'url'        => url_for("/categories/#{identity}.json"),
      'created_at' => Time.now.iso8601,
      'updated_at' => Time.now.iso8601,
    }.merge(Cistern::Hash.slice(params.fetch('category'), *self.class.accepted_attributes))

    cistern.data[:categories][identity] = record

    mock_response({ 'category' => record }, { status: 201 })
  end
end
