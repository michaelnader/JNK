import React, { useEffect, useMemo, useState } from 'react';
import { api } from '../lib/api.js';
import { RestaurantCard } from '../components/restaurant-card.jsx';
import { Chip } from '../components/ui.jsx';

const FILTERS = [
  { key: 'all', label: 'All' },
  { key: 'Cairo', label: 'Cairo' },
  { key: 'Sahel', label: 'Sahel' },
  { key: 'Red Sea', label: 'Red Sea' },
];

export default function Restaurants() {
  const [all, setAll] = useState([]);
  const [filter, setFilter] = useState('all');
  useEffect(() => { api.restaurants().then(setAll).catch(() => {}); }, []);

  const filtered = useMemo(() => {
    if (filter === 'all') return all;
    return all.filter(r => r.tag.includes(filter));
  }, [all, filter]);

  return (
    <section className="container" style={{ paddingTop: 56, paddingBottom: 80 }}>
      <header style={{ marginBottom: 32 }}>
        <div className="lbl-eyebrow">The Group</div>
        <h1 className="h1" style={{ marginTop: 8 }}>Restaurants</h1>
        <p style={{ marginTop: 12, fontSize: 16, color: 'var(--text-mute-l)', maxWidth: 560 }}>
          Six rooms across Cairo, Sahel, and the Red Sea. Each on its own
          rhythm — same booking system.
        </p>
      </header>

      <div style={{ display: 'flex', gap: 8, flexWrap: 'wrap', marginBottom: 28 }}>
        {FILTERS.map(f => (
          <Chip
            key={f.key}
            active={filter === f.key}
            onClick={() => setFilter(f.key)}
          >{f.label}{f.key === 'all' ? ` · ${all.length}` : ''}</Chip>
        ))}
      </div>

      <div className="grid-cards">
        {filtered.map(r => <RestaurantCard key={r.id} r={r}/>)}
      </div>

      {filtered.length === 0 && (
        <p style={{ color: 'var(--text-mute-l)', marginTop: 48 }}>
          No restaurants in this region yet.
        </p>
      )}
    </section>
  );
}
