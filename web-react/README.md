# G'nK Restaurants — React webview

React + Vite port of the Off Duty v8 prototype. All 11 phone artboards rendered
in fixed-size 402×874 iOS device frames on a design canvas, mirroring the
original bundle.

## Run

```bash
cd web-react
npm install       # already done if you see node_modules/
npm run dev       # http://localhost:5173 (auto-opens browser)
```

## Build static bundle

```bash
npm run build     # output → web-react/dist/
npm run preview   # http://localhost:4173 (serves dist/)
```

The `dist/` folder is a static site you can drag onto Netlify Drop, Vercel,
GitHub Pages, or any HTTP host. (Opening `dist/index.html` directly via
`file://` will NOT work — ES modules need to be served over HTTP.)

## Layout

```
web-react/
├── index.html              # Vite entry
├── package.json
├── vite.config.js
├── public/photos/          # 6 restaurant JPEGs
└── src/
    ├── main.jsx            # React root
    ├── App.jsx             # DesignCanvas — 4 sections × 11 artboards
    ├── theme.js            # T5 palette + PHOTOS + RESTAURANTS data
    ├── ios.jsx             # IOSDevice frame + status bar
    ├── components.jsx      # ScreenBg, Card{Dark/Light/Gold/Photo}, CTA, Chip, etc.
    └── screens.jsx         # 11 screen components
```

## Embedding in the Flutter app as a WebView (optional)

If you want the Flutter app to host this React app inside a `WebView`:

1. `npm run build`
2. Host the `dist/` folder somewhere your Flutter app can reach
   (localhost during dev, or a real static URL in prod).
3. Add `webview_flutter: ^4.10.0` to `pubspec.yaml`.
4. Drop a `WebViewWidget` pointing at the URL.

Keep in mind: `webview_flutter` doesn't support Flutter web targets — use
mobile (iOS/Android) or desktop (`webview_windows`/`desktop_webview_window`).
