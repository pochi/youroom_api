Gem::Specification.new do |s|
  s.name = 'youroom_api'
  s.version = '0.0.10'

  s.authors = ['pochi']
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.date = %q{2010-05-19}
  s.description = %q{Wrapper for youroom api}
  s.email = %q{pochi.black@gmail.com}
  # s.files = `git ls-files`.split("¥n")
  s.files = ['History.txt',
             'README.txt',
             'Manifest.txt',
             'Rakefile',
             'lib/object_extention.rb',
             'lib/youroom_api.rb',
             'lib/youroom_api/base.rb',
             'lib/youroom_api/base_url.rb',
             'lib/youroom_api/request/entry.rb',
             'lib/youroom_api/request/participation.rb',
             'lib/youroom_api/request.rb',
             'lib/youroom_api/version.rb',
             'lib/youroom_api/youroom.rb',
             'spec/setup_test_model.rb',
             'spec/spec.opts',
             'spec/spec_helper.rb',
             'spec/youroom_api/entry_spec.rb',
             'spec/youroom_api/object_extention_spec.rb',
             'spec/youroom_api/participation_spec.rb',
             'spec/youroom_api/request_spec.rb',
             'spec/youroom_api/youroom_spec.rb',
             'spec/youroom_api/timeline_spec.rb',
             'lib/youroom_api/request/timeline.rb',
             'spec/youroom_api/verify_credentials_spec.rb',
             'lib/youroom_api/request/verify_credentials.rb',
             'spec/youroom_api/show_attachment_spec.rb',
             'lib/youroom_api/request/show_attachment.rb',
             'spec/youroom_api/room_timeline_spec.rb',
             'lib/youroom_api/request/room_timeline.rb',
             'spec/youroom_api/unread_timeline_spec.rb',
             'lib/youroom_api/request/unread_timeline.rb',
             'spec/youroom_api/post_entry_spec.rb',
             'lib/youroom_api/request/post_entry.rb',
             'lib/youroom_api/request/my_group.rb',
             'spec/youroom_api/my_group_spec.rb',
             'spec/youroom_api/get_entry_spec.rb',
             'lib/youroom_api/request/get_entry.rb',
             'lib/youroom_api/request/destroy_entry.rb',
             'spec/youroom_api/destroy_entry_spec.rb',
             'lib/youroom_api/request/add_room.rb',
             'spec/youroom_api/add_room_spec.rb',
             'lib/youroom_api/request/add_user.rb',
             'spec/youroom_api/add_user_spec.rb',
             'lib/youroom_api/request/get_room_list.rb',
             'spec/youroom_api/get_room_list_spec.rb',
             'lib/youroom_api/request/get_user_list.rb',
             'spec/youroom_api/get_user_list_spec.rb',
             'lib/youroom_api/request/add_participation.rb',
             'spec/youroom_api/add_participation_spec.rb',
             'lib/youroom_api/request/destroy_participation.rb',
             'spec/youroom_api/destroy_participation_spec.rb']

  s.homepage = "https://home.youroom.in/"
  s.rdoc_options = ["--title", "ww documentation", "--charset", "utf-8", "--opname", "index.html", "--line-numbers", "--main", "README.rdoc", "--inline-source", "--exclude", "^(examples|extras)/"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{Double Web, framework to build double Web server.}
end