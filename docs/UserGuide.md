# Quick start

After installing you're ready to go

```smalltalk
Teapot on
    GET: '/welcome' -> 'Hello World!';
    start.
```

`Do it` and view [here](http://localhost:1701/welcome)

## User's guide

The most important concept of Teapot is the Route.

An example of a Route definition is:

`GET: '/url/*/pattern/<param>' -> someAction`

A route has three parts:

- HTTP method (`GET`, `POST`, `PUT`, `DELETE`, `HEAD`, `TRACE`, `CONNECT`,
  `OPTIONS`, `PATCH` or any)
- URL pattern (`/hi`, `/users/<name>`, `/foo/*/bar/*`, or a regexp)
- Action (block, message send or any object)

```smalltalk
Teapot on
    GET: '/hi' -> 'Bonjour!';
    GET: '/hi/<user>' -> [:req | 'Hello ', (req at: #user)];
    GET: '/say/hi/*' -> (Send message: #greet: to: greeter);
    start.

(ZnEasy get: 'http://localhost:1701/hi/user1') entity string. "Hello user1"
```

The Action part takes the HTTP request (optionally) and returns the response.
The response may undergo further transformations by a response transformer that
will construct the final HTTP response (`ZnResponse`).

```smalltalk
ZnRequest ⇨ [Router] ⇨ TeaRequest ⇨ [Route] ⇨ response ⇨ [Resp.Transformer] ⇨ ZnResponse
```

The response returned by the Action can be:

- Any Object that will be transformed by the given response transformer (e.g.
  html, ston, json, mustache, stream) to an HTTP response (`ZnResponse`).
- A `TeaResponse` that allows additional parameters to be added (response code, headers).
- A `ZnResponse` that will be handled directly by the `ZnServer` without further
  transformation.

The following 3 Routes produce the same output.

```smalltalk
GET: '/greet' -> [:req | 'Hello World!' ]
GET: '/greet' -> [:req | TeaResponse ok body: 'Hello World!' ]
GET: '/greet' -> [:req | 
    ZnResponse new
        statusLine: ZnStatusLine ok;        
        entity: (ZnEntity html: 'Hello World!');
        yourself ]
```

## How Routes are matched

The Routes are matched in the order they are defined. The first route that matches
the request method and the URL is invoked. If a Route matches, but it returns 404,
the search will continue. If no Route matches, 404 is returned. If a Route was invoked,
its return value will be transformed to an HTTP response. If a Route returns a `ZnResponse`,
no transformation will be performed. The default response transformer is an HTML
one, so if you return a `String`, it will be written to the response with text/html
content-type. If you use a Dictionary for example as return value and JSON as response
transformer, then the output will be a JSON object, created from the `Dictionary`.

The URL pattern may contain named parameters (e.g. `<param1>`), whose values
are accessible via the request object. The request is an extension of `ZnRequest`
with some extra methods. A wildcard character `(*)` matches to one URL path segment.
A wildcard terminated pattern is a greedy match; for example, `'/foo/*'` matches
to `'/foo/bar'` and `'/foo/bar/baz'` too.

Query parameters and Form parameters can be accessed the same way as path parameters
`(req at: #paramName)`.

## Parameter constraints

```smalltalk
Teapot on 
    GET: '/user/<id:IsInteger>' -> [:req | users findById: (req at: #id)];
    output: #ston;
    start.
```

- `IsInteger` matches digits (negative or positive) only and converts the value
  to an Integer
- `IsNumber` matches any integer or floating point number and converts the value
  to a Number

See `IsObject`, `IsInteger` and `IsNumber` classes for information about introducing
user defined constraints.

## Response transformers

The responsibility of a response transformer is to convert the output of the
action block and set the content-type of the response.

```smalltalk
Teapot on 
    GET: '/jsonlist' -> #(1 2 3 4); output: #json;
    GET: '/sometext' -> 'this is text plain'; output: #text;
    GET: '/download' -> ['/tmp/afile' asFileReference readStream]; output: #stream;
    start.

(ZnEasy get: 'http://localhost:1701/jsonlist') entity string.
"prints json array: '[1,2,3,4]'"

ZnEasy get: 'http://localhost:1701/download' 
"a ZnResponse(200 OK application/octet-stream 35B)"
```

The default output is `TeaOutput html` that interprets the output as string, and
sets the `content-type` to `text/html`.

Some response transformers require external packages (e.g. NeoJSON, STON, Mustache).
See `TeaOutput` class for more information.

## Templates

```smalltalk
Teapot on 
    GET: '/greet' -> {'phrase' -> 'Hello'. 'name' -> 'World'};
    output: (TeaOutput mustacheHtml: '<b>{{phrase}}</b> <i>{{name}}</i>!');
    start.
```

## Aborts

An abort: message sent to the request object immediately stops a request (by
signaling an exception) within a before filter or route. The same rules apply to
the argument to the abort: message as the return value of a Route.

```smalltalk
Teapot on 
    GET: '/secure/*' -> [:req | req abort: TeaResponse unauthorized];
    GET: '/unauthorized' -> [:req | req abort: 'go away' ];
    start.
```

## Before filters

```smalltalk
Teapot on 
    before: '/secure/*' -> [:req | 
        req session 
            attributeAt: #user 
            ifAbsent: [req abort: (TeaResponse redirect location: '/loginpage')]];
    before: '*' -> (Send message: #logRequest: to: auditor);
    GET: '/secure' -> 'protected';
    start.
```

Before filters are evaluated before each request that matches the given URL pattern.

## After filters

After filters are evaluated after each request and can read the request and modify
the response.

```smalltalk
Teapot on 
    after: '/*' -> [:req :resp | resp headers at: 'X-Foo' put: 'set by after filter'];
    start.
```

## Serving static content

```smalltalk
Teapot on 
    serveStatic: '/statics' from: '/var/www/htdocs';
    start.
```

## Regex patterns

```smalltalk
Teapot on 
    GET: '/hi/([a-z]+\d\d)' asRegex -> [:req | 'Hello ', (req at: 1)];
    start.

(ZnEasy get: 'http://localhost:1701/hi/user01') entity string. "Hello user01"
ZnEasy get: 'http://localhost:1701/hi/user'. "not found"
```

Instead of `<` and `>` surrounded named parameters, the regexp pattern may contain
sub-expressions between parentheses whose values are accessible via the request object.

### Error handlers

To handle exceptions of a configured type(s) for all routes and before filters.

```smalltalk
Teapot on 
    GET: '/divide/<a>/<b>' -> [:req | (req at: #a) / (req at: #b)];
    GET: '/at/<key>' -> [:req | dict at: (req at: #key)];
    exception: ZeroDivide -> [:ex :req | TeaResponse badRequest ];
    exception: KeyNotFound -> {#result -> 'error'. #code -> 42}; output: #json;
    start.

(ZnEasy get: 'http://localhost:1701/div/6/3') entity string. "2"
(ZnEasy get: 'http://localhost:1701/div/6/0'). "bad request"
```

You can use a comma-separated exception set to handle multiple exceptions. E.g.
`exception: ZeroDivide, DomainError -> handler`.

The same rules apply for the return values of the exception handler as were used
for the Routes.

## Query parameters

Routes may also use query parameters:

```smalltalk
Teapot on 
    GET: '/books' -> [:req | 
       books 
          findByTitle: (req at: #title) 
          limit: (req at: #limit) ];
    start.


"matches: http://localhost:1701/books?title=smalltalk&limit=12"
```

This matches to `GET http://localhost:1701/books?title=smalltalk&limit=12`.
Query parameters are optional to the /books route. You can use `at:ifAbsent:` to
handle unset parameters.

## Conditions

Routes and Before/After filters may include conditions. A condition can be any
expression that returns a Boolean.

```smalltalk
Teapot on 
    GET: 'test1' -> result; when: [:req | req accept = 'application/json'];
    any: 'test2' -> result; when: [:req | #(GET POST) includes: req method];
    start.

"first one matches only if the accept header is set to application/json"
"second one matches if the request method is either GET or POST"
```

## Multiple URL patterns

Teapot supports multiple URL patterns per routes.

```smalltalk
Teapot on 
    before: { '/secure/*' . '/protected/*' } -> 
        [ :req | req abort: TeaResponse unauthorized ];    
    GET: { '/path1/*'. '/path2/\d+' asRegex } -> 'path1 or path2';
    start.
```

## Handling POST and other methods

Using POST/PUT and other HTTP methods is no different from using GET. In case of
a POST the request represents the URL encoded form data or whatever was posted.
The request object has a generic at: method that can be used to access the path,
query or form parameters in a uniform way.

For example:

```smalltalk
Teapot on
    GET: '/login' -> 
        '<html>
            <form method="POST">
                User name:<br><input type="text" name="user"><br>
                Password:<br><input type="password" name="pwd"><br>
                <input type="submit" value="Submit">
            </form>
        </html>';
    POST: '/login'-> [ :req | 'Welcome ', (req at: #user) ];
    start.
```

REST example, showing some CRUD operations

```smalltalk
books := Dictionary new.
teapot := Teapot configure: {
    #defaultOutput -> #json. 
    #port -> 8080. 
    #debugMode -> true.
    #bindAddress -> #[127 0 0 1].
}.

teapot
    GET: '/books' -> books;
    PUT: '/books/<id>' -> [:req | | book |
        book := {'author' -> (req at: #author). 
                 'title'  -> (req at: #title)} asDictionary.
        books at: (req at: #id) put: book];     
    DELETE: '/books/<id>' -> [:req | books removeKey: (req at: #id)];
    exception: KeyNotFound -> (TeaResponse notFound body: 'No such book');
    start.
```

Creating a book with the client.

```smalltalk
ZnClient new
    url: 'http://localhost:8080/books/1';
    formAt: 'author' put: 'SquareBracketAssociates';
    formAt: 'title'  put: 'Pharo For The Enterprise';
    put
```

## More examples

- For a more complete example, study the Teapot-Library-Example package.
- [FlowerStore demo by Yanni Chiu](https://github.com/yannij/TMM)

## Differences between Teapot and other web frameworks

- Teapot is not a singleton and doesn't hold any global state. You can run multiple
  Teapot servers inside the same image with isolated state.
- There are no thread locals or dynamic scoped variables in Teapot. Everything is
  explicit.
- It doesn't rely on annotations or pragmas, you can define the routes programmatically.
- It doesn't instantiate objects (e.g. "web controllers") for you. You can hook
  http events to existing objects, and manage their dependencies the way you want.
