source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.3"
gem "rails", "~> 7.0.2", ">= 7.0.2.3"
gem "sprockets-rails"

gem "pg", "~> 1.1"
gem "puma", "~> 5.0"

gem "jsbundling-rails"
gem "turbo-rails", "~>1.0.0"
gem "stimulus-rails"
gem "cssbundling-rails"
gem "jbuilder"
gem "sassc-rails"
gem "bcrypt"
gem "digest"
gem "bootstrap"
gem "importmap-rails"

gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false

group :development, :test do
  gem "byebug", platforms: %i[ mri mingw x64_mingw ]
end

group :development do
  gem "web-console"
  gem "listen"
  gem "spring"
  gem "spring-watcher-listen"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
  gem "rails-controller-testing"
  gem "minitest"
  gem "minitest-reporters"
  gem "guard"
  gem "guard-minitest"
end
