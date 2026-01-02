require "fileutils"

TMP = "spec/tmp"

RSpec.configure do |c|
  c.before(:suite) do
    FileUtils.rm_rf TMP
    FileUtils.mkdir_p TMP
  end
end
