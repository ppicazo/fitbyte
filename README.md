# Fitbyte

[![Gem Version](https://badge.fury.io/rb/fitbyte.svg)](https://badge.fury.io/rb/fitbyte)
[![Build Status](https://travis-ci.org/zokioki/fitbyte.svg?branch=master)](https://travis-ci.org/zokioki/fitbyte)

This gem allows interaction with [Fitbit's REST API](https://dev.fitbit.com/docs/basics/).

**NOTE:** Fitbit's API is currently in beta, and is in active development. Breaking changes to certain endpoints may be introduced during early development of this gem, until Fitbit's API solidifies.

## Installation

To install the latest release:

    $ gem install fitbyte

To include in a Rails project, add it to the Gemfile:

```ruby
gem "fitbyte"
```

## Usage

To use the Fitbit API, you must register your application at [dev.fitbit.com](https://dev.fitbit.com/apps). After registering, you should have access to **CLIENT ID**, **CLIENT SECRET**, and **REDIRECT URI (Callback URL)** values for use in instantiating a *Fitbyte::Client* object.

- Create a client instance:

```ruby
client = Fitbyte::Client.new(client_id: my_client_id,
                             client_secret: my_client_secret,
                             redirect_uri: "http://example.com/handle/callback")
```

- Generate a link for the Fitbit authorization page:

```ruby
client.auth_page_link
# => https://fitbit.com/oauth2/authorize?client_id=123XYZ&redirect_uri=...
```

- Follow generated link to Fitbit's authorization page. After approving your app, you're sent to the `redirect_uri`, with an appended authorization `code` param, which you'll exchange for an access token:

```ruby
client.get_token(auth_code)
```

You're now authenticated and can make calls to Fitbit's API:

```ruby
client.food_logs Date.today
# => #<Fitbyte::FitStruct foods=[#<Fitbyte::FitStruct isFavorite=true, logDate="2015-06-26", logId=1820, loggedFood=#<Fitbyte::FitStruct accessLevel="PUBLIC", amount=132.57, brand="", calories=752, ...]
```

If your JSON library allows, the default format for resulting data returns OpenStruct-based FitStruct objects, allowing for more convenient method-like attribute access.

To return the original JSON, `raw: true` can be specified as an option:

```ruby
client.food_logs Date.today, raw: true
# => { :foods => [{ :isFavorite => true, :logDate => "2015-06-26", :logId => 1820, :loggedFood => { :accessLevel => "PUBLIC", :amount => 132.57, :brand => "", :calories => 752, ...}] }
```

### Options

When initializing a `Fitbyte::Client` instance, you're given access to a handful of options:

- `:api_version` - API version to be used when making requests (default: "1")

---
- `:unit_system` - The measurement unit system to use for response values (default: "en_US" | available: "en_US", "en_GB", and "any" for metric)

---
- `:locale` - The locale to use for response values (default: "en_US" | available: "en_US", "fr_FR", "de_DE", "es_ES", "en_GB", "en_AU", "en_NZ" and "ja_JP")

---
- `:scope` - A space-delimited list of the permissions you are requesting (default: "activity nutrition profile settings sleep social weight" | available: "activity", "heartrate", "location", "nutrition", "profile", "settings" "sleep", "social" and "weight")

---
- `:raw_response` - Setting this option to `true` returns response values on subsequent calls as parsed JSON; by default, response values use FitStruct objects, for convenient method-like attribute access (default: false | available: true, false)

---

## License

This gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
