require 'spec_helper'

describe SalesforceExporter do
  it "has a version number" do
    expect(SalesforceExporter::VERSION).not_to be nil
  end

  it "initializes with a SalesforceExporter::Client" do
    expect(SalesforceExporter.new).to be_a(SalesforceExporter::Client)
  end
end
