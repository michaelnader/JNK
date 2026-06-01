// Tiny fetch wrappers. All requests hit the Express server through the
// Vite dev proxy (or directly when the same server hosts the built client).

async function jsonFetch(url, init) {
  const res = await fetch(url, {
    headers: { 'content-type': 'application/json', ...(init?.headers ?? {}) },
    ...init,
  });
  if (!res.ok) {
    const body = await res.text().catch(() => '');
    throw new Error(`${res.status} ${res.statusText} — ${body || url}`);
  }
  return res.json();
}

export const api = {
  restaurants:        () => jsonFetch('/api/restaurants'),
  restaurant:    (id) => jsonFetch(`/api/restaurants/${id}`),
  reservations:       () => jsonFetch('/api/reservations'),
  createReservation: (body) =>
    jsonFetch('/api/reservations', { method: 'POST', body: JSON.stringify(body) }),
};
