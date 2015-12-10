require "salesforce_exporter/schema"
require "salesforce_exporter/sqlite_writer"

module SalesforceExporter
  class Client
    attr_reader :sf_client

    def initialize(sf_client)
      @sf_client = sf_client
    end

    def export(objects:, to:)
      object_descriptions = Array(objects).map { |o| sf_client.describe(o) }
      db = SalesforceExporter::Schema.new(object_descriptions, to).create
      SalesforceExporter::SqliteWriter.new(sf_client, db, object_descriptions).write
    end
  end
end
