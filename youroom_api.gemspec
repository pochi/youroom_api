Gem::Specification.new do |s|
  s.name = 'youroom_api'
  s.version = '0.0.2'


  s.authors = ['pochi']
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.date = %q{2010-05-19}
  s.description = %q{Wrapper for youroom api}
  s.email = %q{pochi.black@gmail.com}
  s.files = ['History.txt', 'README.txt', 'Manifest.txt', 'Rakefile', 'lib/object_extention.rb', 'lib/youroom_api.rb', 'lib/youroom_api/base.rb', 'lib/youroom_api/base_url.rb','lib/youroom_api/request/entry.rb','lib/youroom_api/request/participation.rb','lib/youroom_api/request.rb', 'lib/youroom_api/version.rb','lib/youroom_api/youroom.rb', 'spec/setup_test_model.rb', 'spec/spec.opts','spec/spec_helper.rb','spec/youroom_api/entry_spec.rb','spec/youroom_api/object_extention_spec.rb','spec/youroom_api/participation_spec.rb','spec/youroom_api/request_spec.rb','spec/youroom_api/youroom_spec.rb', 'spec/youroom_api/timeline_spec.rb', 'lib/youroom_api/request/timeline.rb', 'spec/youroom_api/unread_timeline_spec.rb', 'lib/youroom_api/request/unread_timeline.rb', 'spec/youroom_api/post_entry_spec.rb', 'lib/youroom_api/request/post_entry.rb', 'lib/youroom_api/request/my_group.rb', 'spec/youroom_api/my_group_spec.rb', 'spec/youroom_api/get_entry_spec.rb', 'lib/youroom_api/request/get_entry.rb', 'lib/youroom_api/request/destroy_entry.rb', 'spec/youroom_api/destroy_entry_spec.rb', 'lib/youroom_api/request/add_room.rb', 'spec/youroom_api/add_room_spec.rb', 'spec/youroom_api/base_spec.rb']
  s.homepage = "https://home.youroom.in/"
  s.rdoc_options = ["--title", "ww documentation", "--charset", "utf-8", "--opname", "index.html", "--line-numbers", "--main", "README.rdoc", "--inline-source", "--exclude", "^(examples|extras)/"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{Double Web, framework to build double Web server.}
end