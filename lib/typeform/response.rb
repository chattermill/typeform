require 'json'

module Typeform
  class Response
    attr_reader :form_id, :access_token

    def initialize(form_id:, access_token:)
      @form_id = form_id
      @access_token = access_token
    end

    def all_entries
      response = get(uri)
      Hashie::Mash.new(response)
    end

    def complete_entries(params = {})
      response = get(uri, params.merge(completed: true))
      Hashie::Mash.new(response)
    end

    def incomplete_entries(params = {})
      response = get(uri, params.merge(completed: false))
      Hashie::Mash.new(response)
    end

    private
      def get(uri, params = nil)
        params ||= {}
        Typeform.get uri, :query => params, headers: headers
      end

      def uri
        "/forms/#{form_id}/responses"
      end

      def headers
        token = access_token || Typeform.access_token
        {
          'Authorization' => "bearer #{token}"
        }
      end

  end

end
