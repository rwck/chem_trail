# Chem Trail

A simple app for tracking pharmacy opening hours so you can plan your pseudo-ephedrine buying spree. Also learn Rails testing.

----

## TDD

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


----

## BDD

Behaviour driven development is all about automating a QA person clicking
through your site by writing a script that does that. Then you can run this
script as many times as you want to rapidly verify whether or not you have
implemented a feature. It treats your whole web app as a black box and
restricts itself to doing things that a regular human could do via a web
browser.

It's called "driven development" because by writing an acceptance test first,
you can progressively implement a feature until it half passes, 3/4 passes, and
then fully passes. Running the test each time tells you where you're up to.

### Set up RSpec acceptance testing

Add to `Gemfile`:

  ```ruby
  # acceptance testing
  gem 'nested_form'          # forms for nested resources
  gem 'puma'                 # faster than webrick, used by tests
  group :test do
    gem 'database_cleaner'   # handle truncating tables
    gem 'capybara'           # acceptance test syntax for feature specs
    gem 'launchy'            # lets us save_and_open_page in feature specs
    gem 'selenium-webdriver' # remote control firefox
  end
  ```

Install these things:

  ```
  bundle
  ```

Run

  ```
  rails g rspec:feature ManagePharmacies
  ```

Edit the file `spec/features/manage_pharmacies_spec.rb`:

  ```ruby
  require 'rails_helper'

  RSpec.feature "Manage pharmacies", type: :feature do
    it 'should do stuff' do
      visit '/pharmacies'
      click_on 'New Pharmacy'
      fill_in 'Name', with: 'Ultimo Chemist Plus'
      click_on 'Create Pharmacy'
      expect(page).to have_content 'successfully created'
      click_on 'Back'
      expect(page).to have_content 'Ultimo Chemist Plus'
    end
  end
  ```

Run it:

  ```
  rspec spec/features/manage_pharmacies_spec.rb
  ```

**Check**: Make sure it's passing. It should pass with the built in scaffolding.

### Rails acceptance testing with JavaScript

  ```ruby
  require 'rails_helper'

  RSpec.feature "Manage pharmacies", type: :feature, js: true do
    it 'should do stuff' do
      visit '/pharmacies'

      click_on 'New Pharmacy'
      fill_in 'Name', with: 'Ultimo Chemist Plus'

      click_on 'Add an open period'
      fill_in 'Day', with: 'Thursday'
      fill_in 'Time from', with: '09:00 am'
      fill_in 'Time to', with: '08:00 pm'

      click_on 'Create Pharmacy'
      expect(page).to have_content 'successfully created'

      click_on 'Back'
      within('tr', text: 'Ultimo Chemist Plus') do
        click_on 'Show'
      end
      expect(page).to have_content 'Thursday'
    end
  end
  ```

This functionality requires JavaScript, but the basic configuration we have set
up does not allow us to execute JavaScript on our pages. Note the `js: true`
added at the top. We are telling Capybara to execute this acceptance test using
a *driver* that supports JavaScript. There are lots of drivers Capybara can use
to do automated browser testing. To give you an idea,

* the default option, `racktest`, uses something a bit like RSpec controller
  tests to make GET and POST requests to your app,
* the `Selenium` driver pops open Firefox and remotely controls it, and
* the `Poltergeist` driver does the same thing with a browser library called
  Webkit, without actually popping up the browser window (such drivers are
  called "headless" because they have no visible window).

One problem we'll face is that we'll need to clean out our test database before
we run each acceptance test. Otherwise the data we add in our acceptance test
script will accumulate each time we run the test. Data from previous tests may
even make the current acceptance test fail. That is what we added the
`database_cleaner` gem for. But we have to configure it.

Create a file `spec/support/database_cleaner.rb`

  ```ruby
  RSpec.configure do |config|

    config.use_transactional_fixtures = false

    config.before(:suite) do
      DatabaseCleaner.clean_with(:truncation)
    end

    config.before(:each) do |example|
      DatabaseCleaner.strategy = example.metadata[:js] ? :truncation : :transaction
      DatabaseCleaner.start
    end

    config.after(:each) do
      DatabaseCleaner.clean
    end

  end
  ```

Add to `spec/rails_helper.rb` at the bottom.

  ```ruby
  require './spec/support/database_cleaner'
  ```

### Implement the acceptance test

Update `app/models/pharmacy.rb`

  ```ruby
  accepts_nested_attributes_for :open_periods, allow_destroy: true
  ```

Update `app/controllers/pharmacies_controller.rb`

  ```ruby
  params.require(:pharmacy).permit(:name, open_periods_attributes: [:id, :day, :time_from, :time_to, :_destroy])
  ```

Update `app/views/pharmacies/_form.html.erb`

  ```erb
  <%= nested_form_for(@pharmacy) do |f| %>
  ```

  ```erb
  <%= f.fields_for :open_periods do |open_period_form| %>
    <%= open_period_form.label :day %>
    <%= open_period_form.text_field :day %>

    <%# some other stuff here ... %>

    <%= open_period_form.link_to_remove "Remove this open period" %>
  <% end %>
  <p><%= f.link_to_add "Add an open period", :open_periods %></p>
  ```

Add to `app/assets/javascripts/application.js`:

  ```js
  //= require jquery_nested_form
  ```

Run the test and get it passing. You may have to implement more Rails code before it passes. You may also have to install Firefox if you don't already have it.

  ```
  rspec spec/features/manage_pharmacies_spec.rb
  ```

Notice the way a Firefox window pops up and runs your test.

