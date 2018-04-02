module SinatraCli
  class Main < Cli

    desc "test [options] [files or directories]", "Start the test runner"

    def test(*args)
      gemfile = File.join(Dir.pwd, "/Gemfile")
      rspec_options = args.join(" ")

      exec "BUNDLE_GEMFILE=#{gemfile} bundle exec rspec #{rspec_options}"
    end

    map "spec" => :test

  end
end
