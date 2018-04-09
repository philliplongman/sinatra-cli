RSpec::Matchers.define :generate_files do |*expected|

  attr_reader :expected_files

  match do |generator|
    generator.generate

    @expected_files ||= Array(expected)
    @actual = temp_files

    return false if actual.empty?
    expected_files - actual == []
  end

  chain :from_template do |template|
    @expected_files = template_files(template).map{ |e| e.chomp(".tt") }
  end

  failure_message do |actual|
    if expected_files.empty?
      "expected that generator would produce files"
    else
      <<~MESSAGE
      expected that generator would produce
      #{format_list expected_files}

      missing files
      #{format_list missing_files}
      MESSAGE
    end
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

  def template_files(template)
    base = "#{SinatraCli.root}/templates/#{template}"

    Dir.glob("**/*", File::FNM_DOTMATCH, base: base).sort.reject do |path|
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

  def missing_files
    expected_files - actual
  end

  def unexpected_files
    expected_files & actual
  end

end
