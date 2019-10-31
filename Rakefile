require 'rake/testtask'

task :test => ["test:all","test:unit"]

task :default => "test:all"

namespace :test do
  desc "Run all tests"
  Rake::TestTask.new(:all) do |t|
    t.libs << "test"
    t.test_files = FileList['test/*/test_*.rb']
  end

  desc "Run unit tests"
  Rake::TestTask.new(:unit) do |t|
    t.libs << "test"
    t.test_files = FileList['test/unit/test_*.rb']
    t.verbose = true
  end
end
