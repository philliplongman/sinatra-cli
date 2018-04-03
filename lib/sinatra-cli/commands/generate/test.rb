module SinatraCli
  class Generate < Cli

    desc "tests", "Generate an RSpec installation"

    # Run the RSpec generator in the current working directory, and output
    # instructions how to start the tests. RSpec is the only testing
    # framework currently supported.
    #
    def tests
      app = RSpec.new(cli: self).generate
      say <<~SAY

        Success! RSpec and Capybara have been installed. Put your tests in #{app.underscored_name}/spec/
        To run your them, use the command

            #{cmd :tests}

      SAY
    end

    map "test" => :tests

  end
end
