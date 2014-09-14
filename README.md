# NYTimesAPI

Ruby wrapper for The New York Times API

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'NYTimesAPI'
```

Or install it yourself as:

```shell
$ gem install NYTimesAPI
```

## Usage

### Real State API

First initialize the object, using your api key:

```ruby
ny = NYTimesAPI::RealState.new "myawesomapikey"
```

###### Count

```ruby
result = ny.count "Manhattan", {date: "2007-07", bedrooms: 2, type: 3}
```

###### Percentiles

```ruby
result = ny.percentile "Manhattan", {date: "2007-07", bedrooms: 2, type: 3}
```

## Author

* Rodrigo Alves <rodrigovieira1994@gmail.com>

## Copyright

© 2014 Rodrigo Alves
