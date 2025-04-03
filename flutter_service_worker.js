'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"canvaskit/skwasm.js": "f2ad9363618c5f62e813740099a80e63",
"canvaskit/skwasm.wasm": "f0dfd99007f989368db17c9abeed5a49",
"canvaskit/skwasm.js.symbols": "80806576fa1056b43dd6d0b445b4b6f7",
"canvaskit/skwasm_st.js": "d1326ceef381ad382ab492ba5d96f04d",
"canvaskit/skwasm_st.wasm": "56c3973560dfcbf28ce47cebe40f3206",
"canvaskit/canvaskit.wasm": "efeeba7dcc952dae57870d4df3111fad",
"canvaskit/skwasm_st.js.symbols": "c7e7aac7cd8b612defd62b43e3050bdd",
"canvaskit/canvaskit.js": "6cfe36b4647fbfa15683e09e7dd366bc",
"canvaskit/canvaskit.js.symbols": "68eb703b9a609baef8ee0e413b442f33",
"canvaskit/chromium/canvaskit.wasm": "64a386c87532ae52ae041d18a32a3635",
"canvaskit/chromium/canvaskit.js": "ba4a8ae1a65ff3ad81c6818fd47e348b",
"canvaskit/chromium/canvaskit.js.symbols": "5a23598a2a8efd18ec3b60de5d28af8f",
"index.html": "ebea14e87b8bad1036132fd6338bf25f",
"/": "ebea14e87b8bad1036132fd6338bf25f",
"assets/NOTICES": "e02985c55acfeb3121ff47f195d0e14f",
"assets/assets/images/instagram.png": "5c570427ee23f69853d28aec805eee79",
"assets/assets/images/o_3.webp": "5581b26bf6482c7801168f96beb54a7b",
"assets/assets/images/google_logo.png": "e9612850a6cb55eb547266043e1eef86",
"assets/assets/images/o_2.webp": "2acb2224c859749eef0d7ed5aec8627d",
"assets/assets/images/ic_launcher.png": "94debbc83ab0e3c20f5b5fa7b2e49e66",
"assets/assets/images/imdb.png": "33fa3baf0e394e219a3cc13c1c77e3f4",
"assets/assets/images/o_1.webp": "bb371c26a10a76dadc67bf27a14f3e1d",
"assets/assets/images/placeholder.jpg": "a5fc8f6cc7f53a187d02f11405021a0b",
"assets/assets/fonts/Dosis-Book.ttf": "ba735d6750440c952c1ba0793adf7a71",
"assets/assets/fonts/Dosis-SemiBold.ttf": "c2f3638510ae60347343e3335aee5795",
"assets/assets/fonts/Dosis-Light.ttf": "3abc8753a394e3a1ab06b0a7a7f57119",
"assets/assets/fonts/Dosis-Bold.ttf": "ccb2ab50ca7958d0cd3c8d8e47730493",
"assets/assets/fonts/Dosis-Medium.ttf": "39e264b36985746779360ea14f00ab63",
"assets/assets/fonts/Dosis-ExtraBold.ttf": "e18ccb71462eb63d23530a8a5aae8026",
"assets/assets/fonts/Dosis-ExtraLight.ttf": "d84708e9edafade4011844e864823b61",
"assets/assets/fonts/FrinoIcons.ttf": "374031c28b365ea9539e8160b2931afc",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "1894172096000b43ffc458aa42200923",
"assets/fonts/MaterialIcons-Regular.otf": "eceb92affe6dcd0154214958ec0e882d",
"assets/FontManifest.json": "117dc2584266d1598761779d7a40dcd1",
"assets/AssetManifest.bin.json": "194b933c1a1e2a71d4aaee4421aeb28b",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "d4532caeb29185fd25c1f7d37bc49556",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "88ad00303d38b1d113cbf4ffc4b0e906",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "305203d730d40d6b3319ba685dd08098",
"assets/packages/panara_dialogs/assets/info.png": "e4bb5858c90ab48c72f11ba44bb26b5b",
"assets/packages/panara_dialogs/assets/confirm.png": "acf806139cb7c12e09fc5ca1185b8a2f",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/AssetManifest.json": "137dc0385ca1969355dfd5264f185ec3",
"version.json": "137f54ebc1e9222098dd30ec8c48cc0c",
"flutter.js": "76f08d47ff9f5715220992f993002504",
"main.dart.js": "891540dc145adcad3f866702bca4d0c2",
"icons/Icon-maskable-512.png": "be43ac82ac5e347839cd4416fbd6f813",
"icons/Icon-192.png": "550fcff9e3e62f2d358b4fbd592dfb20",
"icons/Icon-512.png": "be43ac82ac5e347839cd4416fbd6f813",
"icons/Icon-maskable-192.png": "550fcff9e3e62f2d358b4fbd592dfb20",
"manifest.json": "85ad31b67a992aaaa738be55a4d5ee82",
"favicon.png": "3ad0a160d6c3044e1fd06edce561fe1e",
"flutter_bootstrap.js": "b511623b8b75d16de6cc2ec0e3142218"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
