$:.push File.expand_path('../lib', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = 'knife-runlist-compare'
  gem.version       = '0.0.1'
  gem.authors       = ["Jon Cowie"]
  gem.email         = 'jonlives@gmail.com'
  gem.homepage      = 'https://github.com/jonlives/knife-runlist-compare'
  gem.licenses      = ['MIT']
  gem.summary       = "A knife plugin to compare two runlists, expand them to lists of recipes and display the diff"
  gem.description   = "A knife plugin to compare two runlists, expand them to lists of recipes and display the diff"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "knife-runlist-compare"
  gem.require_paths = ["lib"]

  gem.add_runtime_dependency 'chef', '>= 11.0.0'
  gem.add_runtime_dependency 'diffy', '~> 3.0.5'
end