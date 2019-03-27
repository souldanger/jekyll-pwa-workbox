[![Gem Version](https://badge.fury.io/rb/jekyll-pwa-workbox.svg)](https://badge.fury.io/rb/jekyll-pwa-workbox)
# Jekyll PWA Workbox Plugin


This Jekyll plugin makes your PWA / Website available offline and allows you to install on desktop or mobile*.   
It uses a Workbox service worker, generates and injects a precache list into it and takes care of the registration process in a secure way.   
_* does not fully work with iOS/Safari to date_

The plugin was originally developed by Pan Yuqi and sekiyika from [Lavas Project](https://github.com/lavas-project/jekyll-pwa).   
It is pretty much the same, except for:
- the starter process is initiated from a js file to allow for ```script-src: 'self';``` in your CSP, rather than inline.
- serves `sw-register.js` minified for better auditing results.

---

Google has developed a series of tools, these are available on their [Workbox](https://developers.google.com/web/tools/workbox/) page.   
If you use Webpack or Gulp as your build tool, you can easily generate a service worker with these tools. 
As we do not want to use npm, we would like to precache and make posts and pages available offline, even if they have never been visited before. 
Therefore we are integrating this function in the Jekyll build process.
 
**IMPORTANT** This plugin supports Workbox version 3.x.x. If you are still using `v1.x.x`, you will have to migrate. 
A migration guide is available [here](./MIGRATE.md).   
The API of Workbox V3 has changed a lot compared to v2, some more powerful functions have been added too.


## Installation

This plugin is available as a [RubyGem][ruby-gem].

### Option #1

Add `gem 'jekyll-pwa-workbox'` to the `jekyll_plugin` group in your `Gemfile`:

```ruby
source 'https://rubygems.org'

gem 'jekyll'

group :jekyll_plugins do
  gem 'jekyll-pwa-workbox'
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
    - "{js,css,fonts}/**/*.{js,css,eot,svg,ttf,woff}"
    - index.html
  precache_glob_ignores: # Optional
    - sw-register.js
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

We handle precache and runtime cache with the help of Google Workbox in service worker.

### Start the Service Worker

Add the following two blocks to an existing JS file:    

*this must be on the top of JS file, before any other code, so that the script-src can be generated*
```
---
layout: null
---
```


*this snippet can live anywhere in your JS file*
```javascript
window.onload = function () {
    var script = document.createElement('script');
    var firstScript = document.getElementsByTagName('script')[0];
    script.type = 'text/javascript';
    script.async = true;
    script.src = '{{'sw-register.js'|relative_url}}?v=' + Date.now();
    firstScript.parentNode.insertBefore(script, firstScript);
};
```

OR use any of these files to start the service worker registration:
- [pwa-1.0.js](./pwa-1.0.js)
- [pwa-1.0.min.js](./pwa-1.0.min.js)


### Write your own Service Worker

Create a `service-worker.js` in the root path of your Jekyll project.
You can change the source file's path with `sw_src_filepath` option.

Now you can write your own Service Worker with [Workbox APIs](https://developers.google.com/web/tools/workbox/reference-docs/latest/).

Here's an exmaple of [service-worker.js](./service-worker.js) or create one yourself:
```javascript
// service-worker.js

// set names for both precache & runtime cache
workbox.core.setCacheNameDetails({
    prefix: 'my-blog',
    suffix: 'v1',
    precache: 'precache',
    runtime: 'runtime-cache'
});

// let Service Worker take control of pages ASAP
workbox.skipWaiting();
workbox.clientsClaim();

// let Workbox handle our precache list
workbox.precaching.precacheAndRoute(self.__precacheManifest);

// use `networkFirst` strategy for `*.html`, like all my posts
workbox.routing.registerRoute(
    /\.html$/,
    workbox.strategies.networkFirst()
);

// use `cacheFirst` strategy for images
workbox.routing.registerRoute(
    /assets\/(img|icons)/,
    workbox.strategies.cacheFirst()
);

// third party files
workbox.routing.registerRoute(
    /^https?:\/\/cdn.staticfile.org/,
    workbox.strategies.staleWhileRevalidate()
);
```

## Note

### Generate a manifest.json?

This plugin won't generate a [manifest.json](https://developer.mozilla.org/en-US/docs/Web/Manifest). If you want to support this PWA feature, just add one in your root directory and Jekyll will copy it to `_site`.

### When my site updates...

As the service worker has precached our assets such as `index.html`, JS files and other static files, we should notify user when our site has something changed. When these updates happen, the service worker will go into the `install` stage and request the newest resources, but the user must refresh current page so that these updates can be applied. A normal solution is showing a toast with the following text: `This site has changed, please refresh current page manually.`.

This plugin will dispatch a custom event called `sw.update` when the service worker has finished the update work. So in your site, you can choose to listen this event and popup a toast to remind users refreshing current page.

# Contribute

Fork this repository, make your changes and then issue a pull request. If you find bugs or have new ideas that you do not want to implement yourself, file a bug report.

# Copyright

Copyright &copy; 2019 Pan Yuqi, sekiyika, souldanger

License: MIT

[ruby-gem]: https://rubygems.org/gems/jekyll-pwa-workbox
