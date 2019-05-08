$:.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'recommendation/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'recommendation'
  s.version     = Recommendation::VERSION
  s.authors     = ['iloveivyxuan']
  s.email       = ['contact@jiqizhixin.com']
  s.homepage    = 'https://github.com/SyncedPSI/recommendation'
  s.summary     = 'a recommendation system for Synced website.'
  s.description = 'a recommendation system for Synced website.'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'README.md']

  s.add_dependency 'redis'
  s.add_dependency 'pry'
  s.add_dependency 'rubocop-performance'
end
