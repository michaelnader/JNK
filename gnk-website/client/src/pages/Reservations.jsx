import React, { useEffect, useMemo, useState } from 'react';
import { Link } from 'react-router-dom';
import { api } from '../lib/api.js';
import { Avatar } from '../components/photo.jsx';
import { CardDark, CardLight, CardPhoto } from '../components/cards.jsx';
import { Chip, CTAStart, StatusBadge } from '../components/ui.jsx';
import { formatDate } from '../lib/format.js';

export default function Reservations() {
  const [list, setList] = useState([]);
  const [restaurants, setRestaurants] = useState({});
  const [tab, setTab] = useState('upcoming');

  useEffect(() => {
    Promise.all([api.reservations(), api.restaurants()]).then(([res, rs]) => {
      setList(res);
      setRestaurants(Object.fromEntries(rs.map(r => [r.id, r])));
    });
  }, []);

  const { upcoming, past, cancelled } = useMemo(() => {
    const upcoming = list.filter(r => r.status === 'confirmed');
    const past = list.filter(r => r.status === 'past');
    const cancelled = list.filter(r => r.status === 'cancelled');
    return { upcoming, past, cancelled };
  }, [list]);

  const visible = tab === 'upcoming' ? upcoming : tab === 'past' ? past : cancelled;

  return (
    <section className="container" style={{ paddingTop: 56, paddingBottom: 96, maxWidth: 920 }}>
      <header style={{ marginBottom: 24 }}>
        <div className="lbl-eyebrow">{list.length} bookings across G'nK</div>
        <h1 className="h1" style={{ marginTop: 8 }}>Reservations</h1>
      </header>

      <div style={{ display: 'flex', gap: 8, flexWrap: 'wrap', marginBottom: 28 }}>
        <Chip active={tab === 'upcoming'} gold={tab === 'upcoming'} onClick={() => setTab('upcoming')}>
          Upcoming · {upcoming.length}
        </Chip>
        <Chip active={tab === 'past'} onClick={() => setTab('past')}>
          Past · {past.length}
        </Chip>
        <Chip active={tab === 'cancelled'} onClick={() => setTab('cancelled')}>
          Cancelled · {cancelled.length}
        </Chip>
      </div>

      {visible.length === 0 && (
        <CardLight padding={48} style={{ textAlign: 'center' }}>
          <div className="lbl-eyebrow">Empty</div>
          <h3 className="h3" style={{ marginTop: 8 }}>Nothing here yet.</h3>
          <p style={{ color: 'var(--text-mute-l)', marginTop: 8 }}>
            <Link to="/restaurants" style={{ color: 'var(--gold-deep)', fontWeight: 600 }}>Browse the six rooms →</Link>
          </p>
        </CardLight>
      )}

      {/* Hero — first upcoming */}
      {tab === 'upcoming' && upcoming[0] && restaurants[upcoming[0].restaurantId] && (
        <CardPhoto
          photo={restaurants[upcoming[0].restaurantId].photo}
          style={{ height: 220, marginBottom: 16 }}
          padding={28}
        >
          <div style={{ display: 'flex', justifyContent: 'space-between', height: '100%', flexDirection: 'column' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', gap: 14 }}>
              <div>
                <div className="lbl-eyebrow" style={{ color: 'rgba(255,255,255,0.85)' }}>
                  Up next
                </div>
                <div style={{ fontSize: 36, fontWeight: 600, letterSpacing: -0.8, marginTop: 4 }}>
                  {restaurants[upcoming[0].restaurantId].name}
                </div>
                <div style={{ color: 'rgba(255,255,255,0.85)', marginTop: 6, fontSize: 14 }}>
                  {formatDate(upcoming[0].dateISO)} · {timeOf(upcoming[0].dateISO)} · {upcoming[0].guestCount} guests
                </div>
              </div>
              <StatusBadge>Confirmed</StatusBadge>
            </div>
            <div style={{ alignSelf: 'flex-end' }}>
              <Link to={`/restaurants/${upcoming[0].restaurantId}`} style={{ textDecoration: 'none' }}>
                <CTAStart>View room</CTAStart>
              </Link>
            </div>
          </div>
        </CardPhoto>
      )}

      <div style={{ display: 'grid', gap: 14 }}>
        {visible.slice(tab === 'upcoming' ? 1 : 0).map(res => {
          const r = restaurants[res.restaurantId];
          if (!r) return null;
          if (res.status === 'past') {
            return (
              <CardDark key={res.id} padding={18}>
                <Row r={r} res={res} dark/>
              </CardDark>
            );
          }
          return (
            <CardLight key={res.id} padding={18}>
              <Row r={r} res={res}/>
            </CardLight>
          );
        })}
      </div>
    </section>
  );
}

function Row({ r, res, dark = false }) {
  return (
    <div style={{ display: 'flex', alignItems: 'center', gap: 16 }}>
      <Avatar src={r.photo} size={48} ring={!dark}/>
      <div style={{ flex: 1, minWidth: 0 }}>
        <div style={{ fontSize: 16, fontWeight: 700, letterSpacing: -0.2, color: dark ? '#fff' : 'var(--text)' }}>
          {r.name}
        </div>
        <div style={{ fontSize: 13, color: dark ? 'rgba(255,255,255,0.62)' : 'var(--text-mute-l)' }}>
          {formatDate(res.dateISO)} · {timeOf(res.dateISO)} · {res.guestCount} guests
        </div>
      </div>
      <StatusBadge tone={dark ? 'dark' : 'gold'}>
        {res.status === 'past' ? 'View' : 'Confirmed'}
      </StatusBadge>
    </div>
  );
}

function timeOf(iso) {
  return new Date(iso).toLocaleTimeString('en-GB', { hour: '2-digit', minute: '2-digit', hour12: false });
}
