require "sequel"
require "sqlite3"

module SalesforceExporter
  class Schema
    attr_reader :objects
    attr_reader :db

    def initialize(objects, db)
      @objects = objects
      @db = Sequel.connect(db)
    end

    def create
      objects.each do |object|
        columns = self.class.columns(object["fields"].reject{|f| f["calculated"] })
        db.create_table!(object["name"]) do
          columns.each do |column_definition|
            send(*column_definition)
          end
        end
      end
      db
    end

    private

    def self.coulumn_type(field)
      type_mapping.fetch(field["type"])
    end

    def self.columns(fields)
      fields.map { |f| column_options(f) }
    end

    def self.column_options(field)
      method_name, _ = coulumn_type(field)
      [method_name, field["name"], nil, options(field) ]
    end

    def self.options(field)
      _, type = coulumn_type(field)
      base = { unique: field["unique"], null: field["nillable"], type: type }
      base.merge!(size: field["length"]) if field["length"] > 0

      if type == :decimal
        base.merge!(size: [field["precision"], field["scale"]])
      end

      # reference = field["referenceTo"].first
      # if reference
      #   base.merge!(table: Sequel.identifier(reference.to_sym))
      # end

      if type == :integer
        base.merge!(size: field["digits"])
      end

      if field["name"].downcase == "id"
        base.merge!(primary_key: true)
      end
      base
    end

    def self.type_mapping
      @_type_mapping ||= {
        "email" => [:column, "VARCHAR"],
        "double" => [:column, "DECIMAL"],
        "int" => [:column, "INTEGER"],
        "currency" => [:column, "DECIMAL"],
        "url" => [:column, "VARCHAR"],
        "id" => [:column, "VARCHAR"],
        "date" => [:column, "DATE"],
        "datetime" => [:column, "DATETIME"],
        "reference" => [:foreign_key, "VARCHAR"],
        "string" => [:column, "VARCHAR"],
        "picklist" => [:column, "VARCHAR"],
        "phone" => [:column, "VARCHAR"],
        "boolean" => [:column, "BOOLEAN"],
        "textarea" => [:column, "TEXT"],
      }
    end
  end
end
