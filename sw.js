const CACHE_NAME = "zh-study-v5";
const STATIC_CACHE = "zh-static-v5";

const HTML_ROUTES = ["/", "/index.html", "/nuance-review", "/nuance-review.html"];
const STATIC_ASSETS = ["/manifest.webmanifest", "/icon.svg"];

self.addEventListener("install", (event) => {
  event.waitUntil(
    caches.open(STATIC_CACHE)
      .then((cache) => cache.addAll(STATIC_ASSETS))
      .catch(() => undefined)
  );
  self.skipWaiting();
});

self.addEventListener("activate", (event) => {
  event.waitUntil(
    caches.keys().then((keys) => Promise.all(
      keys
        .filter((key) => key !== CACHE_NAME && key !== STATIC_CACHE)
        .map((key) => caches.delete(key))
    ))
  );
  self.clients.claim();
});

self.addEventListener("fetch", (event) => {
  if (event.request.method !== "GET") return;

  const url = new URL(event.request.url);
  const isHtml = HTML_ROUTES.some((r) => url.pathname === r || url.pathname.endsWith(".html"));

  if (isHtml) {
    // 네트워크 우선: 배포하면 즉시 최신 버전 반영
    event.respondWith(
      fetch(event.request)
        .then((response) => {
          const copy = response.clone();
          caches.open(CACHE_NAME).then((cache) => cache.put(event.request, copy)).catch(() => undefined);
          return response;
        })
        .catch(() => caches.match(event.request).then((cached) => cached || caches.match("/index.html")))
    );
  } else {
    // 정적 자산: 캐시 우선 (폰트·아이콘 등 변경 없는 파일)
    event.respondWith(
      caches.match(event.request).then((cached) => {
        if (cached) return cached;
        return fetch(event.request).then((response) => {
          const copy = response.clone();
          caches.open(STATIC_CACHE).then((cache) => cache.put(event.request, copy)).catch(() => undefined);
          return response;
        }).catch(() => undefined);
      })
    );
  }
});
