# G'nK Restaurants — Website

Full-website port of the Off Duty design: React + Vite client backed by an
Express + Node server. Same palette, typography, and component vocabulary as
the mobile prototype, but rebuilt as a responsive website with real URLs and
a small API.

## Layout

```
gnk-website/
├── package.json          # workspaces — runs server + client together
├── server/               # Express API on :4000
│   ├── index.js
│   ├── data.js           # restaurants + reservations (in-memory)
│   └── photos/           # 6 restaurant JPEGs served at /photos/*
└── client/               # Vite + React 18 + React Router on :5373
    ├── index.html
    ├── vite.config.js    # /api proxy -> :4000
    └── src/
        ├── main.jsx
        ├── App.jsx
        ├── lib/          # theme + API client + booking context
        ├── components/   # Site shell + Off Duty primitives
        └── pages/        # 11 routes
```

## Run

```bash
cd gnk-website
npm install              # installs root, server, and client (workspaces)
npm run dev              # client → http://localhost:5373
                         # server  → http://localhost:4000
```

The client's Vite dev server is configured with `host: true` so other devices
on the same Wi-Fi can hit it too — Vite will print the LAN URL.

## Production build

```bash
npm run build            # builds client/dist
npm start                # runs server (which also serves client/dist)
                         # → http://localhost:4000
```
