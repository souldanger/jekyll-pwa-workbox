Gem::Specification.new do |s|
  s.name        = 'jekyll-pwa-workbox'
  s.version     = '0.0.1'
  s.date        = '2019-03-18'
  s.summary     = "PWA Workbox Service Worker for Jekyll."
  s.description = "This Jekyll plugin uses a Workbox service worker, generates and injects a precache list into it and takes care of the registration process in a secure way."
  s.authors     = ['Pan Yuqi', 'sekiyika', 'souldanger']
  s.email       = ['pyqiverson@gmail.com', 'pengxing5501854@gmail.com', 'hello@souldanger.com']
  s.files       = Dir["lib/*.rb"] + Dir["lib/vendor/**/*"]
  s.homepage    = 'https://github.com/souldanger/jekyll-pwa-workbox'
  s.license       = 'MIT'
  s.metadata = {
    "bug_tracker_uri"   => "https://github.com/souldanger/jekyll-pwa-workbox/issues",
    "changelog_uri"     => "https://github.com/souldanger/jekyll-pwa-workbox/blob/master/CHANGELOG.md",
    "documentation_uri" => "https://github.com/souldanger/jekyll-pwa-workbox",
    "homepage_uri"      => "https://github.com/souldanger/jekyll-pwa-workbox",
    "source_code_uri"   => "https://github.com/souldanger/jekyll-pwa-workbox",
    "wiki_uri"          => "https://github.com/souldanger/jekyll-pwa-workbox"
  }
end