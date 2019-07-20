Gem::Specification.new do |s|
  s.name        = 'jekyll-pwa-workbox'
  s.version     = '0.0.7.alpha'
  s.date        = '2019-07-20'
  s.summary     = "PWA Workbox Service Worker for Jekyll."
  s.description = "A Jekyll plugin that makes your PWA / Website available offline and lets you install on desktop and mobile. 
					It generates and injects a precache list into a Workbox v5.0.0-alpha.1 service worker and handles the registration process in a secure way."
  s.authors     = ['souldanger']
  s.email       = ['souldanger.industries@gmail.com']
  s.files       = Dir["lib/*.rb"] + Dir["lib/vendor/**/*"]
  s.homepage    = 'https://github.com/souldanger/jekyll-pwa-workbox'
  s.license       = 'MIT'
  s.metadata = {
    "bug_tracker_uri"   => "https://github.com/souldanger/jekyll-pwa-workbox/issues",
    "changelog_uri"     => "https://github.com/souldanger/jekyll-pwa-workbox/blob/master/CHANGELOG.md",
    "documentation_uri" => "https://github.com/souldanger/jekyll-pwa-workbox/blob/master/README.md",
    "homepage_uri"      => "https://github.com/souldanger/jekyll-pwa-workbox",
    "source_code_uri"   => "https://github.com/souldanger/jekyll-pwa-workbox/releases",
  }
end