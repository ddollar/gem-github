require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "gem-github"
    gem.summary = %Q{Show Github-related stats of the same gem from different users}
    gem.description = <<DESCRIPTION

Get Github statistics for various versions of a gem

$ gem github railroad

peterhoeg-railroad             fork:no   watchers:7   updated:2009-05-16
factorylabs-railroad           fork:yes  watchers:8   updated:2009-01-05
bryanlarsen-railroad           fork:yes  watchers:7   updated:2009-06-30
nono-railroad                  fork:yes  watchers:7   updated:2009-03-13
ddollar-railroad               fork:yes  watchers:2   updated:2009-03-13
terotil-railroad               fork:yes  watchers:2   updated:2009-02-13

DESCRIPTION
    gem.email = "<ddollar@gmail.com>"
    gem.homepage = "http://github.com/ddollar/gem-github-stats"
    gem.authors = ["David Dollar"]
    gem.add_runtime_dependency 'fcoury-octopi', '>= 0.1.0'
    gem.add_development_dependency "thoughtbot-shoulda"
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/*_test.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/*_test.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

task :test => :check_dependencies

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  if File.exist?('VERSION')
    version = File.read('VERSION')
  else
    version = ""
  end

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "gem-github-stats #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
