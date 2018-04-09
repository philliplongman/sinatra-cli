RSpec::Matchers.define :generate_files do |*expected|

  match do |generator|
    generator.generate
    @actual = temp_files

    expected - actual == []
  end

  failure_message do |actual|
    <<~MESSAGE
      expected that generator would produce
        #{format_list expected_files}

      missing files
        #{format_list missing_files}
    MESSAGE
  end

  failure_message_when_negated do |actual|
    <<~MESSAGE
      expected that generator would not produce
        #{format_list expected_files}

      unexpected files
        #{format_list unexpected_files}
    MESSAGE
  end

  def temp_files
    Dir.glob("**/*", File::FNM_DOTMATCH, base: "tmp").sort.reject do |path|
      path.end_with?("/.", "/..") || path == "." || path == ".."
    end
  end

  def format_list(list)
    if list.count > 20
      list.first(19).join("\n  ").prepend("  ") << "\n  (...)"
    else
      list.first(20).join("\n  ").prepend("  ")
    end
  end

  def expected_files
    Array(expected)
  end

  def missing_files
    Array(expected) - Array(actual)
  end

  def unexpected_files
    Array(expected) & Array(actual)
  end

end
