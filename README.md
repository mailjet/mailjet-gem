![alt text](https://www.mailjet.com/images/email/transac/logo_header.png "Mailjet")

# Official Mailjet Ruby wrapper

[![Build Status](https://travis-ci.org/mailjet/mailjet-gem.svg?branch=master)](https://travis-ci.org/mailjet/mailjet-gem)

<!--

[![Build Status](https://secure.travis-ci.org/jbescoyez/mailjet.png?branch=master)][travis]
[![Dependency Status](https://gemnasium.com/jbescoyez/mailjet.png)][gemnasium]
[![Maintainance status](http://stillmaintained.com/jbescoyez/mailjet.png)][stillmaintained]
![Current Version](https://img.shields.io/badge/version-1.5.0-green.svg)

-->

[travis]: http://travis-ci.org/jbescoyez/mailjet
[gemnasium]: https://gemnasium.com/jbescoyez/mailjet
[stillmaintained]: http://stillmaintained.com/jbescoyez/mailjet
[mailjet]: http://www.mailjet.com
[rubinius]: http://rubini.us/
[ree]: http://www.rubyenterpriseedition.com/
[jruby]: http://jruby.org/
[mailjetter]: https://github.com/holinnn/mailjetter/
[activeresource]: https://github.com/rails/activeresource
[apidoc]: http://dev.mailjet.com/guides
[apidoc-recipient]: http://mjdemo.poxx.net/~shubham/listrecipient.html?utm_source=github&utm_medium=link&utm_content=readme&utm_campaign=mailjet-gem
[camelcase-api]: http://api.rubyonrails.org/classes/String.html#method-i-camelcase
[underscore-api]: http://api.rubyonrails.org/classes/String.html#method-i-underscore
[actionmailerdoc]: http://guides.rubyonrails.org/action_mailer_basics.html#sending-emails-with-dynamic-delivery-options
[send-api-doc]: http://dev.mailjet.com/guides/?ruby#choose-sending-method
[v1-branch]: https://github.com/mailjet/mailjet-gem/tree/v1
[mailjet_doc]: http://dev.mailjet.com/guides/?ruby#
[api_doc]: https://github.com/mailjet/api-documentation

<!-- You can read this readme file in other languages:
english | [french](./README.fr.md) -->

## Overview

This repository contains the official Ruby wrapper for the Mailjet API, bootstraped with [Mailjetter][mailjetter].

Check out all the resources and Ruby code examples in the [Offical Documentation](https://dev.mailjet.com/guides/?ruby#getting-started).


## Table of contents

- [Compatibility](#compatibility)
- [Installation](#installation)
  - [Rubygems](#rubygems)
  - [Bundler](#bundler)
- [Authentication](#authentication)
- [Make your first call](#make-your-first-call)
- [Call configuration specifics](#call-configuration-specifics)
  - [API versioning](#api-versioning)
  - [Base URL](#base-url)
- [List of resources](#list-of-resources)
  - [Naming conventions](#naming-conventions)
- [Request examples](#request-examples)
  - [POST request](#post-request)
    - [Simple POST request](#simple-post-request)
    - [Using actions](#using-actions)
  - [GET request](#get-request)
    - [Retrieve all objects](#retrieve-all-objects)
    - [Use filtering](#use-filtering)
    - [Retrieve a single object](#retrieve-a-single-object)
    - [Retrieve the count of objects matching the query](retrieve-the-count-of-objects-matching-the-query)
    - [Retrieve the first object matching the query](retrieve-the-first-object-matching-the-query)
  - [PUT request](#put-request)
  - [DELETE request](#delete-request)
- [Send emails with ActionMailer](#send-emails-with-actionmailer)
- [Track email delivery](#track-email-delivery)
- [Testing](#testing)
- [Contribute](#contribute)

## Compatibility

This library requires **Ruby v2.2.X**.

The Rails ActionMailer integration is designed for Rails 3.X and 4.X.

## Installation

### Rubygems

Use the below command to install the wrapper.

```bash
$ gem install mailjet
```

### Bundler

Add the following in your Gemfile:

```ruby
# Gemfile
gem 'mailjet'
```

If you wish to use the most recent release from Github, add the following in your Gemfile instead:

```ruby
#Gemfile
gem 'mailjet', :git => 'https://github.com/mailjet/mailjet-gem.git'
```

Then let the bundler magic happen:

```bash
$ bundle install
```

##  Authentication

The Mailjet Email API uses your API and Secret keys for authentication. [Grab](https://app.mailjet.com/account/api_keys) and save your Mailjet API credentials by adding them to an initializer:

```ruby
# initializers/mailjet.rb
Mailjet.configure do |config|
  config.api_key = 'your-api-key'
  config.secret_key = 'your-secret-key'
  config.default_from = 'my_registered_mailjet_email@domain.com'
end
```

`default_from` is optional if you send emails with [`:mailjet`'s SMTP](https://github.com/mailjet/mailjet-gem#send-emails-with-actionmailer).

But if you are using Mailjet with Rails, you can simply generate it:

```shell
$ rails generate mailjet:initializer
```

## Make your first call

Here's an example on how to send an email:

```ruby
require 'mailjet'
Mailjet.configure do |config|
  config.api_key = ENV['MJ_APIKEY_PUBLIC']
  config.secret_key = ENV['MJ_APIKEY_PRIVATE']  
  config.api_version = "v3.1"
end
variable = Mailjet::Send.create(messages: [{
    'From'=> {
        'Email'=> '$SENDER_EMAIL',
        'Name'=> 'Me'
    },
    'To'=> [
        {
            'Email'=> '$RECIPIENT_EMAIL',
            'Name'=> 'You'
        }
    ],
    'Subject'=> 'My first Mailjet Email!',
    'TextPart'=> 'Greetings from Mailjet!',
    'HTMLPart'=> '<h3>Dear passenger 1, welcome to <a href=\'https://www.mailjet.com/\'>Mailjet</a>!</h3><br />May the delivery force be with you!'
}]
)
p variable.attributes[:messages]
```

## Call Configuration Specifics

### API Versioning

The Mailjet API is spread among three distinct versions:

- `v3` - The Email API
- `v3.1` - Email Send API v3.1, which is the latest version of our Send API
- `v4` - SMS API (not supported in this library yet)

Since most Email API endpoints are located under `v3`, it is set as the default one and does not need to be specified when making your request. For the others you need to specify the version using `api_version`. For example, if using Send API `v3.1`:

```ruby
require 'mailjet'
Mailjet.configure do |config|
  config.api_key = ENV['MJ_APIKEY_PUBLIC']
  config.secret_key = ENV['MJ_APIKEY_PRIVATE']  
  config.api_version = "v3.1"
end
```

### Base URL

The default base domain name for the Mailjet API is `https://api.mailjet.com`. You can modify this base URL by setting a value for `end_point` in your call:

```ruby
Mailjet.configure do |config|
  config.api_key = ENV['MJ_APIKEY_PUBLIC']
  config.secret_key = ENV['MJ_APIKEY_PRIVATE']  
  config.api_version = "v3.1"
  config.end_point = "https://api.us.mailjet.com"
end
```

If your account has been moved to Mailjet's **US architecture**, the URL value you need to set is `https://api.us.mailjet.com`.

## List of resources

You can find the list of all available resources for this library, as well as their configuration, in [/lib/mailjet/resources](https://github.com/mailjet/mailjet-gem/tree/master/lib/mailjet/resources).

### Naming conventions

- Class names' first letter is capitalized followed by the rest of the resource name in lowercase (e.g. `listrecipient` will be `Listrecipient` in ruby)
- Ruby attribute names are the underscored versions of API attributes names (e.g. `IsActive` will be `is_active` in ruby)

## Request examples

### POST Request

Use the `create` method of the Mailjet CLient (i.e. `variable = Mailjet::$resource.create($params)`).

`$params` will be a list of properties used in the request payload.

#### Simple POST request

```ruby
# Create a new contact:
require 'mailjet'
Mailjet.configure do |config|
  config.api_key = ENV['MJ_APIKEY_PUBLIC']
  config.secret_key = ENV['MJ_APIKEY_PRIVATE']  
end
variable = Mailjet::Contact.create(email: "Mister@mailjet.com"
)
p variable.attributes['Data']
```

#### Using actions

Some APIs allow the use of action endpoints. To use them in this wrapper, the API endpoint is in the beginning, followed by an underscore, followed by the action you are performing - e.g. `Contact_managecontactslists`.

Use `id` to specify the ID you want to apply a POST request to (used in case of action on a resource).

```ruby
# Manage the subscription status of a contact to multiple lists
require 'mailjet'
Mailjet.configure do |config|
  config.api_key = ENV['MJ_APIKEY_PUBLIC']
  config.secret_key = ENV['MJ_APIKEY_PRIVATE']  
end
variable = Mailjet::Contact_managecontactslists.create(id: $ID, contacts_lists: [{
    'ListID'=> '$ListID_1',
    'Action'=> 'addnoforce'
}, {
    'ListID'=> '$ListID_2',
    'Action'=> 'addforce'
}]
)
p variable.attributes['Data']
```

### GET request

#### Retrieve all objects

Use the `.all` method of the Mailjet CLient (i.e. `Mailjet::$resource.all()`) to retrieve all objects you are looking for. By default, `.all` will retrieve only 10 objects - you have to specify `limit: 0` if you want to GET them all (up to 1000 objects).

```ruby
> recipients = Mailjet::Listrecipient.all(limit: 0)
```

#### Use filtering

You can refine queries using API filters, as well as the following parameters:

- `format`: `:json`, `:xml`, `:rawxml`, `:html`, `:csv` or `:phpserialized` (default: `:json`)
- `limit`: integer (default: `10`)
- `offset`: integer (default: `0`)
- `sort`: `[[:property, :asc], [:property, :desc]]`

```ruby
# To retrieve all contacts from contact list ID 123:
> variable = Mailjet::Contact.all(limit: 0, contacts_list: 123)
```

#### Retrieve a single object

Use the `.find` method to retrieve a specific object. Specify the ID of the object inside the parentheses.

```ruby
# Retrieve a specific contact ID.
require 'mailjet'
Mailjet.configure do |config|
  config.api_key = ENV['MJ_APIKEY_PUBLIC']
  config.secret_key = ENV['MJ_APIKEY_PRIVATE']  
end
variable = Mailjet::Contact.find($CONTACT_EMAIL)
p variable.attributes['Data']
```

#### Retrieve the count of objects matching the query

```ruby
> Mailjet::Contact.count
=> 83
```

#### Retrieve the first object matching the query

```ruby
> Mailjet::Contact.first
=> #<Mailjet::Contact>
````

### PUT request

A `PUT` request in the Mailjet API will work as a `PATCH` request - the update will affect only the specified properties. The other properties of an existing resource will neither be modified, nor deleted. It also means that all non-mandatory properties can be omitted from your payload.

Here's an example of a PUT request:

```ruby
> recipient = Mailjet::Listrecipient.first
=> #<Mailjet::Listrecipient>
> recipient.is_active = false
=> false
> recipient.attributes
=> {...} # attributes hash
> recipient.save
=> true
> recipient.update_attributes(is_active: true)
=> true
```

### DELETE request

Here's an example of a `DELETE` request:

```ruby
> recipient = Mailjet::Listrecipient.first
=> #<Mailjet::Listrecipient>
> recipient.delete
> Mailjet::Listrecipient.delete(123)
=> #<Mailjet::Listrecipient>
```

Upon a successful `DELETE` request the response will not include a response body, but only a `204 No Content` response code.

## Send emails with ActionMailer

A quick walkthrough to use Rails Action Mailer [here](http://guides.rubyonrails.org/action_mailer_basics.html).

First set your delivery method (here Mailjet SMTP relay servers):

```ruby
# application.rb or config/environments specific settings, which take precedence
config.action_mailer.delivery_method = :mailjet

```

Or if you prefer sending messages through [Mailjet Send API](http://dev.mailjet.com/guides/#send-transactional-email):

```ruby
# application.rb
config.action_mailer.delivery_method = :mailjet_api
```

You can use Mailjet specific options with `delivery_method_options` as detailed in the official [ActionMailer doc](http://guides.rubyonrails.org/action_mailer_basics.html#sending-emails-with-dynamic-delivery-options):

```ruby
class AwesomeMailer < ApplicationMailer

  def awesome_mail(user)

    mail(
      to: user.email,
      delivery_method_options: { api_key: 'your-api-key', secret_key: 'your-secret-key' }
    )
  end
end
```

Keep in mind that to use the latest version of the Send API, you need to specify the version via `delivery_method_options`:

```ruby
delivery_method_options: { version: 'v3.1' }
```

Other supported options are:

```ruby
# For v3_1 API

* :api_key
* :secret_key
* :'Priority'
* :'CustomCampaign'
* :'DeduplicateCampaign'
* :'TemplateLanguage'
* :'TemplateErrorReporting'
* :'TemplateErrorDeliver'
* :'TemplateID'
* :'TrackOpens'
* :'TrackClicks'
* :'CustomID'
* :'EventPayload'
* :'Variables'
* :'Headers'

# For v3_0 API

* :recipients
* :'mj-prio'
* :'mj-campaign'
* :'mj-deduplicatecampaign'
* :'mj-templatelanguage'
* :'mj-templateerrorreporting'
* :'mj-templateerrordeliver'
* :'mj-templateid'
* :'mj-trackopen'
* :'mj-trackclick',
* :'mj-customid'
* :'mj-eventpayload'
* :vars
* :headers
```

Otherwise, you can pass the custom Mailjet SMTP headers directly:
```ruby
headers['X-MJ-CustomID'] = 'rubyPR_Test_ID_1469790724'
headers['X-MJ-EventPayload'] = 'rubyPR_Test_Payload'
headers['X-MJ-TemplateLanguage'] = 'true'
```

Creating a Mailer:
```ruby
$ rails generate mailer UserMailer

create  app/mailers/user_mailer.rb
create  app/mailers/application_mailer.rb
invoke  erb
create    app/views/user_mailer
create    app/views/layouts/mailer.text.erb
create    app/views/layouts/mailer.html.erb
invoke  test_unit
create    test/mailers/user_mailer_test.rb
create    test/mailers/previews/user_mailer_preview.rb
```

In the UserMailer class you can set up your email method:
```ruby
#app/mailers/user_mailer.rb
class UserMailer < ApplicationMailer
  def welcome_email()
     mail(from: "me@mailjet.com", to: "you@mailjet.com",
          subject: "This is a nice welcome email")
   end
end
```

Next, create your templates in the views folder:
```ruby
#app/views/user_mailer/welcome_email.html.erb
Hello world in HTML!

#app/views/user_mailer/welcome_email.text.erb
Hello world in plain text!
```

There's also the ability to set [Mailjet custom headers](http://dev.mailjet.com/guides/#send-api-json-properties)
```ruby
#app/mailers/user_mailer.rb
class UserMailer < ApplicationMailer
  def welcome_email()
    headers['X-MJ-CustomID'] = 'custom value'
    headers['X-MJ-EventPayload'] = 'custom payload'

    mail(
    from: "me@mailjet.com",
    to: "you@mailjet.com",
    subject: "This is a nice welcome email"
    )
  end
end
```
For sending email, you can call the method:
```ruby
# In this example, we are sending the email immediately
UserMailer.welcome_email.deliver_now!
```

For more information on `ActionMailer::MessageDelivery`, see the documentation [HERE](http://edgeapi.rubyonrails.org/classes/ActionMailer/MessageDelivery.html)

## Track email delivery

You can setup your Rack application in order to receive feedback on emails you sent (clicks, etc.)

First notify Mailjet of your desired endpoint (say: 'http://www.my_domain.com/mailjet/callback') at https://www.mailjet.com/account/triggers

Then configure Mailjet's Rack application to catch these callbacks.

A typical Rails/ActiveRecord installation would look like that:

```ruby
# application.rb

config.middleware.use Mailjet::Rack::Endpoint, '/mailjet/callback' do |params|  # using the same URL you just set in Mailjet's administration

  email = params['email'].presence || params['original_address'] # original_address is for typofix events

  if user = User.find_by_email(email)
    user.process_email_callback(params)
  else
    Rails.logger.fatal "[Mailjet] User not found: #{email} -- DUMP #{params.inspect}"
  end
end

# user.rb
class User < ActiveRecord::Base

  def process_email_callback(params)

    # Returned events and options are described at https://eu.mailjet.com/docs/event_tracking
    case params['event']
    when 'open'
      # Mailjet's invisible pixel was downloaded: user allowed for images to be seen
    when 'click'
      # a link (tracked by Mailjet) was clicked
    when 'bounce'
      # is user's email valid? Recipient not found
    when 'spam'
      # gateway or user flagged you
    when 'blocked'
      # gateway or user blocked you
    when 'typofix'
      # email routed from params['original_address'] to params['new_address']
    else
      Rails.logger.fatal "[Mailjet] Unknown event #{params['event']} for User #{self.inspect} -- DUMP #{params.inspect}"
    end
  end
```

Note that since it's a Rack application, any Ruby Rack framework (say: Sinatra, Padrino, etc.) is compatible.

## Testing

For maximum reliability, the gem is tested against Mailjet's server for some parts, which means that valid credentials are needed.
Do NOT use your production account (create a new one if needed), because some tests are destructive.

```yml
# GEM_ROOT/config.yml
mailjet:
  api_key: YOUR_API_KEY
  secret_key: YOUR_SECRET_KEY
  default_from: YOUR_REGISTERED_SENDER_EMAIL # the email you used to create the account should do it
```

Then at the root of the gem, simply run:

```bash
bundle
bundle exec rake
```

## Contribute

Mailjet loves developers. You can be part of this project!

This wrapper is a great introduction to the open source world, check out the code!

Feel free to ask anything, and contribute:

 - Fork the project.
 - Create a new branch.
 - Implement your feature or bug fix.
 - Add documentation for it.
 - Add specs for your feature or bug fix.
 - Commit and push your changes.
 - Submit a pull request. Please do not include changes to the gemspec, or version file.

 If you have suggestions on how to improve the guides, please submit an issue in our [Official API Documentation repo](https://github.com/mailjet/api-documentation).
