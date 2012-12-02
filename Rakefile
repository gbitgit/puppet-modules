require 'tempfile'
require 'bundler/setup'
require 'childprocess'

task :default => :spec

desc "Run the specs for every module."
task :spec do
  root_dir = File.dirname(__FILE__)
  Dir["#{root_dir}/modules/**/Rakefile"].each do |module_path|
    module_dir  = File.dirname(module_path)
    module_name = File.basename(module_dir)

    print module_name.ljust(30)

    process = ChildProcess.build("rake", "spec")
    process.cwd = module_dir
    process.io.stdout = Tempfile.new("child-output")
    process.io.stderr = Tempfile.new("child-err")
    process.start
    process.wait

    if process.crashed?
      puts "FAIL"
      puts "-" * 40

      # We just print stdout because rspec outputs errors on stdout
      process.io.stdout.rewind
      puts process.io.stdout.read

      puts "-" * 40
    else
      puts "PASS"
    end
  end
end
