RSpec::Matchers.define :match_template do |expected|

  def expected_files
    @expected_files ||= begin
      base = "#{SinatraCli.root}/templates/#{expected}"
      glob = Dir.glob("**/*", File::FNM_DOTMATCH, base: base)
      files = glob.sort.reject { |e| File.directory? File.expand_path(e, base) }
      files.map{ |e| e.remove(/\.tt$/) }
    end
  end

  match do |actual|
    expected_files - actual == []
  end

  failure_message do |actual|
    <<~MESSAGE
      expected that generator output would match template "#{expected}"

      Missing files:
      #{missing_files}

    MESSAGE
  end

  failure_message_when_negated do |actual|
    %(expected that generator output would not match template "#{expected}")
  end

  def missing_files
    list = (expected_files - actual)

    if list.count > 20
      list.first(19).map { |e| "  - #{e}" }.join("\n") << "\n  (...)"
    else
      list.first(20).map { |e| "  - #{e}" }.join("\n")
    end
  end

end
