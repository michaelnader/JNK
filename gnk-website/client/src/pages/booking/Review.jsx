import React, { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { BookingShell } from './BookingShell.jsx';
import { CardGold, CardLight, CardPhoto } from '../../components/cards.jsx';
import { CTAGold, StatusBadge } from '../../components/ui.jsx';
import { useBooking } from '../../lib/booking.jsx';
import { api } from '../../lib/api.js';
import { formatDate } from '../../lib/format.js';

export default function BookingReview() {
  const navigate = useNavigate();
  const b = useBooking();
  const [r, setR] = useState(null);
  useEffect(() => {
    if (b.state.restaurantId) api.restaurant(b.state.restaurantId).then(setR);
  }, [b.state.restaurantId]);

  if (!r) return <BookingShell step={4} title="Your booking."/>;

  const totalDeposit = r.deposit * (b.state.guestCount || 1);

  return (
    <BookingShell step={4} title="Your booking.">
      <CardPhoto photo={r.photo} padding={28} style={{ height: 200 }}>
        <div style={{
          display: 'flex', flexDirection: 'column', justifyContent: 'space-between',
          height: '100%',
        }}>
          <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', gap: 14 }}>
            <div>
              <div className="lbl-eyebrow" style={{ color: 'rgba(255,255,255,0.8)' }}>Restaurant</div>
              <div style={{ fontSize: 32, fontWeight: 600, letterSpacing: -0.7, marginTop: 4 }}>
                {r.name}
              </div>
            </div>
            <StatusBadge>Confirmed</StatusBadge>
          </div>
          <div className="lbl-eyebrow" style={{ color: 'rgba(255,255,255,0.85)' }}>
            {formatDate(b.state.date)} · {b.state.time} · {b.state.guestCount} guests
          </div>
        </div>
      </CardPhoto>

      <CardLight padding={0} style={{ marginTop: 16 }}>
        <Row label="Occasion" value={`${b.state.occasion ?? '—'}${b.state.dietary?.length ? ' · ' + b.state.dietary.join(', ') : ''}`}/>
        <Divider/>
        <Row label="Note" value={b.state.note || '—'}/>
        <Divider/>
        <Row label="Cancellation" value="Free until 24h before"/>
      </CardLight>

      <CardGold padding={22} style={{ marginTop: 16 }}>
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', gap: 16 }}>
          <div>
            <div className="lbl-eyebrow" style={{ color: 'rgba(14,14,14,0.65)' }}>Refundable deposit</div>
            <div style={{ fontSize: 28, fontWeight: 700, letterSpacing: -0.5, marginTop: 4 }}>
              EGP {totalDeposit.toLocaleString()}
            </div>
            <div style={{ fontSize: 12, color: 'rgba(14,14,14,0.55)', marginTop: 4 }}>
              EGP {r.deposit} × {b.state.guestCount} guests
            </div>
          </div>
        </div>
      </CardGold>

      <div style={{ display: 'flex', justifyContent: 'flex-end', marginTop: 28 }}>
        <CTAGold onClick={() => navigate('/payment')}>Continue to payment</CTAGold>
      </div>
    </BookingShell>
  );
}

function Row({ label, value }) {
  return (
    <div style={{
      padding: '18px 22px',
      display: 'flex', justifyContent: 'space-between', gap: 18,
    }}>
      <span className="lbl-eyebrow">{label}</span>
      <span style={{ textAlign: 'right', fontWeight: 600, fontSize: 14, letterSpacing: -0.1 }}>
        {value}
      </span>
    </div>
  );
}

function Divider() {
  return <div style={{ height: 1, background: 'var(--div-l)', margin: '0 22px' }}/>;
}
