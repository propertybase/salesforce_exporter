require "salesforce_exporter/exporter"

module SalesforceExporter
  class Client
    attr_reader :sf_client

    def initialize(sf_client)
      @sf_client = sf_client
    end

    def export(objects:, to:)
      object_descriptions = Array(objects).map { |o| sf_client.describe(o) }
      SalesforceExporter::Exporter.new(object_descriptions, to).export
    end

    private
  end
end
