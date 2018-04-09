module TestHelper

  # Return regex to match the given order of commands when output by help
  #
  def command_order(*commands)
    Regexp.new commands.map { |e| ".+#{e}.+#.+\n" }.join
  end

  # Prevent generator instances from actually running, while still
  # returning themselves
  #
  def stub_generator(name)
    base_name = (name =~ /rspec/i) ? "RSpec" : name.to_s.camelize
    klass = "SinatraCli::Generators::#{base_name}".constantize
    allow_any_instance_of(klass).to receive(:generate) { |instance| instance }
  end

  # Perform the block without outputing to stderr and stdout
  #
  def suppress_output(&block)
    @original_stderr = $stderr
    @original_stdout = $stdout

    $stderr = $stdout = StringIO.new

    yield(block)

    $stderr = @original_stderr
    $stdout = @original_stdout
    @original_stderr = nil
    @original_stdout = nil
  end

  # Clear the tmp directory before and after a test runs.
  #
  def clear_temp_files
    Dir.mkdir "tmp" unless Dir.exist? "tmp"
    Dir.children("tmp").each { |e| FileUtils.rm_r File.join("tmp", e) }
    yield
    Dir.children("tmp").each { |e| FileUtils.rm_r File.join("tmp", e) }
  end

end
