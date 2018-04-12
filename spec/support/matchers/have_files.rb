RSpec::Matchers.define :have_files do |*expected|
  # ----------------------------------------------------------------
  # Custome matcher to match expected files to a folder's contents
  #
  # Examples:
  #   expect("tmp").to have_files
  #   expect("tmp").not_to have_files("file", "other/file")
  #   expect("tmp").to have_files.from_template(:template)
  # ----------------------------------------------------------------
  attr_reader :actual_files, :expected_files

  match do |actual|
    @expected_files ||= Array(expected)
    @actual_files = files_in actual

    return false if actual.empty?
    expected_files - actual_files == []
  end

  chain :from_template do |template|
    @expected_files = files_in_template(template).map{ |e| e.chomp(".tt") }
  end

  failure_message do |actual|
    if expected_files.empty?
      "expected to find files in #{actual}"
    else
      <<~MESSAGE
        expected to find the following files in #{actual}
        #{format_list missing_files}
      MESSAGE
    end
  end

  failure_message_when_negated do |actual|
    if expected_files.empty?
      "expected not to find files in #{actual}"
    else
      <<~MESSAGE
        expected not to find the following files in #{actual}
        #{format_list unexpected_files}
      MESSAGE
    end
  end

  def files_in(dir)
    Dir.glob("**/*", File::FNM_DOTMATCH, base: dir).sort.reject do |path|
      path.end_with?("/.", "/..") || path == "." || path == ".."
    end
  end

  def files_in_template(name)
    base = File.join(SinatraCli.root, "templates", name.to_s)

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
    expected_files - actual_files
  end

  def unexpected_files
    expected_files & actual_files
  end

end
