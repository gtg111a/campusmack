# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "video_info"
  s.version = "0.2.9"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Thibaud Guillaume-Gentil"]
  s.date = "2011-12-02"
  s.description = "Get video info from youtube and vimeo url."
  s.email = ["thibaud@thibaud.me"]
  s.homepage = "http://rubygems.org/gems/video_info"
  s.require_paths = ["lib"]
  s.rubyforge_project = "video_info"
  s.rubygems_version = "1.8.10"
  s.summary = "Vimeo & Youtube parser"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<hpricot>, ["~> 0.8.4"])
      s.add_development_dependency(%q<bundler>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 2.7.0"])
      s.add_development_dependency(%q<guard-rspec>, [">= 0"])
      s.add_development_dependency(%q<webmock>, [">= 0"])
      s.add_development_dependency(%q<vcr>, [">= 0"])
    else
      s.add_dependency(%q<hpricot>, ["~> 0.8.4"])
      s.add_dependency(%q<bundler>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 2.7.0"])
      s.add_dependency(%q<guard-rspec>, [">= 0"])
      s.add_dependency(%q<webmock>, [">= 0"])
      s.add_dependency(%q<vcr>, [">= 0"])
    end
  else
    s.add_dependency(%q<hpricot>, ["~> 0.8.4"])
    s.add_dependency(%q<bundler>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 2.7.0"])
    s.add_dependency(%q<guard-rspec>, [">= 0"])
    s.add_dependency(%q<webmock>, [">= 0"])
    s.add_dependency(%q<vcr>, [">= 0"])
  end
end
