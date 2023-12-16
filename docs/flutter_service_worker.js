'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"version.json": "911eab0b1998820db76d290193c0c77e",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"CNAME": "62760d5f5d558856116a2edce90df177",
"index.html": "93dc3d160c95373aae8e190bf06a3e8f",
"/": "93dc3d160c95373aae8e190bf06a3e8f",
"manifest.json": "e5a85ef23571a565ee08a09a992d31be",
"canvaskit/skwasm.wasm": "2fc47c0a0c3c7af8542b601634fe9674",
"canvaskit/canvaskit.wasm": "73584c1a3367e3eaf757647a8f5c5989",
"canvaskit/skwasm.js": "87063acf45c5e1ab9565dcf06b0c18b8",
"canvaskit/chromium/canvaskit.wasm": "143af6ff368f9cd21c863bfa4274c406",
"canvaskit/chromium/canvaskit.js": "0ae8bbcc58155679458a0f7a00f66873",
"canvaskit/canvaskit.js": "eb8797020acdbdf96a12fb0405582c1b",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"main.dart.js": "c58b321d89906df934fdeb79c1eccf7d",
"flutter.js": "7d69e653079438abfbb24b82a655b0a4",
"assets/FontManifest.json": "5a32d4310a6f5d9a6b651e75ba0d7372",
"assets/AssetManifest.bin.json": "34a10e5f4ce767049193dbe4ce3a42b6",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "89ed8f4e49bcdfc0b5bfc9b24591e347",
"assets/packages/getwidget/icons/line.png": "da8d1b531d8189396d68dfcd8cb37a79",
"assets/packages/getwidget/icons/whatsapp.png": "30632e569686a4b84cc68169fb9ce2e1",
"assets/packages/getwidget/icons/youtube.png": "1bfda73ab724ad40eb8601f1e7dbc1b9",
"assets/packages/getwidget/icons/wechat.png": "ba10e8b2421bde565e50dfabc202feb7",
"assets/packages/getwidget/icons/dribble.png": "1e36936e4411f32b0e28fd8335495647",
"assets/packages/getwidget/icons/facebook.png": "293dc099a89c74ae34a028b1ecd2c1f0",
"assets/packages/getwidget/icons/slack.png": "19155b848beeb39c1ffcf743608e2fde",
"assets/packages/getwidget/icons/linkedin.png": "822742104a63a720313f6a14d3134f61",
"assets/packages/getwidget/icons/twitter.png": "caee56343a870ebd76a090642d838139",
"assets/packages/getwidget/icons/google.png": "596c5544c21e9d6cb02b0768f60f589a",
"assets/packages/getwidget/icons/pinterest.png": "d52ccb1e2a8277e4c37b27b234c9f931",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "246eb4e50e87d5de3a03ebcd70f0b9d8",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "a5d7457fda15b7622c14f432ba63039a",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "2e4d399992bbce7fa78dba1cdfdbddc4",
"assets/assets/Wards-Boundaries.geojson": "aec7a137616fc1beb67d25006d4e2ba2",
"assets/assets/menu_items_info.csv": "0f45cbcda005716c6784bf091643c6fc",
"assets/assets/2012-2023_ward_category_totals.csv": "0d5e0c3235cc79cb7dc16aed6960a1a3",
"assets/assets/menu_items_information.docx": "6a25d3496045db095fb359b04d9352e9",
"assets/assets/Chicago_map_sublayer.png": "4cfb96310c5651facebb99f84af2fcbb",
"assets/assets/spending_by_category_2012-2023.csv": "61c2739c4a989160f581e44906ad2ab1",
"assets/assets/spending_by_category.csv": "bbae284755c4ad48fc5baf0b90ec0993",
"assets/assets/Wards-Boundaries-2015-2023.geojson": "ce3643e3cb314eae839d44cee8c6f3e7",
"assets/assets/Wards-Boundaries-2003-2015.geojson": "d779ca24121285d9d0eef908971b432a",
"assets/assets/viaduct_item_info.csv": "452da20f727d98259191f5a509c20868",
"assets/assets/ward_contact_info.csv": "9d3368d3d2cb2fb6d7d893b29237806f",
"assets/assets/2012-2023_ward_items.csv": "1cc8f2f79d39c9293a1c4218426c0236",
"assets/assets/images/usa.png": "bc90ea652438473d880f328bbf9cc8ca",
"assets/assets/images/chicago_flag.png": "c22c1172c69912e97cc081b946a12e4a",
"assets/assets/images/menu_items/ResidentialStreetBump-Outs.png": "0b62e4368d5e1c81b795927dcea13af9",
"assets/assets/images/menu_items/StreetLightPolePaintingProgram.png": "3fa0480e19f7e310719ee2a63a15a955",
"assets/assets/images/menu_items/BikeLaneMarkedSharedLane.png": "7558736de307d8f368eb6551bb7f7519",
"assets/assets/images/menu_items/ProtectedBikeLane.png": "6d523ac919b98eaaa1e7d08134a9ea5b",
"assets/assets/images/menu_items/ViaductImprovements.png": "c410782abe40e20c40d9f4a737be18bf",
"assets/assets/images/menu_items/SidewalkReplacementProgram.png": "9f331668107f72d14bf7b58330bcd8b4",
"assets/assets/images/menu_items/CurbGutterReplacementProgram.png": "c26e804217e0d62c2705b0a1f8886b0a",
"assets/assets/images/menu_items/NeighborhoodGreenways.png": "0382348aa868fa4faf19b5d0f95c5edc",
"assets/assets/images/menu_items/GreenAlleyProgram.png": "b89087135456d1af8bf774be521da942",
"assets/assets/images/menu_items/ResidentialStreetLightingProgramPiggyBack.png": "9fcc2c231233fc4f741f7eed2e7e4925",
"assets/assets/images/menu_items/AlleySpeedHumpProgram.png": "6acb65053bbc47b747a055eb2b8d2327",
"assets/assets/images/menu_items/FloodlightInstallation.png": "9517bf9e0876c2f2e671191cd275cb37",
"assets/assets/images/menu_items/ResidentialStreetTrafficCircle.png": "297385270fced3e318662a5741725230",
"assets/assets/images/menu_items/StreetSpeedHumpProgram.png": "e2f1d31c5a8e0850383717e9888c3154",
"assets/assets/images/menu_items/PedestrianRefugeIsland.png": "9e551be579bd3a481ea8336e570e36a5",
"assets/assets/images/menu_items/TrafficSignalIntersectionPolePaintingProgram.png": "9321645238ce90c8ac6d22a4b84cb05b",
"assets/assets/images/menu_items/ResidentialStreetCul-de-Sac.png": "5434bbaa1ca8d7910e744981874af2ce",
"assets/assets/images/menu_items/DiagonalParking.png": "19d11ce170625fa7bacfb2ee7be1236f",
"assets/assets/images/menu_items/ConcreteAlleyApron.png": "5e3c0cb049d2c0c23d657bc330c2671c",
"assets/assets/images/menu_items/ResidentialAlleyResurfacing.png": "6bb3bc99d88718b414ceb3d8139f8af9",
"assets/assets/images/menu_items/ResidentialStreetResurfacing.png": "a38c23b92f210437d91c03317b62236d",
"assets/assets/images/menu_items/ArterialStreetBumpOuts.png": "ad59793c475c3c5035525496c9c7923d",
"assets/assets/images/menu_items/BufferedBikeLane.png": "d7c7f55861ca26c2bbb47025d2a891ba",
"assets/assets/images/mexico.png": "60ec08877fea2e7506654ac7917b1e7e",
"assets/shaders/ink_sparkle.frag": "4096b5150bac93c41cbc9b45276bd90f",
"assets/AssetManifest.json": "af8b114b34d6a8527cc2c182654e9552",
"assets/AssetManifest.bin": "8425c5289fe1ae2ef461e7f56cff82d8",
"assets/NOTICES": "e1d1b66352c51697c58403c9c9c8e382",
"assets/fonts/MaterialIcons-Regular.otf": "871ef9b73d4841b9ff418ca45d558674",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.json",
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
