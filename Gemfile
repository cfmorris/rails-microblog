source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.3"
gem "rails", "~> 7.0.2", ">= 7.0.2.3"
gem "image_processing"
gem "sprockets-rails"

gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "active_storage_validations"

gem "turbo-rails", "~>1.0.0"
gem "stimulus-rails"
gem "jsbundling-rails"
gem "jbuilder"

gem "bootstrap"
gem "cssbundling-rails"
gem "sassc-rails"
gem "mini_magick"

gem "bcrypt"
gem "digest"

gem "importmap-rails"
gem "faker"
gem "will_paginate"
gem "bootstrap-will_paginate"

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
