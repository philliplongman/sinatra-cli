# Sinatra CLI

Sinatra's modular style is a great choice for lightweight web apps and simple APIs. That also makes it a great choice for coding exercises and learning about web development. But configuring a fleshed-out modular app can be over the head of a beginner (especially since many of the Sinatra recipes have become dated), and experienced programmers may miss the ease of having Rails take care of configuration so they can get to work.

Sinatra CLI solves this problem with a lightly opinionated project generator. Starting a new project is as simple as:
```
$ sinatra new app_name
```
That starts a series of modular generators which create an app with default configuration, ready to start hacking on.

## Default Configuration

The default configuration is a modular-style app with a Gemfile.

- App and environment configuration is contained in the `config` folder.

- The main `app.rb` file and other business logic, as well as the `public` and `views` folders, is contained in the `app` folder. [require_all](https://github.com/jarmo/require_all) should automatically load files in `app`, as long as they declare their dependencies. [Rerun](https://github.com/alexch/rerun) is configured to reload the app when it detects changes to the `app` folder.

- Environmental variables are handled by [dotenv](https://github.com/bkeepers/dotenv).

- [ActiveSupport](http://guides.rubyonrails.org/active_support_core_extensions.html) is included in the Gemfile, giving access to Rails' extensions of the core Ruby libraries.

- [Pry](https://github.com/pry/pry) and [Bettor Errors](https://github.com/charliesome/better_errors) are included to aid development.

- [RSpec](https://relishapp.com/rspec) and [Capybara](https://teamcapybara.github.io/capybara/) are installed for testing, along with a `TestHelper` module to write test helpers in.

More options and default features are planned, including Webpack, Javascript & CSS frameworks, and ActiveRecord.

## Installation

```
$ gem install sinatra-cli
```

## Usage

To create a new app:

```
$ sinatra new APP_PATH
```

This can be modified with the following options:

| Option            | Description                           |
| ----------------- | ------------------------------------- |
| --skip-test, -t   | Don't generate an RSpec installation  |
| --haml            | Use Haml for views, instead of ERB    |
| --slim            | Use Slim for views, instead of ERB    |

You can view these options by calling the command with `--help` or `-h`.

### Generators

Most of the generators can be accessed to add specific elements à la carte. The folder structure from the modular app generator is assumed, and existing files may be overwritten (it will ask what to do).

```
$ sinatra generate GENERATOR
```

| Generator   | Description                           |
| ----------- | ------------------------------------- |
| modular     | Generate a modular-style Sinatra app  |
| classic     | Generate a classic-style Sinatra app  |
| tests       | Generate an RSpec installation        |

The `classic` generator creates a barebones Sinatra app, suitable for those learning the very basics. It creates one ruby file, a `public` folder, a `views` folder, and no Gemfile. It is not intended to be run with other generators.

To see the options for a generator, call the command with `--help` or `-h`.

### Server

Like other frameworks with a command line interface, Sinatra CLI can be used to start the server:

```
$ sinatra server
```

This can be called with `--no-reload` or `-r` to disable reloading.

### Tests

Sinatra CLI can also run the test suite:

```
$ sinatra test [arguments]
```

Any arguments will be passed to the testing framework. Also aliased as `sinatra spec`.


## Contriuting to Sinatra CLI

Bug reports and pull requests are welcome on GitHub at https://github.com/philliplongman/sinatra-cli.

### Setup

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install the gem onto your machine from the local files, run `bundle exec rake install`.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
