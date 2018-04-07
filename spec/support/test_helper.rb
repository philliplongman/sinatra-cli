module TestHelper

  # Return regex to match the given order of commands when output by help
  #
  def command_order(*commands)
    Regexp.new commands.map { |e| ".+#{e}.+#.+\n" }.join
  end

end
