# Consuming and Testing External APIs

### Consuming APIs

We'll be using a Rails app, but it certainly isn't required. In many cases, a RESTful API can be accessed just like any other website.

```sh
curl http://hipsterjesus.com/api
```

You should see a JSON output in the terminal.

If we visit the API endpoint in our browser, we'll be able to see the JSON output directly. (**Pro Tip:** Get the [JSONView browser](https://chrome.google.com/webstore/detail/jsonview/chklaanhfefbnpoihckbnefhakgolnmc?hl=en) extension for Chrome)

### Using HTTP Clients

Basically, we are just visiting a website using Ruby, and then doing stuff with the output. To access a website in Ruby, we need to use an HTTP client.
HTTP clients allow us to GET (and POST or otherwise interact with) info from external websites. There are a number of HTTP clients out there that wrap Ruby's native [`Net:HTTP` library](http://ruby-doc.org/stdlib-2.3.1/libdoc/net/http/rdoc/Net/HTTP.html).

Today, we'll be using [HTTParty](https://github.com/jnunemaker/httparty). HTTParty is pretty straightforward to use immediately.

From the app, run `rails c`, which loads our entire dev environment, including the `HTTParty` gem.

`HTTParty.get("http://hipsterjesus.com/api")`

Alternately, if `HTTParty` is installed on your machine, you can even go right into Pry - no Ruby file or Rails app needed!

```sh
$ > pry
$ [1] pry(main)> require 'HTTParty'
=> true
$ [2] pry(main)> HTTParty.get("http://hipsterjesus.com/api")
```

### Where in my Rails app...?

Since HTTP calls can happen from anywhere, we typically wrap them in their own Ruby object. In a Rails app, this Ruby class might live in the `lib` folder, or it might be a model that **does not inherit from `ActiveRecord::Base`**. This is sometimes referred to as a **Plain Old Ruby Object** (PORO).

### Building Objects to Handle External API Interactions

We want to build a class that makes that call for us, which we could then access from controllers or other models in our app.

```ruby
class HipsterIpsum
  include HTTParty
  base_uri "http://hipsterjesus.com"

  def fetch_data
    # this is the same as `HTTParty.get("http://hipsterjesus.com")`
    self.class.get("/api")
  end

  # this handles the output
  def hipster_text
    fetch_data["text"]
  end
end
```

If the output is complex, we may have a separate class that wraps the response in an object.

```ruby
class Hipster
  attr_reader :text, :type

  def initialize
    @text = text
    @type = type
  end

  def text
    get_hipster_data["text"]
  end

  def type
    get_hipster_data["params"]["type"]
  end

  private

  def get_hipster_data
    @hipster_data ||= HipsterIpsum.new.fetch_data
  end
end
```

### Working with External APIs

Half the battle is reading the docs. For example, HTTParty provides an example using the [StackExcahnge API](https://api.stackexchange.com/docs)

```ruby
class StackExchange
  include HTTParty
  base_uri 'api.stackexchange.com'

  def initialize(service, page)
    @options = { query: { site: service, page: page } }
  end

  def questions
    # the options hash gets converted into a query string
    self.class.get("/2.2/questions", @options)
  end

  def users
    self.class.get("/2.2/users", @options)
  end
end

stack_exchange = StackExchange.new("stackoverflow", 1)
stack_exchange.questions
```

This is the URL we get:
http://api.stackexchange.com/2.2/questions?site=stackoverflow&page=1

### Testing APIs

[![matrix of testing approaches](testing_type_matrix.jpg)](https://github.com/JoelQ/weekly-iteration-faking-apis)  
Source: https://github.com/JoelQ/weekly-iteration-faking-apis

The idea is that we do not want to make requests to an external resource every time we run our tests, for a variety of reasons. From a practical standpoint:

- APIs may rate-limit your usage, and you'll burn through your allotted usage each time you run your tests
- You need to be connected to the Internet
- It takes longer
- APIs don't change that often
- You really care about your code working with the **data structure** that the API returns

We will cover the **Real** test cases, as opposed to the **Stubbed** cases. We won't get into why to use Real vs. Stubbed, as that is an entire conversation in itself. Since the "Real" test cases are (naturally) closer to reality without actually making the API call, we'll cover those.

### Real HTTP Request to Fake HTTP Service

[VCR](https://github.com/vcr/vcr) is a gem that intercepts any outgoing HTTP requests from our app (in test) and returns a fake HTTP response that is stored in a YAML file (`cassette`).

TODO: add code example after clinic

### Fake Adapter

Instead of a fake HTTP response, we never make an HTTP call at all. We swap out the class (aka PORO) that makes the call and return just the results that we are looking for.

TODO: add code example after clinic

### Additional Resources

- [Faking Third-Party APIs](https://github.com/justinhuynh/weekly-iteration-faking-apis)
- [Horizon Lesson: Consuming Web APIs](https://learn.launchacademy.com/lessons/consuming-web-apis)
