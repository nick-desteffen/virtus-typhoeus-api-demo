module Api
  module Base
    extend ActiveSupport::Concern

    included do
      require "addressable/uri"
      include Virtus.model
      extend  ActiveModel::Naming
      extend  ActiveModel::Translation
      include ActiveModel::Conversion
      include ActiveModel::Validations
    end

    def persisted?
      id.present?
    end

    def assign_errors(error_data)
      error_data[:errors].each do |attribute, attribute_errors|
        attribute_errors.each do |error|
          self.errors.add(attribute, error)
        end
      end
    end

    module ClassMethods

      def find(id)
        response = Typhoeus.get("#{base_url}/#{id}", headers: {"Accept" => "application/json"})
        if response.success?
          data = JSON.parse(response.body, symbolize_names: true)
          return self.new(data)
        else
          return nil
        end
      end

      def where(parameters={})
        parameters.reject!{ |key, value| value.blank? }
        querystring = Addressable::URI.new.tap do |uri|
          uri.query_values = parameters
        end.query

        response = Typhoeus.get("#{base_url}?#{querystring}", headers: {"Accept" => "application/json"})
        if response.success?
          data = JSON.parse(response.body, symbolize_names: true)
          return data.map{ |record| self.new(record) }
        else
          return nil
        end
      end

      alias_method :all, :where

      def create(attributes={})
        response = Typhoeus::Request.post(base_url, body: envelope(attributes), headers: {"content-type" => "application/x-www-form-urlencoded"})
        data = JSON.parse(response.body, symbolize_names: true)
        if response.success?
          object = self.new(data)
        else
          object = self.new(attributes)
          object.assign_errors(data) if response.response_code == 422
        end
        return object
      end

      def update(id, attributes={})
        object = self.new(attributes.merge(id: id))
        response = Typhoeus::Request.put("#{base_url}/#{id}", body: envelope(attributes), headers: {"content-type" => "application/x-www-form-urlencoded"})
        if response.response_code == 422
          data = JSON.parse(response.body, symbolize_names: true)
          object.assign_errors(data)
        end
        return object
      end

      def destroy(id)
        response = Typhoeus::Request.delete("#{base_url}/#{id}")
        return response.success?
      end

    private

      def envelope(attributes)
        envelope = {}
        envelope[self.name.to_s.underscore.downcase] = attributes
        return envelope
      end

      def base_url
        Rails.configuration.api_endpoint + "/" + self.name.to_s.underscore.downcase.pluralize
      end

    end

  end
end
