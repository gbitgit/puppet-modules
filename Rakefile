require 'tempfile'
require 'bundler/setup'
require 'childprocess'

task :default => :spec

desc "Run the specs for every module."
task :spec do
  has_failure = false

  root_dir = File.dirname(__FILE__)
  Dir["#{root_dir}/modules/**/Rakefile"].each do |module_path|
    module_dir  = File.dirname(module_path)
    module_name = File.basename(module_dir)

    # Due to a bug with rspec-puppet at the moment, we need to break each
    # test out individually into each spec file.
    Dir["#{module_dir}/spec/*/*_spec.rb"].each do |spec_file|
      spec_name = spec_file.gsub("#{module_dir}/", "")

      print "#{module_name.ljust(15)}#{spec_name.ljust(60)}"
      process = ChildProcess.build("rspec", spec_file)
      process.cwd = module_dir
      process.io.stdout = Tempfile.new("child-output")
      process.io.stderr = Tempfile.new("child-err")
      process.start
      process.wait

      if process.crashed?
        # Mark that we have a failure so we can have the right exit status
        has_failure = true

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

  exit 1 if has_failure
  exit 0
end
