import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { BookingShell } from './BookingShell.jsx';
import { CardDark, CardLight } from '../../components/cards.jsx';
import { CTAGold } from '../../components/ui.jsx';
import { useBooking } from '../../lib/booking.jsx';
import { formatDate } from '../../lib/format.js';

const SLOTS = [
  ['18:00', '18:30', '19:00'],
  ['19:30', '20:00', '20:30'],
  ['21:00', '21:30', '22:00'],
  ['22:30', '23:00', '23:30'],
];

export default function BookingTime() {
  const navigate = useNavigate();
  const b = useBooking();
  const [picked, setPicked] = useState(b.state.time ?? '20:30');

  return (
    <BookingShell
      step={2}
      eyebrow={`${formatDate(b.state.date)} · ${b.state.guestCount} guests`}
      title="Pick a time."
    >
      <CardLight padding={22}>
        <div className="lbl-eyebrow" style={{ marginBottom: 14 }}>Available tonight</div>
        <div style={{ display: 'grid', gap: 10 }}>
          {SLOTS.map((row, r) => (
            <div key={r} style={{ display: 'grid', gridTemplateColumns: 'repeat(3, 1fr)', gap: 10 }}>
              {row.map(t => {
                const sel = t === picked;
                return (
                  <button key={t} onClick={() => setPicked(t)} style={{
                    height: 56,
                    borderRadius: 14,
                    background: sel ? 'var(--gold)' : 'var(--bg-sand)',
                    color: 'var(--text)',
                    fontSize: 16,
                    fontWeight: sel ? 700 : 500,
                    letterSpacing: -0.2,
                    boxShadow: 'inset 0 1px 0 rgba(255,255,255,0.4)',
                    cursor: 'pointer',
                  }}>{t}</button>
                );
              })}
            </div>
          ))}
        </div>
      </CardLight>

      <CardDark padding={18} style={{ marginTop: 16 }}>
        <p style={{ color: 'rgba(255,255,255,0.62)', fontSize: 13, margin: 0 }}>
          Tables are held <strong style={{ color: 'var(--gold)' }}>15 minutes</strong> past your booking time.
        </p>
      </CardDark>

      <div style={{ display: 'flex', justifyContent: 'flex-end', marginTop: 28 }}>
        <CTAGold onClick={() => { b.patch({ time: picked }); navigate('/book/occasion'); }}>
          Continue · {picked}
        </CTAGold>
      </div>
    </BookingShell>
  );
}
