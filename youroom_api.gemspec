Gem::Specification.new do |s|
  s.name = 'youroom_api'
  s.version = '0.1.0'

  s.authors = ['pochi']
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.date = %q{2010-05-19}
  s.description = %q{Wrapper for youroom api}
  s.email = %q{pochi.black@gmail.com}
  s.files = `git ls-files`.split("\n")
  s.homepage = "https://home.youroom.in/"
  s.rdoc_options = ["--title", "ww documentation", "--charset", "utf-8", "--opname", "index.html", "--line-numbers", "--main", "README.rdoc", "--inline-source", "--exclude", "^(examples|extras)/"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{Double Web, framework to build double Web server.}
end
