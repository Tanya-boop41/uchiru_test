source "https://rubygems.org"

gem "rails", "~> 8.1.1"
gem "pg", "~> 1.4"
gem "puma", ">= 5.0"
gem "tzinfo-data", platforms: %i[ windows jruby ]

gem "bootsnap", require: false
gem "jwt"
gem "jsonapi-serializer"

group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "bundler-audit", require: false
  gem "brakeman", require: false

  gem "rubocop-rails-omakase", require: false
  gem 'rubocop', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
end
