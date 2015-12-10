# SalesforceExporter

This gem can be used to export salesforce objects to an SQLite database. Datatypes and indexes will be preserved.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'salesforce_exporter'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install salesforce_exporter

## Usage

### Authentication

The SalesforceExporter client just passes on the credentials to the underlying client [restforce](https://github.com/ejholmes/restforce). You can use exactly the same parameters as specified in the [README of Restforce](https://github.com/ejholmes/restforce#initialization)

```ruby
client = SalesforceExporter.new(
  oauth_token:      'access_token',
  refresh_token:    'refresh token',
  instance_url:     'instance url',
  client_id:        'client_id',
  client_secret:    'client_secret',
)
```

### Export

In order to start the export, you need to specify the objects and and SQLite connection string. The exporter will return the database object after finish.

```ruby
db = client.export(objects: ["Contact", "Account"], to: "sqlite://test.db")
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/salesforce_exporter. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.

