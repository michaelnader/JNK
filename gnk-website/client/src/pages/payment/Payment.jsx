import React, { useState } from 'react';
import { useNavigate, Link } from 'react-router-dom';
import { CardLight } from '../../components/cards.jsx';
import { CTAGold } from '../../components/ui.jsx';
import { useBooking } from '../../lib/booking.jsx';
import { api } from '../../lib/api.js';

export default function Payment() {
  const navigate = useNavigate();
  const b = useBooking();
  const [picked, setPicked] = useState('visa');
  const [busy, setBusy] = useState(false);

  const confirm = async () => {
    if (busy) return;
    setBusy(true);
    try {
      const res = await api.createReservation({
        restaurantId: b.state.restaurantId,
        dateISO: `${b.state.date}T${b.state.time}:00`,
        guestCount: b.state.guestCount,
        occasion: b.state.occasion,
        dietary: b.state.dietary,
        note: b.state.note,
      });
      sessionStorage.setItem('gnk:lastReservation', JSON.stringify(res));
      b.reset();
      navigate('/confirmation');
    } catch (e) {
      alert(`Couldn't confirm: ${e.message}`);
      setBusy(false);
    }
  };

  return (
    <section className="container" style={{
      paddingTop: 56, paddingBottom: 96, maxWidth: 720,
    }}>
      <div className="lbl-eyebrow">Payment</div>
      <h1 className="h2" style={{ marginTop: 8 }}>How will you pay?</h1>
      <p style={{ color: 'var(--text-mute-l)', marginTop: 8 }}>
        EGP 1,000 · refundable deposit, returned at the table.
      </p>

      {/* Apple Pay */}
      <button onClick={confirm} disabled={busy} style={{
        marginTop: 32,
        width: '100%',
        height: 64,
        borderRadius: 20,
        background: 'var(--true-black)',
        color: '#fff',
        display: 'flex', alignItems: 'center', justifyContent: 'center',
        gap: 8,
        fontSize: 18, fontWeight: 500, letterSpacing: -0.2,
        cursor: busy ? 'wait' : 'pointer',
      }}>
        <svg width="20" height="24" viewBox="0 0 22 26" fill="#fff" aria-hidden>
          <path d="M17.5 13.5c0-3.4 2.8-5 2.9-5.1-1.6-2.3-4-2.6-4.9-2.7-2.1-.2-4 1.2-5 1.2-1.1 0-2.6-1.2-4.3-1.2-2.2 0-4.3 1.3-5.4 3.3-2.3 4-.6 9.9 1.6 13.1 1.1 1.6 2.4 3.3 4.1 3.3 1.6-.1 2.3-1.1 4.3-1.1s2.5 1.1 4.3 1c1.8 0 2.9-1.6 4-3.2 1.3-1.8 1.8-3.6 1.8-3.7-.1 0-3.4-1.3-3.4-5.1zM14.3 4.1C15.2 3 15.8 1.5 15.7 0c-1.3.1-2.8.9-3.7 2-.8.9-1.5 2.4-1.3 3.9 1.4.1 2.8-.7 3.6-1.8z"/>
        </svg>
        <span>Pay</span>
      </button>

      <Divider label="OR USE A CARD"/>

      <CardLight padding={0}>
        <PayRow brand="VISA" name="Personal" last="4421" selected={picked === 'visa'} onClick={() => setPicked('visa')}/>
        <Hairline/>
        <PayRow brand="MC" name="Business" last="0392" selected={picked === 'mc'} onClick={() => setPicked('mc')}/>
        <Hairline/>
        <Link to="/payment/add" style={{
          display: 'flex', alignItems: 'center', gap: 14,
          padding: '16px 22px', color: 'inherit',
        }}>
          <div style={{
            width: 36, height: 36, borderRadius: '50%',
            background: 'var(--gold)', color: 'var(--text)',
            display: 'inline-flex', alignItems: 'center', justifyContent: 'center',
            fontSize: 18, fontWeight: 600,
          }}>+</div>
          <span style={{ fontSize: 14, fontWeight: 600 }}>Add a new card</span>
        </Link>
      </CardLight>

      <div style={{ display: 'flex', justifyContent: 'flex-end', marginTop: 36 }}>
        <CTAGold onClick={confirm} disabled={busy}>{busy ? 'Confirming…' : 'Pay EGP 1,000'}</CTAGold>
      </div>
    </section>
  );
}

function PayRow({ brand, name, last, selected, onClick }) {
  return (
    <button onClick={onClick} style={{
      display: 'flex', alignItems: 'center', gap: 16,
      width: '100%',
      padding: '16px 22px',
      background: 'transparent', textAlign: 'left',
      cursor: 'pointer',
      color: 'inherit',
    }}>
      <div style={{
        width: 44, height: 30, borderRadius: 6,
        background: brand === 'VISA'
          ? 'linear-gradient(135deg,#1a1f71,#2a3f9d)'
          : 'linear-gradient(135deg,#232323,#454545)',
        color: '#fff',
        display: 'inline-flex', alignItems: 'center', justifyContent: 'center',
        fontSize: 10, fontWeight: 700, letterSpacing: 0.3,
      }}>{brand}</div>
      <div style={{ flex: 1 }}>
        <div style={{ fontSize: 14, fontWeight: 600 }}>{name}</div>
        <div style={{ fontSize: 13, color: 'var(--text-mute-l)' }}>•••• {last}</div>
      </div>
      <div style={{
        width: 24, height: 24, borderRadius: '50%',
        border: `2px solid ${selected ? 'var(--gold)' : 'rgba(14,14,14,0.18)'}`,
        background: selected ? 'var(--gold)' : 'transparent',
        display: 'inline-flex', alignItems: 'center', justifyContent: 'center',
      }}>
        {selected && <div style={{ width: 10, height: 10, borderRadius: '50%', background: 'var(--text)' }}/>}
      </div>
    </button>
  );
}

function Hairline() {
  return <div style={{ height: 1, background: 'var(--div-l)', margin: '0 22px' }}/>;
}

function Divider({ label }) {
  return (
    <div style={{ display: 'flex', alignItems: 'center', gap: 12, margin: '28px 0' }}>
      <div style={{ flex: 1, height: 1, background: 'rgba(14,14,14,0.12)' }}/>
      <span className="lbl-eyebrow">{label}</span>
      <div style={{ flex: 1, height: 1, background: 'rgba(14,14,14,0.12)' }}/>
    </div>
  );
}
