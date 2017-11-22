require './test/test_helper'

class TypeformResponseTest < Minitest::Test
  def setup
    Typeform.access_token = 'some-token'
  end

  def test_exists
    assert Typeform::Response
  end

  def test_it_gives_back_a_single_form_responses
    VCR.use_cassette('responses') do
      responses = Typeform::Response.new(access_token: 'some-token', form_id: 'some-form')
      assert_equal Typeform::Response, responses.class

      entries = responses.all_entries
      assert_equal 25, entries.items.size
      assert entries.items.kind_of?(Array)
    end
  end
end
