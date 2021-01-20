require 'json'

module Typeform

  class Form
    # This class doesn't have major changes for backward compatibility.
    attr_reader :form_id, :api_key

    def initialize(form_id:, api_key:nil)
      @form_id = form_id
      @api_key = api_key
    end

    def all_entries
      response = get
      Hashie::Mash.new(response)
    end

    def complete_entries(params = {})
      response = get(params.merge(completed: true))
      Hashie::Mash.new(response)
    end

    def incomplete_entries(params = {})
      response = get(params.merge(completed: false))
      Hashie::Mash.new(response)
    end

    private
      def get(params = nil)
        params ||= {}
        params[:key] = api_key
        Typeform.get uri, :query => params
      end

      def uri
        "/v1/form/#{form_id}"
      end
  end

end
