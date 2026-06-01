// G'nK Restaurants — tiny Express API + static host.
//
// In dev: the Vite client (port 5373) proxies /api/* and /photos/* here.
// In prod (after `npm run build`): this server also serves client/dist
// so a single port (4000) hosts the whole site.

import express from 'express';
import cors from 'cors';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import {
  RESTAURANTS, RESERVATIONS,
  nextReservationId, newConfirmationCode,
} from './data.js';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const app = express();
const PORT = process.env.PORT || 4100;

app.use(cors());
app.use(express.json());

// ─── photos ──────────────────────────────────────────────────────────────
app.use('/photos', express.static(path.join(__dirname, 'photos'), {
  maxAge: '7d',
  immutable: true,
}));

// ─── api ─────────────────────────────────────────────────────────────────
app.get('/api/restaurants', (_req, res) => {
  res.json(RESTAURANTS);
});

app.get('/api/restaurants/:id', (req, res) => {
  const r = RESTAURANTS.find((x) => x.id === req.params.id);
  if (!r) return res.status(404).json({ error: 'not_found' });
  res.json(r);
});

app.get('/api/reservations', (_req, res) => {
  // Newest first
  res.json([...RESERVATIONS].sort((a, b) => b.dateISO.localeCompare(a.dateISO)));
});

app.post('/api/reservations', (req, res) => {
  const {
    restaurantId, dateISO, guestCount,
    occasion = null, dietary = [], note = '',
  } = req.body ?? {};

  if (!restaurantId || !dateISO || !guestCount) {
    return res.status(400).json({
      error: 'missing_fields',
      required: ['restaurantId', 'dateISO', 'guestCount'],
    });
  }
  if (!RESTAURANTS.find((x) => x.id === restaurantId)) {
    return res.status(400).json({ error: 'unknown_restaurant' });
  }

  const reservation = {
    id: nextReservationId(),
    restaurantId,
    dateISO,
    guestCount: Number(guestCount),
    occasion,
    dietary: Array.isArray(dietary) ? dietary : [],
    note: String(note),
    status: 'confirmed',
    code: newConfirmationCode(),
    createdAt: new Date().toISOString(),
  };
  RESERVATIONS.unshift(reservation);
  res.status(201).json(reservation);
});

app.get('/api/health', (_req, res) => {
  res.json({ ok: true, restaurants: RESTAURANTS.length, reservations: RESERVATIONS.length });
});

// ─── prod: serve the built client ────────────────────────────────────────
const clientDist = path.resolve(__dirname, '../client/dist');
app.use(express.static(clientDist));
app.get(/^(?!\/(api|photos)).*/, (_req, res) => {
  res.sendFile(path.join(clientDist, 'index.html'), (err) => {
    if (err) res.status(404).send('client/dist not built — run `npm run build` first');
  });
});

app.listen(PORT, () => {
  // eslint-disable-next-line no-console
  console.log(`[gnk] api + static on http://localhost:${PORT}`);
});
