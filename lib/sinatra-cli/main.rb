module SinatraCli
  class Main < Cli

    private

    def cyan(text)
      set_color text, :cyan
    end

    def cmd(command, app_path = nil)
      case command
      when :server
        cyan "sinatra server"
      when :test
        "#{cyan "sinatra test"} or #{cyan "sinatra spec"}"
      when :generate
        cyan "sinatra generate"
      when :cd
        app_path == "." ? nil : cyan("cd #{app_path}\n    ")
      end
    end

  end
end
