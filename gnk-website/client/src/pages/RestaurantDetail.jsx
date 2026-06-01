import React, { useEffect, useState } from 'react';
import { useNavigate, useParams, Link } from 'react-router-dom';
import { api } from '../lib/api.js';
import { useBooking } from '../lib/booking.jsx';
import { Hero } from '../components/photo.jsx';
import { CardDark, CardLight } from '../components/cards.jsx';
import { CTAGold, RoundBtn, StatusBadge } from '../components/ui.jsx';

export default function RestaurantDetail() {
  const { id } = useParams();
  const navigate = useNavigate();
  const booking = useBooking();
  const [r, setR] = useState(null);
  useEffect(() => { api.restaurant(id).then(setR).catch(() => setR(undefined)); }, [id]);

  if (r === undefined) return <NotFound/>;
  if (!r) return null;

  const onReserve = () => {
    booking.start(r.id);
    booking.patch({ guestCount: 2 });
    navigate('/book/date');
  };

  return (
    <>
      <Hero photo={r.photo} height="72vh">
        <div style={{ maxWidth: 760 }}>
          <div className="lbl-eyebrow" style={{ color: 'rgba(255,255,255,0.8)' }}>
            {r.tag}
          </div>
          <h1 className="h1" style={{ color: '#fff', marginTop: 8 }}>{r.name}.</h1>
          <div style={{ display: 'flex', gap: 14, marginTop: 22, flexWrap: 'wrap' }}>
            <StatusBadge tone="cream">★ {r.rating}</StatusBadge>
            <StatusBadge tone="cream">{r.hours}</StatusBadge>
            <StatusBadge tone="cream">{r.location}</StatusBadge>
          </div>
        </div>
      </Hero>

      <section className="container split-2">
        {/* Main column */}
        <div>
          <div className="lbl-eyebrow">The room</div>
          <h2 className="h2" style={{ marginTop: 8 }}>{r.blurb}</h2>
          <p style={{ marginTop: 22, color: 'var(--text-mute-l)', fontSize: 16, lineHeight: 1.75 }}>
            {r.history}
          </p>

          <div className="grid-features" style={{ marginTop: 36 }}>
            <DetailStat label="Tonight" value={`${r.capacityTonight} tables`}/>
            <DetailStat label="Hours" value={r.hours}/>
            <DetailStat label="Neighbourhood" value={r.location}/>
            <DetailStat label="Deposit" value={`EGP ${r.deposit} / guest`}/>
          </div>

          <div style={{ marginTop: 44 }}>
            <Link to="/restaurants" style={{ color: 'var(--gold-deep)', fontWeight: 600, fontSize: 14 }}>
              ← All restaurants
            </Link>
          </div>
        </div>

        {/* Reserve sidebar */}
        <aside>
          <CardLight padding={28}>
            <div className="lbl-eyebrow">Reserve</div>
            <h3 className="h3" style={{ marginTop: 10 }}>Open tonight.</h3>
            <p style={{ color: 'var(--text-mute-l)', marginTop: 6, fontSize: 13 }}>
              Refundable deposit returned at the table.
            </p>

            <ul style={{
              listStyle: 'none', padding: 0, margin: '22px 0',
              display: 'grid', gap: 12,
            }}>
              <SidebarRow icon="🗓️" label="Today · 8:30 PM"/>
              <SidebarRow icon="👥" label="2 guests"/>
              <SidebarRow icon="🪑" label={`${r.capacityTonight} tables open`}/>
            </ul>

            <CTAGold onClick={onReserve} style={{ width: '100%' }}>
              Reserve a table
            </CTAGold>
          </CardLight>

          <CardDark padding={22} style={{ marginTop: 16 }}>
            <div className="lbl-eyebrow" style={{ color: 'rgba(255,255,255,0.55)' }}>Concierge</div>
            <p style={{ color: 'rgba(255,255,255,0.85)', marginTop: 8, fontSize: 13, lineHeight: 1.55 }}>
              Anniversary? Birthday? Quiet table by the window? Tell us at the
              occasion step — the host has it before you arrive.
            </p>
          </CardDark>
        </aside>
      </section>
    </>
  );
}

function DetailStat({ label, value }) {
  return (
    <div style={{
      padding: '14px 16px',
      borderRadius: 16,
      background: 'var(--bg-cream)',
      border: '1px solid var(--div-l)',
    }}>
      <div className="lbl-eyebrow">{label}</div>
      <div style={{ fontSize: 15, fontWeight: 600, marginTop: 4 }}>{value}</div>
    </div>
  );
}

function SidebarRow({ icon, label }) {
  return (
    <li style={{ display: 'flex', alignItems: 'center', gap: 10, fontSize: 14 }}>
      <span style={{ fontSize: 18 }}>{icon}</span> {label}
    </li>
  );
}

function NotFound() {
  return (
    <section className="container" style={{ padding: '120px 0', textAlign: 'center' }}>
      <h1 className="h2">Room not found.</h1>
      <p style={{ marginTop: 16, color: 'var(--text-mute-l)' }}>
        That restaurant isn't on the menu. <Link to="/restaurants" style={{ color: 'var(--gold-deep)', fontWeight: 600 }}>See all six</Link>.
      </p>
    </section>
  );
}
