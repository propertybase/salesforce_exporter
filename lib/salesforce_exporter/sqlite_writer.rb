module SalesforceExporter
  class SqliteWriter
    attr_reader :sf_client
    attr_reader :db
    attr_reader :objects

    def initialize(sf_client, db, objects)
      @sf_client = sf_client
      @db = db
      @objects = objects
    end

    def write
      objects.each do |object|
        sf_client.query(self.class.build_query(object)).each do |row|
          db[Sequel.identifier(object["name"].to_sym)] << row.attrs
        end
      end
      db
    end

    private

    def self.build_query(object)
      record = object["name"]
      fields = object["fields"].reject{|f| f["calculated"] }.map{|f| f["name"]}.join(",")
      "select #{fields} from #{record}"
    end
  end
end
