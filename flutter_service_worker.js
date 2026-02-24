'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "b1d68242d7c5fd73758d9a6f47ef9181",
"assets/AssetManifest.bin.json": "5305e16b864d04d2abd7c407904f605e",
"assets/assets/cordel_image1.png": "8678962c96cff6ab6f6bfb49248753af",
"assets/assets/cordel_image2.png": "3d30f83e23ad05fb31996254cc5873ab",
"assets/assets/cordel_image3.png": "341c0730d223772d08808109ba4e571b",
"assets/assets/cordel_image4.png": "826ec51e1e32ddb62b5d2f58e7b28a26",
"assets/assets/cordel_image5.png": "1e95ebe416ec8d23376ec20e1066bf30",
"assets/assets/cordel_image6.png": "38dde6b680b50191c49cbaff5f8fede6",
"assets/assets/cordel_image7.png": "17a50313fa92a11ed1427fe784d82e0f",
"assets/assets/cordel_image8.png": "52680b61dc34b58e7503e64e126c4353",
"assets/assets/cordel_image9.png": "4d8f67be768d786b9853aceace5ab917",
"assets/assets/cordel_miss.png": "5094b4aa95a1a462c99d25a6999483ff",
"assets/assets/ges_img_0.png": "3aa693e8a880bbee9c028aa1534befbc",
"assets/assets/ges_img_1.png": "85c860dea1839562a447ec5994bcfa97",
"assets/assets/ges_img_3.png": "430d37485aba093f746ff59ea1556a8b",
"assets/assets/ges_img_4.png": "1d8fab3f5836ea0d032701eff62a8765",
"assets/assets/greece_flag.png": "82687f9c4091d1ac1e60a105990b01ca",
"assets/assets/home_icon.png": "5bea092e6112e6c7009f8439605f93b3",
"assets/assets/job_img.jpeg": "f2c5215f6e5b0219a3b6fd92fae97fcc",
"assets/assets/MACHINE_KATALOG.pdf": "f424d648b7499e9960363b4c623a23f8",
"assets/assets/panel.png": "3a4fed695cf74e67530aa77183dee6ab",
"assets/assets/panel_icon.png": "2bac10a05566283c0f9d09edb159b030",
"assets/assets/pylone_cable_icon.png": "7f6bb6c503a43c925cbc0b47d77c728e",
"assets/assets/sun-icon.png": "c0b815fdd432ea5fd302388c6bd140af",
"assets/assets/sun-icon2.png": "a627c4e40043b3553b47e43f075b8c69",
"assets/assets/turkish_flag.png": "b9f5d7b7015e4c12ba57b186c94c28bd",
"assets/assets/usa_flag.png": "e3173c69731c6b26255e3528a3c535a8",
"assets/assets/video/cordelVideo.mp4": "02b2d2691f5ad285e5f6362e82faff42",
"assets/assets/video/cordel_job.mp4": "f7f015bacc0e025887ba72a0a5e6d8c6",
"assets/assets/video/crop_cordel_reklam.mp4": "9c9c7caf8a49cdeeac65f924b52884ea",
"assets/assets/video/sarj_reklam.mp4": "8c4565bac5b35d75495e66b2891786fb",
"assets/assets/video/sarj_reklam_full.mp4": "fd3ce512d28b963cdb29763b41f2adee",
"assets/assets/video/vecteezy_flying.mp4": "85c5cf06cbd9df4490340b41b273b7e2",
"assets/assets/video/vecteezy_solar-system-majesty.mp4": "c14ab15b3ede1024326eca5d171e6abb",
"assets/assets/video/videoplayback.mp4": "8b1b4f8111a5c7c651409b057a623bec",
"assets/assets/video/videoplayback1.mp4": "7b6278d7e7ac1599dec516a9d5051aaa",
"assets/FontManifest.json": "2b52acee7bee9f34d372a965ef37754f",
"assets/fonts/MaterialIcons-Regular.otf": "ad875550fa8fc0c661501f222aea1b6d",
"assets/NOTICES": "d3dfaa4a90e06962fa8da2cc50a90a66",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/packages/syncfusion_flutter_pdfviewer/assets/fonts/RobotoMono-Regular.ttf": "5b04fdfec4c8c36e8ca574e40b7148bb",
"assets/packages/syncfusion_flutter_pdfviewer/assets/icons/dark/highlight.png": "2aecc31aaa39ad43c978f209962a985c",
"assets/packages/syncfusion_flutter_pdfviewer/assets/icons/dark/squiggly.png": "68960bf4e16479abb83841e54e1ae6f4",
"assets/packages/syncfusion_flutter_pdfviewer/assets/icons/dark/strikethrough.png": "72e2d23b4cdd8a9e5e9cadadf0f05a3f",
"assets/packages/syncfusion_flutter_pdfviewer/assets/icons/dark/underline.png": "59886133294dd6587b0beeac054b2ca3",
"assets/packages/syncfusion_flutter_pdfviewer/assets/icons/light/highlight.png": "2fbda47037f7c99871891ca5e57e030b",
"assets/packages/syncfusion_flutter_pdfviewer/assets/icons/light/squiggly.png": "9894ce549037670d25d2c786036b810b",
"assets/packages/syncfusion_flutter_pdfviewer/assets/icons/light/strikethrough.png": "26f6729eee851adb4b598e3470e73983",
"assets/packages/syncfusion_flutter_pdfviewer/assets/icons/light/underline.png": "a98ff6a28215341f764f96d627a5d0f5",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/shaders/stretch_effect.frag": "40d68efbbf360632f614c731219e95f0",
"canvaskit/canvaskit.js": "8331fe38e66b3a898c4f37648aaf7ee2",
"canvaskit/canvaskit.js.symbols": "a3c9f77715b642d0437d9c275caba91e",
"canvaskit/canvaskit.wasm": "9b6a7830bf26959b200594729d73538e",
"canvaskit/chromium/canvaskit.js": "a80c765aaa8af8645c9fb1aae53f9abf",
"canvaskit/chromium/canvaskit.js.symbols": "e2d09f0e434bc118bf67dae526737d07",
"canvaskit/chromium/canvaskit.wasm": "a726e3f75a84fcdf495a15817c63a35d",
"canvaskit/skwasm.js": "8060d46e9a4901ca9991edd3a26be4f0",
"canvaskit/skwasm.js.symbols": "3a4aadf4e8141f284bd524976b1d6bdc",
"canvaskit/skwasm.wasm": "7e5f3afdd3b0747a1fd4517cea239898",
"canvaskit/skwasm_heavy.js": "740d43a6b8240ef9e23eed8c48840da4",
"canvaskit/skwasm_heavy.js.symbols": "0755b4fb399918388d71b59ad390b055",
"canvaskit/skwasm_heavy.wasm": "b0be7910760d205ea4e011458df6ee01",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "24bc71911b75b5f8135c949e27a2984e",
"flutter_bootstrap.js": "d4b0e0d8437954ae8cf14e0864e333ed",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "3da488fcb973d7830ef8e57b98702014",
"/": "3da488fcb973d7830ef8e57b98702014",
"main.dart.js": "cf98c35dfca43a5ee7428d9cd0c5b024",
"manifest.json": "e6458b7c6ac020ad3e585a19f60989e9",
"version.json": "f2e7af6f6d19f33715089d8c0faa7e9c"};
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
