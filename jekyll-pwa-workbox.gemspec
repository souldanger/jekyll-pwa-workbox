Gem::Specification.new do |s|
  s.name        = 'jekyll-pwa-workbox'
  s.version     = '1.0.0'
  s.date        = '2019-03-17'
  s.summary     = "PWA Workbox Service Worker for Jekyll."
  s.description = "This Jekyll plugin uses a Workbox service worker, generates and injects a precache list into it and takes care of the registration process in a secure way."
  s.authors     = ["Michael Suldinger"]
  s.email       = 'hello@souldanger.com'
  s.files       = Dir["lib/*.rb"] + Dir["lib/vendor/**/*"]
  s.homepage    =
    'https://github.com/lavas-project/jekyll-pwa'
  s.license       = 'MIT'
end