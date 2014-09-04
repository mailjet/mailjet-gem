# Mailjet

[Mailjet][mailjet]'s official Ruby wrapper, bootstraped with [Mailjetter][mailjetter].

<!--

[![Build Status](https://secure.travis-ci.org/jbescoyez/mailjet.png?branch=master)][travis]
[![Dependency Status](https://gemnasium.com/jbescoyez/mailjet.png)][gemnasium]
[![Maintainance status](http://stillmaintained.com/jbescoyez/mailjet.png)][stillmaintained]

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
[send-api-doc]: http://dev.mailjet.com/guides/send-api-guide/
[v1-branch]: https://github.com/mailjet/mailjet-gem/tree/v1

<!-- You can read this readme file in other languages:
english | [french](./README.fr.md) -->

This gem helps you to:

* Send transactional emails through Mailjet API in Rails 3/4
* Manage your lists, contacts and campaigns, and much more...
* Track email delivery through event API

Compatibility:

 - Ruby 1.9.X
 - Ruby 2.0.0

Rails ActionMailer integration designed for Rails 3.X and 4.X

IMPORTANT: Mailjet gem switched to API v3, the new API provided by Mailjet. For the wrapper for API v1, check the [v1 branch][v1-branch].

## Install

### Bundler

Add the following in your Gemfile:

```ruby
# Gemfile

gem 'mailjet'
```

and let the bundler magic happen

```bash
$ bundle install
```

### Rubygems

```bash
$ gem install mailjet
```

## Setup

### Api key

You need a proper account with [Mailjet][mailjet]. You can get the API key through the [Mailjet][mailjet] interface in _Account/Master API key_

Add the keys to an initializer:

```ruby
# initializers/mailjet.rb
Mailjet.configure do |config|
  config.api_key = 'your-api-key'
  config.secret_key = 'your-secret-key'
  config.default_from = 'my_registered_mailjet_email@domain.com'
end
```

`domain` is needed if you send emails with :mailjet's SMTP (below)

`default_from` is optional if you send emails with :mailjet's SMTP (below)

### Send emails with ActionMailer

As easy as:

```ruby
# application.rb
config.action_mailer.delivery_method = :mailjet

```

Or if you prefer sending messages through mailjet REST API:

```ruby
# application.rb
config.action_mailer.delivery_method = :mailjet_api
```

You can use mailjet specific options with `delivery_method_options` as detailed in the official [ActionMailer doc][actionmailerdoc]

## Manage your campaigns

This gem provide a convenient wrapper for consuming the mailjet API. The wrapper is highly inspired by [ActiveResource][activeresource] even though it does not depend on it.

You can find out all the resources you can access to in the [Official API docs][apidocs].

Let's have a look at the power of this thin wrapper

### Naming conventions

* Class names' first letter is capitalized followed by the rest of the resource name in lowercase (e.g. `listrecipient` will be `Listrecipient` in ruby)
* Ruby attribute names are the [underscored][underscore-api] versions of API attributes names (e.g. `IsActive` will be `is_active` in ruby)

### Wrapper REST API

Let's say we want to manage list recipients.

#### GET all the recipients in one query:

```ruby
> recipients = Mailjet::Listrecipient.all(limit: 0)
=> [#<Mailjet::Listrecipient>, #<Mailjet::Listrecipient>]
```

By default, `.all` will retrieve only 10 resources, so, you have to specify `limit: 0` if you want to GET them all.

You can refine queries using [API Filters][apidoc-recipient]`*` as well as the following parameters:

* format: `:json, :xml, :rawxml, :html, :csv` or `:phpserialized` (default: `:json`)
* limit: int (default: 10)
* offset: int (default: 0)
* sort: `[[:property, :asc], [:property, :desc]]`

#### GET the resources count

```ruby
> Mailjet::Listrecipient.count
=> 83
```

#### GET the first resource matching a query

```ruby
> Mailjet::Listrecipient.first
=> #<Mailjet::Listrecipient>
```

#### GET a resource from its id

```ruby
> recipient = Mailjet::Listrecipient.find(id)
=> #<Mailjet::Listrecipient>
```

#### Updating a resource

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

#### Deleting a resource
 ```ruby
> recipient = Mailjet::Listrecipient.first
=> #<Mailjet::Listrecipient>
> recipient.delete
> Mailjet::Listrecipient.delete(123)
=> #<Mailjet::Listrecipient>
 ```

## Send emails through API

In order to send emails through the API, you just have to `create` a new `MessageDelivery` resource.

```
Mailjet::MessageDelivery.create(from: "me@example.com", to: "you@example.com", subject: "Mailjet is awesome", text: "Yes, it is!")
```

If you want to send it to multiple recipients, just use an array:
```
Mailjet::MessageDelivery.create(from: "me@example.com", to: ["you@example.com", "someone-else@example.com"], subject: "Mailjet is awesome", text: "Yes, it is!")
```

In order to Mailjet modifiers, you cannot use the regular form of Ruby 2 hashes. Instead, use a String `e.g.: 'mj-prio' => 2` or a quoted symbol `e.g.: 'mj-prio' => 2`.

You can check available params in the [official doc][send-api-doc].

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
## Send a pull request

 - Fork the project.
 - Create a topic branch.
 - Implement your feature or bug fix.
 - Add documentation for your feature or bug fix.
 - Add specs for your feature or bug fix.
 - Commit and push your changes.
 - Submit a pull request. Please do not include changes to the gemspec, or version file.
