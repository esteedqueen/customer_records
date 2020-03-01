# frozen_string_literal: true

require 'rake/testtask'
Rake::TestTask.new do |t|
  # adds the tests directory to the lists of directories in the #$LOADPATH
  t.libs << 'tests'
  t.test_files = FileList['tests/test*.rb']
  t.verbose = true
end
