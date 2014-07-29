Gem::Specification.new do |s|
  s.name        = 'gitindex'
  s.version     = '0.0.2'
  s.licenses    = ['MIT']
  s.summary     = 'Creates an index of your local git repositories'
  s.description = 'Traverses your directory structure, starting at a specified location, and creates an HTML tree of your git repositories. Will also link to the origin remote if it exists.'
  s.authors     = ['Randall Reed, Jr.']
  s.email       = ['randallreedjr@gmail.com']
  s.files       = ['lib/gitindex.rb','lib/gitindexcli.rb', 'lib/gitrepo.rb', 'config/environment.rb']
  s. executables << 'gitindex'
  s.homepage    = 'https://rubygems.org/gems/gitindex'
end