module TestHelper

  # Clear the tmp directory. If a block is passed, do it before and after.
  #
  def clear_temp_files
    Dir.mkdir "tmp" unless Dir.exist? "tmp"
    if block_given?
      Dir.children("tmp").each { |e| FileUtils.rm_r File.join("tmp", e) }
      yield
    end
  ensure
    Dir.children("tmp").each { |e| FileUtils.rm_r File.join("tmp", e) }
  end

  # Return regex to match the given order of commands when output by help
  #
  def command_order(*commands)
    Regexp.new commands.map { |e| ".+#{e}.+#.+\n" }.join
  end

  # Return the contents of the Gemfile from the tmp folder
  #
  def gemfile
    File.read("tmp/Gemfile")
  end

  # Mock a spy for the given generator
  #
  def generator_spy(name)
    base_name = (name =~ /rspec/i) ? "RSpec" : name.to_s.camelize
    klass = "SinatraCli::Generators::#{base_name}"

    spy(klass).tap do |generator|
      allow(generator).to receive_messages(
        generate:           generator,
        absolute_app_path:  "",
        app_path_basename:  "",
        camelized_name:     "",
        underscored_name:   ""
      )
    end
  end

  # Perform the block without outputing to stderr and stdout.
  # Interferes with Pry.
  #
  def suppress_output(&block)
    orig_stderr = $stderr.clone
    orig_stdout = $stdout.clone
    $stderr.reopen File.new("/dev/null", "w")
    $stdout.reopen File.new("/dev/null", "w")
    yield block
  rescue Exception => e
    $stdout.reopen orig_stdout
    $stderr.reopen orig_stderr
    raise e
  ensure
    $stdout.reopen orig_stdout
    $stderr.reopen orig_stderr
  end

end
