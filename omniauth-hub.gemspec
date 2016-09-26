$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "omniauth-hub/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "omniauth-hub"
  s.version     = OmniAuth::Hub::VERSION
  s.authors     = ["Hub Software", "Nicholas W. Watson"]
  s.email       = ["nwwatson@gmail.com"]
  s.homepage    = "http://github.com/nwwatson/omniauth-hub"
  s.summary     = "OmniAuth strategy for Hub"
  s.description = "OmniAuth strategy for Hub"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "omniauth", "~> 1.3.1"
  s.add_dependency "omniauth-oauth2", "~> 1.4.0"

  s.add_development_dependency "sqlite3"
end
