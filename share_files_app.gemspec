$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "share_files_app/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "share_files_app"
  spec.version     = ShareFilesApp::VERSION
  spec.authors     = ["ferbin"]
  spec.email       = ["ferbin17@gmail.com"]
  spec.homepage    = "http://mygemserver.com"
  spec.summary     = "Summary of ShareFilesApp."
  spec.description = "Description of ShareFilesApp."
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", "~> 6.0.3", ">= 6.0.3.4"

  spec.add_development_dependency "pg"
  spec.add_development_dependency "jquery-fileupload-rails"
  spec.add_development_dependency "paperclip"
  spec.add_development_dependency "rubyzip"
  spec.add_development_dependency "sidekiq"
  spec.add_development_dependency "psych"

end
