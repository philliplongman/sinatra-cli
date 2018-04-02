module SinatraCli
  class Generate < Cli

    desc "generate rspec", "Generate an RSpec installation"

    def rspec
      app = RSpec.new(cli: self).generate
      command = set_color("rspec", :cyan)
      say <<~SAY

        Success! RSpec and Capybara have been installed. Put your tests in #{app.underscored_name}/spec/
        To run your them, use the command

            #{command}

      SAY
    end

  end
end
