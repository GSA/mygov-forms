[![Build Status](https://api.travis-ci.org/GSA-OCSIT/mygov-forms.png?branch=master)](http://travis-ci.org/GSA-OCSIT/mygov-forms)

# MyUSA Forms Engine

MyUSA Forms Engine is a service for governments to host online forms and securely store the information submitted.

## Setup

1.  Copy config/database.yml.example to config/database.yml and configure to work with your development database.

2.  Copy config/initializers/01_mygov_forms.rb.example to config/initializers/01_mygov_forms.rb.

3.  Run 'rake secret', and update the config/initializers/01_mygov_forms.rb file with the value.

## Running RSpec

Run 'rake spec' to run RSpec tests.

## Deployment with Capistrano

Copy the config/deploy.rb.example file to config/deploy.rb and edit it to reflect your deployment scenario.

## Pull requests

Pull requests will gladly be accepted, provided they come with 100% test coverage.