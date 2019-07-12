Gem::Specification.new do |s|
  s.name        = 'jekyll-pwa-workbox'
  s.version     = '0.0.2'
  s.date        = '2019-XX-18'
  s.summary     = "PWA Workbox Service Worker for Jekyll."
  s.description = <<-TEXT
This Jekyll plugin makes your PWA / Website available offline and allows you to install on desktop or mobile*. 
It uses a Workbox service worker, generates and injects a precache list into it and takes care of the registration process in a secure way.
  TEXT
  s.authors     = ['Pan Yuqi', 'sekiyika', 'souldanger']
  s.email       = ['hello@souldanger.com']
  s.files       = Dir["lib/*.rb"] + Dir["lib/vendor/**/*"]
  s.homepage    = 'https://github.com/souldanger/jekyll-pwa-workbox'
  s.license       = 'MIT'
  s.metadata = {
    "bug_tracker_uri"   => "https://github.com/souldanger/jekyll-pwa-workbox/issues",
    "changelog_uri"     => "https://github.com/souldanger/jekyll-pwa-workbox/blob/master/CHANGELOG.md",
    "documentation_uri" => "https://github.com/souldanger/jekyll-pwa-workbox",
    "homepage_uri"      => "https://github.com/souldanger/jekyll-pwa-workbox",
    "source_code_uri"   => "https://github.com/souldanger/jekyll-pwa-workbox",
  }
  s.add_development_dependency 'jekyll', '~> 3.0'
  s.required_ruby_version = '>= 2.3.0'
end