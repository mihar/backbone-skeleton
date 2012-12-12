# Backbone app skeleton

Just clone this repo and use it as a starting point for your new Backbone.js based voyages.

## Assumptions

Skeletons like these can work well only if there are certain assumptions/conventions.

1. We assume that you use **CoffeeScript** for all your scripting.
2. We assume that you use **SASS** for your styling.
3. We assume that you use **HAML** for your base DOM.
4. We assume that you use **HAML(c)** for your templates for Backbone views.

## What gives

It provides:

- directory structure
- stubs for important foundation files
- application-wide events
- sophisticated and customizable init process
- compilation of CoffeeScript/SASS/HAML to native JS/CSS/HTML via Guard
- concatenation and compression of assets via Jammit
- self contained Ruby web server through Sinatra

## The skeleton

Let's take a look at the actual structure. Inspired by Rails, I've created a [skeleton Backbone application](https://github.com/mihar/backbone-skeleton), for which the code was extracted from my [latest production app](http://dubjoy.com).

So if we get down to business, this is the gist of it, or the skeleton of the skeleton:

    .
    ├── Gemfile
    ├── Guardfile
    ├── config/
    |   └── assets.yml
    ├── public/
    |   ├── assets/
    |   ├── css/
    |   └── js/
    |       ├── _lib
    |       └── templates
    ├── server
    └── src
        ├── coffeescript
        |   ├── App.js.coffee    
        |   ├── Events.js.coffee
        |   ├── init.js.coffee
        |   ├── log.js.coffee
        |   ├── ns.js.coffee
        |   ├── Router.js.coffee
        |   ├── models
        |   |   └── Model.js.coffee
        |   └── views
        |       └── ModelView.js.coffee     
        ├── haml
        |   └── index.html.haml
        ├── sass
        |   └── application.css.sass
        └── templates

Let's examine all of these and learn about what they do and why they're important.

### `Gemfile`

The Gemfile is simply instructions to the Ruby Bundler about which libraries we need. We're installing only Guard and its
dependencies like HAML, SASS and CoffeeScript.

### `Guardfile`

The `Guardfile` are instructions for Guard so it knows which files to watch for changes and what to do with them.

It's basically just using various [Guard plugins](https://github.com/guard/guard/wiki/List-of-available-Guards) that just need to know the input and output directories and an optional `watch` statement.

    guard 'haml', :input => 'src/haml', :output => 'public/' do
        watch %r{^.+(\.html\.haml)\Z}
    end

    guard 'haml-coffee', :input => 'src/templates', :output => 'public/js/templates' do
      watch %r{^.+(\.js\.hamlc)\Z}
    end

    guard 'sass', :input => 'src/sass', :output => 'public/css'

    guard 'coffeescript', :input => 'src/coffeescript', :output => 'public/js'

    guard :jammit, :config_path => 'config/assets.yml' do
      watch %r{^public/js/(.*)\.js$}
      watch %r{^public/css/(.*)\.css$}
    end

You can learn a lot about the structure, by just examining these lines.

### `config/` and `assets.yml`

`Config` houses configuration and in the skeleton, the only configuration is for the [Jammit library](http://documentcloud.github.com/jammit/#configuration).

It lists which JavaScript and CSS files to concatenate together, in which order to do it and where to deposit the result.

### `public/`

This is the *"root"* where you'll point your web server in production (in the included server, this is done already).

These files are ignored from Git, because they should always be reconstructed from source files in the `src/` directory.

Oh, and Guard also compiles HTML files directly into `public/`.

#### `public/assets/`

Jammit puts in all the concatenated and compressed code. *This is your actual end product.*

#### `public/css/`

Guard compiles SASS into this directory.

#### `public/js/`

Guard compiles CoffeeScript into this directory.

##### `public/js/_lib/`

There is one special sub-directory here `_lib`. It's special because **it's not ignored from Git**. Inside you put whatever
JavaScript libraries you'd like to use, such as [jquery.cookie](https://github.com/carhartl/jquery-cookie) for cookie management.

##### `public/js/templates/`

Into `templates/` Guard compiles your HAML Coffee templates, that you use in Backbone views.

### `server/`

This irectory houses the Ruby/Sinatra web server. Consult the main `app.rb` file, where you can play with your server-side, mock up and API, etc.

### `src/`

The heart and soul (i mean source) of your app.

#### `src/coffeescript/`

This is where all the JavaScript is concieved.

##### `App.js.coffee`

App is the main class. It holds critical initialization code and application wide events.

Backbone has an [Events module](http://backbonejs.org/#Events), that can be plugged into your own classes.

    # Use Backbone's events in your master class.
    events: _.extend(BBNS.Events, Backbone.Events)

##### `Events.js.coffee`

Defines our own `BBNS.Events` class, that I use here to define s shorthand for the `Events#trigger` method.

##### `init.js.coffee`

This is the file that boots us up. It first makes an instance of the `App` class from `App.js.coffee`, then wires
in the `DOM load` and other events.

##### `log.js.coffee`

A custom logging function. Nothing fancy here, just outputs the timestamp and ensures that things don't break even if `window.console` isn't defined.

It features also logging at different levels. For example, if you set `debug` to `6` in `App.js.coffee`, you will see all the app-wide events
that are being triggered:

![](http://media.tumblr.com/tumblr_mexoeq6AZ11qahol6.png)

##### `ns.js.coffee`

Here we declare our root name space. All other files declare properties of this root name space.

In the skeleton app this is `window.BBNS`, which stands for Backbone Name Space. You should change this for your own needs.

##### `Router.js.coffee`

Defines the root Backbone router class. For my purposes I never needed more than one router until now. When I do, I'll put them under a separate `routers/` directory like models and views.

#### `src/models/`

Define Backbone models here that will hold, manipulate, load and persist your data.

#### `src/views/`

Define Backbone views here and name them `<model_or_functionality>View.js.coffee`. Just append View to all files for consistency's sake.

### `haml/`

Here we define the root file that the browser needs to load our app. `index.html.haml` from here becomes `public/index.html` when Guard is done with it.

It's unusual to need more than one file here, but depends on the complexity of the app.

### `sass/`

Style your app here. I usually use just one main `application.css.sass` file and then use SASS `@import` statements
to modularize code. 

Why? If you try to compile partial stylesheets with Guard and you're using some helpers defined in the main file, Guard will complain.

### `templates/`

Put in here your templates for use in Backbone Views and written in HAML Coffee. They get compiled into `public/js/templates/`.

## Usage

Getting started with a new app using my skeleton is trivial. It uses Ruby in several critical places, so be sure you have a working installation of Ruby, preferably of the 1.9 kind.

Start by cloning my [backbone-skeleton repo](https://github.com/mihar/backbone-skeleton).

    $ git clone https://github.com/mihar/backbone-skeleton.git my-new-backbone-app

Then use the `bundle` command that comes with [Ruby Bundler](http://gembundler.com/v1.2/index.html) to install the necessary dependencies for guard. Guard will compile our HAML, SASS and CoffeeScript to their native counterparts.

    $ cd my-new-backbone-app
    $ bundle

Once Bundler completes the installation, we can try starting Guard, to immediately start watching files for changes.

    $ bundle exec guard

While leaving guard running, go to another terminal and let's fire up a simple, bundled Ruby web server, that we'll use for development. The server will install all of it's dependencies by itself.

    $ rake server

    [1/1] Isolating sinatra (>= 0).
    Fetching: rack-1.4.1.gem (100%)
    Fetching: rack-protection-1.2.0.gem (100%)
    Fetching: tilt-1.3.3.gem (100%)
    Fetching: sinatra-1.3.3.gem (100%)
    [2012-12-05 18:17:05] INFO  WEBrick 1.3.1
    [2012-12-05 18:17:05] INFO  ruby 1.9.3 (2012-02-16) [x86_64-darwin11.3.0]
    [2012-12-05 18:17:05] INFO  WEBrick::HTTPServer#start: pid=39675 port=9292

Now our server is listening on [http://localhost:9292](http://localhost:9292), so go ahead, and open that.

If you see "Skeleton closet", everything is go.

![](http://media.tumblr.com/tumblr_meu8pymBnq1qahol6.png)

Go check out the JavaScript console for more information.

![](http://media.tumblr.com/tumblr_meu8kjjYVI1qahol6.png)