Gem::Specification.new do |s|
  s.name = 'youroom_api'
  s.version = '0.0.2'


  s.authors = ['pochi']
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.date = %q{2010-05-19}
  s.description = %q{Wrapper for youroom api}
  s.email = %q{pochi.black@gmail.com}
  s.files = ['History.txt', 'README.txt', 'Manifest.txt', 'Rakefile', 'lib/object_extention.rb', 'lib/youroom_api.rb', 'lib/youroom_api/base.rb', 'lib/youroom_api/base_url.rb','lib/youroom_api/create_participation.rb','lib/youroom_api/destroy_participation.rb','lib/youroom_api/entry.rb','lib/youroom_api/participation.rb','lib/youroom_api/request.rb','lib/youroom_api/room.rb','lib/youroom_api/user.rb','lib/youroom_api/version.rb','lib/youroom_api/youroom.rb','lib/youroom_api/youroom_oauth.rb', 'spec/setup_test_model.rb', 'spec/spec.opts','spec/spec_helper.rb','spec/youroom_api/create_participation_spec.rb','spec/youroom_api/destroy_participation_spec.rb','spec/youroom_api/entry_spec.rb','spec/youroom_api/object_extention_spec.rb','spec/youroom_api/participation_spec.rb','spec/youroom_api/request_spec.rb','spec/youroom_api/room_spec.rb','spec/youroom_api/user_spec.rb','spec/youroom_api/youroom_oauth_spec.rb','spec/youroom_api/youroom_spec.rb']
  s.homepage = "https://home.youroom.in/"
  s.rdoc_options = ["--title", "ww documentation", "--charset", "utf-8", "--opname", "index.html", "--line-numbers", "--main", "README.rdoc", "--inline-source", "--exclude", "^(examples|extras)/"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{Double Web, framework to build double Web server.}
end