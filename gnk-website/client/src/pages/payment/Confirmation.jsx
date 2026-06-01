import React, { useEffect, useState } from 'react';
import { Link } from 'react-router-dom';
import { api } from '../../lib/api.js';
import { CardLight, CardPhoto } from '../../components/cards.jsx';
import { Avatar } from '../../components/photo.jsx';
import { CTAStart, StatusBadge } from '../../components/ui.jsx';
import { formatDate } from '../../lib/format.js';

export default function Confirmation() {
  const [last, setLast] = useState(null);
  const [restaurant, setRestaurant] = useState(null);

  useEffect(() => {
    const raw = sessionStorage.getItem('gnk:lastReservation');
    if (raw) {
      const parsed = JSON.parse(raw);
      setLast(parsed);
      api.restaurant(parsed.restaurantId).then(setRestaurant).catch(() => {});
    }
  }, []);

  if (!last || !restaurant) {
    return (
      <section className="container" style={{ paddingTop: 96, paddingBottom: 96, textAlign: 'center' }}>
        <h1 className="h2">No recent booking.</h1>
        <p style={{ marginTop: 14, color: 'var(--text-mute-l)' }}>
          <Link to="/restaurants" style={{ color: 'var(--gold-deep)', fontWeight: 600 }}>Browse restaurants →</Link>
        </p>
      </section>
    );
  }

  const date = new Date(last.dateISO);

  return (
    <>
      <CardPhoto photo={restaurant.photo} padding={0} style={{
        height: '52vh', minHeight: 420,
        borderRadius: 0,
      }}>
        <div style={{ height: '100%', position: 'relative' }}>
          <div className="container" style={{
            position: 'absolute', inset: 0,
            display: 'flex', flexDirection: 'column',
            alignItems: 'center', justifyContent: 'center',
            textAlign: 'center', gap: 24,
          }}>
            <div style={{
              width: 80, height: 80, borderRadius: '50%',
              background: 'var(--gold)',
              display: 'inline-flex', alignItems: 'center', justifyContent: 'center',
              boxShadow: '0 14px 30px rgba(47,62,74,0.40), inset 0 1px 0 rgba(255,255,255,0.30)',
            }}>
              <svg width="36" height="36" viewBox="0 0 28 28" fill="none">
                <path d="M8 14.5L12.5 19.5L21 10.5" stroke="var(--text)" strokeWidth="2.6" strokeLinecap="round" strokeLinejoin="round"/>
              </svg>
            </div>
            <div className="lbl-eyebrow" style={{ color: 'rgba(255,255,255,0.85)' }}>
              Confirmation sent to ahmed@email.com
            </div>
            <h1 className="h1" style={{ color: '#fff' }}>You're in.</h1>
          </div>
        </div>
      </CardPhoto>

      <section className="container" style={{
        paddingTop: 56, paddingBottom: 96, maxWidth: 720,
        marginTop: 'clamp(-120px, -10vw, -60px)', position: 'relative', zIndex: 1,
      }}>
        <CardLight padding={28}>
          <div style={{ display: 'flex', alignItems: 'center', gap: 16 }}>
            <Avatar src={restaurant.photo} size={56} ring/>
            <div style={{ flex: 1 }}>
              <div style={{ fontSize: 20, fontWeight: 700, letterSpacing: -0.3 }}>
                {restaurant.name}
              </div>
              <div style={{ color: 'var(--text-mute-l)', fontSize: 13 }}>
                {restaurant.tag}
              </div>
            </div>
            <StatusBadge tone="dark">{last.code}</StatusBadge>
          </div>

          <div className="stat-row-3" style={{
            marginTop: 24, paddingTop: 22, borderTop: '1px solid var(--div-l)',
          }}>
            <Stat label="Date" value={formatDate(date)}/>
            <Stat label="Time" value={date.toLocaleTimeString('en-GB', { hour: '2-digit', minute: '2-digit', hour12: false })}/>
            <Stat label="Guests" value={String(last.guestCount).padStart(2, '0')}/>
          </div>

          <div style={{
            marginTop: 24, display: 'flex', alignItems: 'center', gap: 16, flexWrap: 'wrap',
          }}>
            <Qr/>
            <div style={{ flex: 1, minWidth: 160 }}>
              <div style={{ fontWeight: 700, fontSize: 14 }}>Show on arrival</div>
              <div style={{ color: 'var(--text-mute-l)', fontSize: 13, marginTop: 4 }}>
                Or just give your name — we'll have it.
              </div>
            </div>
            <Link to="/reservations" style={{ textDecoration: 'none' }}>
              <CTAStart dark>All bookings</CTAStart>
            </Link>
          </div>
        </CardLight>
      </section>
    </>
  );
}

function Stat({ label, value }) {
  return (
    <div>
      <div className="lbl-eyebrow">{label}</div>
      <div style={{ fontSize: 18, fontWeight: 700, marginTop: 4, letterSpacing: -0.2 }}>{value}</div>
    </div>
  );
}

function Qr() {
  // 7×7 stylised QR — same generator as the prototype.
  const cells = Array.from({ length: 49 }, (_, i) => {
    const x = i % 7, y = Math.floor(i / 7);
    const inCorner = (x < 2 && y < 2) || (x > 4 && y < 2) || (x < 2 && y > 4);
    return inCorner || (x * 31 + y * 17 + 5) % 7 < 3;
  });
  return (
    <div style={{
      width: 72, height: 72, padding: 4, borderRadius: 12,
      background: 'var(--true-black)',
      display: 'grid', gridTemplateColumns: 'repeat(7,1fr)', gap: 1,
    }}>
      {cells.map((on, i) => (
        <div key={i} style={{ background: on ? 'var(--gold)' : 'var(--true-black)' }}/>
      ))}
    </div>
  );
}
