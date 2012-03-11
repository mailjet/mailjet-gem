# Mailjet

[Maijet][mailjet]'s official Ruby wrapper.

Bootstraped with [Mailjetter][mailjetter].

<!-- [![Build Status](https://secure.travis-ci.org/jbescoyez/mailjet.png?branch=master)][travis] 
[![Dependency Status](https://gemnasium.com/jbescoyez/mailjet.png)][gemnasium]
[![Maintainance status](http://stillmaintained.com/jbescoyez/mailjet.png)][stillmaintained]
-->
[travis]: http://travis-ci.org/jbescoyez/mailjet
[gemnasium]: https://gemnasium.com/jbescoyez/mailjet
[stillmaintained]: http://stillmaintained.com/jbescoyez/mailjet 
[mailjet]: http://www.mailjet.com
[rubinius]: http://rubini.us/
[ree]: http://www.rubyenterpriseedition.com/
[jruby]:http://jruby.org/
[mailjetter]:https://github.com/holinnn/mailjetter/

<!-- You can read this readme file in other languages:
english | [french](./README.fr.md) -->

This gem is tested against:

This gem helps you to:

* Send transactional emails through Mailjet API in Rails 3
* Manage your lists, contacts and campaigns
* Track email delivery through event API

Compatibility: Rails 3.x

Supported Ruby Versions:

This library aims to support<!-- and is [tested against][travis]--> the following Ruby
implementations:

* Ruby 1.8.7
* Ruby 1.9.2
* Ruby 1.9.3
* [Rubinius][]
* [Ruby Enterprise Edition][ree]
* [JRuby][jruby]

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

## Send an email via ActionMailer

It is as easy as:

```ruby
# application.rb
config.action_mailer.delivery_method = :mailjet

# initializers/mailjet.rb
Mailjet.configure do |config|
  config.api_key = 'your-api-key'
  config.secret_key = 'your-secret-key'
  config.domain = 'my_domain.com' # optional
end
```

And you can start sending emails through Mailjet.

**API key** : you can get the API key through the mailjet interface in _Account/Master API key_


## Manage your campaigns

### Contacts

#### Filter your contacts

```ruby
> contacts = Mailjet::Contact.all(status: 'active', start: 100, limit: 2)
=> [#<Mailjet::Contact>, #<Mailjet::Contact>]
```

*All parameters and attributes on https://eu.mailjet.com/docs/api/contact/list*

#### Contacts opening your messages

```ruby
> Mailjet::Contact.openers(status: 'active', start: 100, limit: 50)
=> [#<Mailjet::Contact>, #<Mailjet::Contact>]
```

Notice: This should be integrated to `Contact.all`

*All parameters and attributes on https://eu.mailjet.com/docs/api/contact/openers*

#### More info about your contacts

```ruby
> contacts[0].info
=> {blocked: 12, click: 1, email: 'test@mailjet.com'}
```

*All parameters and attributes on https://eu.mailjet.com/docs/api/contact/infos*

### Lists

#### Create a new list

```ruby
> list = Mailjet::List.create(label: 'my_mailjet_list', name: "My Mailjet list")
```

*All parameters and attributes on https://eu.mailjet.com/docs/api/lists/create*

#### Update a list

```ruby
> list = Mailjet::List.update(label: 'my_updated_mailjet_list', name: "My updated Mailjet list")
```

*All parameters and attributes on https://eu.mailjet.com/docs/api/lists/update*

#### List your lists

```ruby
> Mailjet::List.all(limit: 10, start: 0, orderby: 'id ASC')
```

*All parameters and attributes on https://eu.mailjet.com/docs/api/lists/all*

#### Add contacts to your list

```ruby
> list.add_contacts("test@mailjet.com", "test2@mailjet.com", force: true  )
=> 200
```

*All parameters and attributes on https://eu.mailjet.com/docs/api/lists/addmanycontacts*

#### Show all contacts within a list

```ruby
> list.contacts
=> [#<Mailjet::Contact>, #<Mailjet::Contact>]
```

*All parameters and attributes on https://eu.mailjet.com/docs/api/lists/contacts*

#### Delete a list

```ruby
> list.delete
=> 200
```

*All parameters and attributes on https://eu.mailjet.com/docs/api/lists/delete*

#### Direct list email

```ruby
> list.email
=> "jk324jlO3N32203@lists.mailjet.com"
```

*All parameters and attributes on https://eu.mailjet.com/docs/api/lists/email*

#### Remove contacts from a list

```ruby
> list.remove_contacts("test@mailjet.com", "test2@mailjet.com")
=> 200
```

*All parameters and attributes on https://eu.mailjet.com/docs/api/lists/removemanycontacts*

#### Get statistics

```ruby
> list.statistics
=> {active: 20, bounce: 1, click: 14, created_at: "2012-02-02 21:59:59", ...}
```

*All parameters and attributes on https://eu.mailjet.com/docs/api/lists/statistics*

### Campaigns

#### Create a new campaign:

```ruby
> campaign = MailJet::Campaign.create(title: "My Mailjet Campaign")
```

*All parameters and attributes on https://eu.mailjet.com/docs/api/message/createcampaign*

#### List your campaigns:

```ruby
> campaigns = MailJet::Campaign.all(start: 10, limit: 20)
=> [#<Mailjet::Campaign>, #<Mailjet::Campaign>, ...]
```

*All parameters and attributes on https://eu.mailjet.com/docs/api/message/campaigns*

#### Find one campaign:

```ruby
> campaigns = MailJet::Campaign.find(19)
=> #<Mailjet::Campaign>
```

*All parameters and attributes on https://eu.mailjet.com/docs/api/message/campaigns*

#### Update your campaign:

```ruby
> campaign.update(title: "My *new* Mailjet Campaign")
```

*All parameters and attributes on https://eu.mailjet.com/docs/api/message/updatecampaign*

#### Get all the subscribers in your campaign:

```ruby
> campaign.subscribers(limit: 2, start: 0, status: 'queued')
=> [#<Mailjet::Subscriber id: 123, email: 'test@mailjet.com', sent_at: "2012-02-02 21:59:59", status: 'queued'>, #<Mailjet::Subscriber id: 456, email: 'test2@mailjet.com', sent_at: "2012-02-02 23:13:02", status: 'queued'>]
```

*All parameters and attributes on https://eu.mailjet.com/docs/api/message/contacts*

#### Send the campaign the the associated contacts:

```ruby
> campaign.send!
=> 200
```

*All parameters and attributes on https://eu.mailjet.com/docs/api/message/sendcampaign*

#### Send a test email to specified email address:

```ruby
> campaign.test('test@mailjet.com')
=> 200 # response status
```

*All parameters and attributes on https://eu.mailjet.com/docs/api/message/testcampaign*

#### Get statistics:

```ruby
> campaign.statistics
=> { total: 200, bounce: 1, bounce_pct: 0.5, click: 10, click_pct: 5, open: 20, open_pct: 10, sent: 200, sent_pct: 100, spam: 1, spam_pct: 0.5, total: 200 }
```

*All parameters and attributes on https://eu.mailjet.com/docs/api/message/statistics*

#### Template categories:

```ruby
> Mailjet::TemplateCategory.all
=> [#<Mailjet::TemplateCategory id: 2, label: "basic", value: "Basic">, #<Mailjet::TemplateCategory id: 6, label: "design", value: "Design">]
```

*All parameters and attributes on https://eu.mailjet.com/docs/api/message/tplcategories*

#### Template models:

```ruby
> Mailjet::TemplateModel.all(category: 2, custom: true, locale: 'fr_FR')
=> [<#Mailjet::TemplateModel id: 4, name: "Text", header_link: "http:\/\/" ... ]
```

*All parameters and attributes on https://eu.mailjet.com/docs/api/message/tplmodels*

#### Get the raw HTML form a campaign:

```ruby
> campaign.html
=> "<html><head></head><body>Test</body></html>"
```

*All parameters and attributes on https://eu.mailjet.com/docs/api/message/htmlcampaign*

#### Duplicate a campaign:

```ruby
> new_campaign = campaign.duplicate(title: "Another Mailjet Campaign")
=> #<Mailjet::Campaign title: "Another Mailjet Campaign" ... >
```

*All parameters and attributes on https://eu.mailjet.com/docs/api/message/duplicatecampaign*

### Reporting

#### Get the list of all your clicks

```ruby
> clicks = Mailjet::Reporting.clicks(from: "test@domain.com")
=> [<#Mailjet::Click id: 4, click_delay: 1234, date: "2012-02-08", link: "", user_agent: "Mozilla/5.0 (Windows NT 5.1; rv:5.0) Gecko/20100101 Firefox/5.0"} ]
> clicks.first.contact
=> #<Mailjet::Contact id: 123, email: "test@mailjet.com">
> clicks.first.email
=> #<Mailjet::Email id: 123>
```

*All parameters and attributes on https://eu.mailjet.com/docs/api/report/click*

#### Info about domains your emails are sent to

```ruby
> Mailjet::Reporting.domains(start: 3, limit: 6)
=> [{bounce_rate: 0.1, clicked_rate: 0.2, ...}, {bounce_rate: 0.8, clicked_rate: 0.1, ...}]
```

*All parameters and attributes on https://eu.mailjet.com/docs/api/report/domain*

#### Clients used to open emails

```ruby
> Mailjet::Reporting.clients(start: 3, limit: 6)
=> [{client: "Gmail", open_rate: 0.1, platform: "Windows", ...}, {client: "Outlook", open_rate: 0.3, platform: "Windows", ...}]
```

*All parameters and attributes on https://eu.mailjet.com/docs/api/report/emailclients*

#### Info about email sent

```ruby
> Mailjet::Reporting.emails(from_domain: "domain.com", limit: 10)
=> [#<Mailjet::Email>, #<Mailjet::Email>, #<Mailjet::Email>, ...]
```

*All parameters and attributes on https://eu.mailjet.com/docs/api/report/emailsent*

#### Global stats about a set of emails

```ruby
> Mailjet::Reporting.statistics(from_domain: "domain.com", limit: 10)
=> { avg_clicked_delay: 123, avg_opened_rate: 0.432, blocked: 13, ...}
```

*All parameters and attributes on https://eu.mailjet.com/docs/api/report/emailstatistics*


#### Opened email Geolocation

```ruby
> Mailjet::Reporting.geolocation(from_domain: "domain.com", limit: 10)
=> [{click: 123, country: "France", open: 234}, {click: 9876, country: "US", open: 12345}]
```

*All parameters and attributes on https://eu.mailjet.com/docs/api/report/geoip*

#### User-Agents used to open emails

```ruby
> Mailjet::Reporting.agents(start: 3, limit: 6)
=> [{cnt_clicked: 123, part: 30, platform: "Windows", user_agent: "Mozilla/5.0 (Windows NT 5.1; rv:5.0) Gecko/20100101 Firefox/5.0"}, ...]
```

*All parameters and attributes on https://eu.mailjet.com/docs/api/report/useragents*

## Track email delivery

You can setup your Rack application in order to receive feedback on email you sent (clicks, etc.)

First notify Mailjet of your desired endpoint (say: 'http://www.my_domain.com/mailjet/callback') at https://www.mailjet.com/account/triggers

Then configure Mailjet's Rack application to catch these callbacks.

A typical Rails installation would look like that:

```ruby
# application.rb


# using the same URL you just set up in Mailjet's administration
config.middleware.use Mailjet::Rack::Endpoint, '/mailjet/callback' do |events| 

  if user = User.find_by_email(event[:email])
    user.process_email_callback(event)
  else
    Rails.logger.fatal "[Mailjet] User not found: '#{event[:email]}'"
  end
end
```

Note that since it's a Rack application, any Ruby Rack framework (say: Sinatra, Padrino, etc.) is compatible.

### Install

```ruby
# routes.rb

mount Mailjet::Engine => "/mailjet"
```

This will create the route `/mailjet/feedback` and will follow the events to the subscribed model.

Any model can subscribe Mailjet events. A typical example is the User model:

```ruby
# user.rb

class User < ActiveRecord::Base
  include Mailjet::Hook
  mailjet_hook :process_email_callback, email_field: :email

  private
  def process_email_callback(event, options)
    # process the callback here
  end
end
```

Returned events and options are described at https://eu.mailjet.com/docs/event_tracking


