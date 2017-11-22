require './lib/typeform'
require 'minitest/autorun'
require 'webmock/minitest'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = "test/fixtures"
  c.hook_into :webmock
  c.before_record do |i|
    i.response.body.force_encoding('UTF-8')
  end
end
