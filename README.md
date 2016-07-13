# Consuming and Testing External APIs

### Consuming APIs

We'll be using a Rails app, but it certainly isn't required. In many cases, a RESTful API can be accessed just like any other website.

```sh
curl http://hipsterjesus.com/api
```

If we visit the API endpoint in our browser, we'll be able to see the JSON output directly. (**Pro Tip:** Get the [JSONView browser](https://chrome.google.com/webstore/detail/jsonview/chklaanhfefbnpoihckbnefhakgolnmc?hl=en) extension for Chrome)

Basically, we are just visiting a website using Ruby, and then doing stuff with the output. We can use any number of HTTP clients to GET (and POST) info from external websites. Today, we'll be using [HTTParty](https://github.com/jnunemaker/httparty).

HTTParty is straightforward to use right away.

From the app, run `rails c`, which loads our entire dev environment, including the `HTTParty` gem.

`HTTParty.get("http://hipsterjesus.com/api")`

There are more features of HTTParty that we'll probably use:
- Constructing URIs dynamically
- Using ENV / tokens
- Doing stuff with the response

### Testing APIs

Typically, we will make the actual external API calls within a Ruby object
