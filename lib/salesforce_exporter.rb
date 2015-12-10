require "salesforce_exporter/version"
require "salesforce_exporter/client"

require "restforce"

module SalesforceExporter
  class << self
    def new(*args)
      SalesforceExporter::Client.new(Restforce.new(*args))
    end
  end
end
