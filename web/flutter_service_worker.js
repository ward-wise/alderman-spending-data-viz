'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"version.json": "911eab0b1998820db76d290193c0c77e",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"index.html": "dcadb0fa6a28848b4b11206f6d4d4f2e",
"/": "dcadb0fa6a28848b4b11206f6d4d4f2e",
"manifest.json": "b65d3b0e0ce3c1f7efa65e7a8bc40555",
"canvaskit/skwasm.wasm": "d1fde2560be92c0b07ad9cf9acb10d05",
"canvaskit/canvaskit.wasm": "19d8b35640d13140fe4e6f3b8d450f04",
"canvaskit/skwasm.js": "95f16c6690f955a45b2317496983dbe9",
"canvaskit/chromium/canvaskit.wasm": "1165572f59d51e963a5bf9bdda61e39b",
"canvaskit/chromium/canvaskit.js": "96ae916cd2d1b7320fff853ee22aebb0",
"canvaskit/canvaskit.js": "bbf39143dfd758d8d847453b120c8ebb",
"canvaskit/skwasm.worker.js": "51253d3321b11ddb8d73fa8aa87d3b15",
"main.dart.js": "a2d56631384c3760b89631dbfe32d25b",
"flutter.js": "6fef97aeca90b426343ba6c5c9dc5d4a",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
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
"assets/assets/Wards-Boundaries.geojson": "aec7a137616fc1beb67d25006d4e2ba2",
"assets/assets/menu_items_info.csv": "0f45cbcda005716c6784bf091643c6fc",
"assets/assets/menu_items_information.docx": "6a25d3496045db095fb359b04d9352e9",
"assets/assets/2019-2022_ward_items.csv": "e8df8a9d51733a6ea3e2c752ca6c8faf",
"assets/assets/spending_by_category.csv": "bbae284755c4ad48fc5baf0b90ec0993",
"assets/assets/viaduct_item_info.csv": "452da20f727d98259191f5a509c20868",
"assets/assets/ward_contact_info.csv": "cf6278360c4f404d28ef7f9987d86398",
"assets/assets/2019-2022_ward_category_totals.csv": "5c36e9adc1ec895e340a57d445160121",
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
"assets/shaders/ink_sparkle.frag": "f8b80e740d33eb157090be4e995febdf",
"assets/AssetManifest.json": "a38cca2f9ec87a1023b2bcc204e28a28",
"assets/AssetManifest.bin": "75dc250cf3c793d3c03fe532d60bb993",
"assets/NOTICES": "cb8cbc88be123ce2c2c0b1059c4a6b2a",
"assets/fonts/MaterialIcons-Regular.otf": "bb81deb7d1486ab193baaccec9b1057b",
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
