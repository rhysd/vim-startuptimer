# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vim-startuptimer/version'

Gem::Specification.new do |gem|
  gem.name          = "vim-startuptimer"
  gem.version       = VimStartuptimer::VERSION
  gem.authors       = ["rhysd"]
  gem.email         = ["lin90162@yahoo.co.jp"]
  gem.description   = %q{check average startup time of Vim.}
  gem.summary       = %q{startup Vim 100 times and take the average of Vim's various loading time.}
  gem.homepage      = "https://github.com/rhysd/vim-startuptimer"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
