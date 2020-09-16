[![Gem Version](https://badge.fury.io/rb/jekyll-pwa-workbox.svg)](https://badge.fury.io/rb/jekyll-pwa-workbox)
![](https://ruby-gem-downloads-badge.herokuapp.com/jekyll-pwa-workbox?type=total)
[![MIT license](http://img.shields.io/badge/license-MIT-orange.svg)](http://opensource.org/licenses/MIT)
# Jekyll PWA Workbox Plugin

_note on future releases; we will be using the same version number as Workbox from here on._

A Jekyll plugin that makes your PWA / Website available offline and lets you install on desktop and mobile*.   
It generates and injects a precache list into a [Workbox][workbox] service worker and handles the registration process in a secure way.   
_* does not fully work with iOS/Safari to date_

The plugin was originally developed by [Lavas Project](https://github.com/lavas-project/jekyll-pwa). It is pretty much the same, except for:
- for security reasons, the starter process is initiated from a js file to allow for ```script-src 'self'```, rather than ```unsafe-inline``` in your [Content Security Policy](https://content-security-policy.com/ "Content Security Policy reference").
- serves a minified `sw-register.js`.

---

This plugin supports **Workbox version 5.1.4** *.

_* in case you have been using a previous Workbox version (i.e. 3 or older), please see migration instructions [here](https://developers.google.com/web/tools/workbox/guides/migrations/migrate-from-v3)._    

There are various tools available on the [Workbox][workbox] tools page, that let you easily generate a service worker with Webpack or Gulp as your build tool. 

We do not use `npm` and therefore integrate this function in the Jekyll build process to precache and make posts/pages available offline, even if they have never been visited before. 

---

## Prerequisites

### Web App Manifest

A `manifest.json` is required to experience the full features of your PWA.

In case you do not have one already, please read the following about creating and adding a [manifest.json](https://developers.google.com/web/fundamentals/web-app-manifest/).
Add it to the root directory of your project and Jekyll will deploy it to `_site` when your PWA / Website builds.    

Use `Chrome DevTools > Application` for debugging/testing.
 

## Installation

This plugin is available as a [RubyGem][ruby-gem].

### Option #1

Add `gem 'jekyll-pwa-workbox'` to the `jekyll_plugin` group in your `Gemfile`:

```ruby
source 'https://rubygems.org'

gem 'jekyll'

group :jekyll_plugins do
  gem "jekyll-pwa-workbox"
end
```

Then run `bundle` to install the gem.

### Option #2

Alternatively, you can also install the gem manually, using the following command:

```
$ gem install jekyll-pwa-workbox
```

Once the gem has been installed successfully, add the following to your `_config.yml` in order to tell Jekyll to use the plugin:

```
plugins:
- jekyll-pwa-workbox
```

## Getting Started

### Configuration

Add the following configuration block to Jekyll's `_config.yml`:
```yaml
pwa:
  sw_src_filepath: service-worker.js # Optional
  sw_dest_filename: service-worker.js # Optional
  dest_js_directory: assets/js # Required
  precache_recent_posts_num: 5 # Optional
  precache_glob_directory: / # Optional
  precache_glob_patterns: # Optional
    - "/**/*.{js,json,css}"
    - "/**/*.{ico,jpg,jpeg,png,svg}"
    - "/**/*.html"
  precache_glob_ignores: # Optional
    - "sw-register.js"
    - "fonts/**/*"
```

Parameter                 | Description
----------                | ------------
sw_src_filepath           | Filepath of the source service worker. Defaults to `service-worker.js`
sw_dest_filename          | Filename of the destination service worker. Defaults to `service-worker.js`
dest_js_directory         | Directory of JS in `_site`. During the build process, some JS like workbox.js will be copied to this directory so that service worker can import them in runtime.
precache_glob_directory   | Directory of precache. [Workbox Config](https://developers.google.com/web/tools/workbox/get-started/webpack#optional-config)
precache_glob_patterns    | Patterns of precache. [Workbox Config](https://developers.google.com/web/tools/workbox/get-started/webpack#optional-config)
precache_glob_ignores     | Ignores of precache. [Workbox Config](https://developers.google.com/web/tools/workbox/get-started/webpack#optional-config)
precache_recent_posts_num | Number of recent posts to precache.

We handle precache and runtime cache with the help of [Workbox][workbox] in service worker.


## Service Worker

### Write your own

Create a `service-worker.js` in the root path of your Jekyll project. The source file's path can be adjusted with the `sw_src_filepath` option.

You can write your own service worker with [Workbox APIs](https://developers.google.com/web/tools/workbox/reference-docs/latest/).

### Basic example

Here is a basic example of [service-worker.js](./service-worker.js):
```javascript
// service-worker.js

// set names for both precache & runtime cache
workbox.core.setCacheNameDetails({
    prefix: 'my-blog',
    suffix: 'v1.0',
    precache: 'precache',
    runtime: 'runtime-cache'
});

// let Service Worker take control of pages ASAP
workbox.core.skipWaiting();
workbox.core.clientsClaim();

// let Workbox handle our precache list
workbox.precaching.precacheAndRoute(self.__precacheManifest);

// use `NetworkFirst` strategy for html
workbox.routing.registerRoute(
    /\.html$/,
    new workbox.strategies.NetworkFirst()
);

// use `NetworkFirst` strategy for css and js
workbox.routing.registerRoute(
    /\.(?:js|css)$/,
    new workbox.strategies.NetworkFirst()
);

// use `CacheFirst` strategy for images
workbox.routing.registerRoute(
    /assets\/(img|icons)/,
    new workbox.strategies.CacheFirst()
);

// use `StaleWhileRevalidate` third party files
workbox.routing.registerRoute(
    /^https?:\/\/cdn.staticfile.org/,
    new workbox.strategies.StaleWhileRevalidate()
);
```


## Register the Service Worker

Add the following two blocks to an existing JS file (i.e. app.js):    

*this must be at the start of your JS file, before any other code, so that the script-src can be generated*
```
---
layout: null
---
```


*this snippet can live anywhere in your JS file (i.e. app.js)*
```javascript
window.onload = function () {
    var script = document.createElement('script');
    var firstScript = document.getElementsByTagName('script')[0];
    script.async = true;
    script.src = '{{'sw-register.js'|relative_url}}?v=' + Date.now();
    firstScript.parentNode.insertBefore(script, firstScript);
};
```

OR use any of these files to start the service worker registration:
- [pwa-1.0.js](./pwa-1.0.js)
- [pwa-1.0.min.js](./pwa-1.0.min.js)


DONE - use `Chrome DevTools`for debugging/testing.

---

## Notes

### Updates / Manual Refresh

When the PWA / Website updates, the service worker will go into the `install` stage and request the newest resources, but the user must refresh current page manually so that these updates can be applied. 
This can be done by notifying the user with a toast such as `website updated - please refresh the page manually` or whatever else fits your needs.

### Workbox Plugins

Workbox also comes with a set of plugins, details of how to use these can be found in the [Workbox Guide - Using Plugins](https://developers.google.com/web/tools/workbox/guides/using-plugins)

## Contribute

Fork this repository, make your changes and then issue a pull request. If you find a bug or if you have new ideas, please file an issue in our [bug tracker](https://github.com/souldanger/jekyll-pwa-workbox/issues).

## Copyright

Copyright &copy; 2019 souldanger

Copyright &copy; 2017 Pan Yuqi, Xing Peng

License: [MIT](https://github.com/souldanger/jekyll-pwa-workbox/blob/master/LICENSE)

[ruby-gem]: https://rubygems.org/gems/jekyll-pwa-workbox
[workbox]: https://developers.google.com/web/tools/workbox/
