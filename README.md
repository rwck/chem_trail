# Chem Trail

A simple app for tracking pharmacy opening hours so you can plan your pseudo-ephedrine buying spree. Also learn Rails testing.

### Set up RSpec

* Add RSpec to `Gemfile`:

  ```ruby
  gem 'rspec-rails', groups: [:development, :test]
  ```

* Install RSpec

  ```
  bundle
  ```

* Run RSpec install generator

  ```
  rails g rspec:install
  ```

### Set up Simplecov

* Add simplecov to `Gemfile`

  ```ruby
  gem 'simplecov', require: false, group: :test
  ```

* Add simplecov to `spec/spec_helper.rb`

  ```ruby
  require 'simplecov'
  SimpleCov.start 'rails'
  ```

### Create our first test

* Create a unit test.

  ```
  rails g rspec:model OpenPeriod
  ```

* Edit it:

  ```ruby
  require 'rails_helper'

  RSpec.describe OpenPeriod, type: :model do
    describe '#formatted' do
      it 'should format the open period 9-5 on Monday' do
        period = OpenPeriod.new(day: "Monday", time_from: "09:00", time_to: "05:00")
        expect(period.formatted).to eq 'Monday: 9:00am - 5:00pm'
      end
    end
  end
  ```

### Run the tests and implement the feature

* Run the tests:

  ```
  rake db:test:prepare
  rspec
  open coverage/index.html
  ```

* Implement `OpenPeriod#formatted` to make the test pass.

### Doubles and unit test isolation

* Edit `spec/models/pharmacy_spec.rb`:

  ```ruby
  require 'rails_helper'

  RSpec.describe Pharmacy, type: :model do
    pending "add some examples to (or delete) #{__FILE__}"

    describe '#open_periods_formatted' do
      it 'should format all open periods' do
        pharmacy = Pharmacy.new(name: "Balmain")
        allow(pharmacy).to receive_messages(open_periods: [
          object_double(OpenPeriod.new, day: "Monday", time_from: Time.new(2000, 1, 1, 9, 0)),
          object_double(OpenPeriod.new, day: "Tuesday", time_from: Time.new(2000, 1, 1, 9, 0)),
        ])
        expect(pharmacy.open_periods_formatted).to eq "Monday: 9am - 5pm\nTuesday: 9am - 5pm"
      end
    end
  end
  ```


* Run the tests:

  ```
  rspec
  ```

* Implement `Pharmacy#open_periods_formatted` to make the test pass.

### Controller and view specs

* Generate some controller and view specs:

  ```
  rails g scaffold pharmacy name
  ```

* Look at and update the controller and view specs until they pass and none are skipped.

* Check what the coverage is.

