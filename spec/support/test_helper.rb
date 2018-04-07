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
    klass = "SinatraCli::Generators::#{name.to_s.capitalize}".constantize

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

end
