import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { CardDark, CardLight } from '../../components/cards.jsx';
import { CTAGold } from '../../components/ui.jsx';
import { useBooking } from '../../lib/booking.jsx';
import { api } from '../../lib/api.js';

export default function AddCard() {
  const navigate = useNavigate();
  const b = useBooking();
  const [number, setNumber] = useState('');
  const [exp, setExp] = useState('');
  const [cvv, setCvv] = useState('');
  const [name, setName] = useState('');
  const [busy, setBusy] = useState(false);

  const lastFour = (number.replace(/\D/g, '').slice(-4) || '••••').padStart(4, '•');

  const save = async () => {
    setBusy(true);
    try {
      const res = await api.createReservation({
        restaurantId: b.state.restaurantId || 'stanley',
        dateISO: `${b.state.date || '2025-11-14'}T${b.state.time || '20:30'}:00`,
        guestCount: b.state.guestCount || 2,
        occasion: b.state.occasion,
        dietary: b.state.dietary,
        note: b.state.note,
      });
      sessionStorage.setItem('gnk:lastReservation', JSON.stringify(res));
      b.reset();
      navigate('/confirmation');
    } catch (e) {
      alert(`Couldn't save: ${e.message}`);
      setBusy(false);
    }
  };

  return (
    <section className="container" style={{
      paddingTop: 56, paddingBottom: 96, maxWidth: 720,
    }}>
      <div className="lbl-eyebrow">Add a card</div>
      <h1 className="h2" style={{ marginTop: 8 }}>New card.</h1>

      {/* Card preview */}
      <CardDark padding={26} style={{ marginTop: 28, position: 'relative', overflow: 'hidden' }}>
        <div style={{
          position: 'absolute', top: -60, right: -60, width: 200, height: 200,
          background: 'radial-gradient(circle, var(--gold) 0%, transparent 60%)',
          opacity: 0.45, pointerEvents: 'none',
        }}/>
        <div style={{ position: 'relative' }}>
          <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
            <div style={{ display: 'flex', alignItems: 'center', gap: 10 }}>
              <span style={{ width: 10, height: 10, borderRadius: '50%', background: 'var(--gold)', display: 'inline-block' }}/>
              <span style={{ fontWeight: 700, color: '#fff', fontSize: 16 }}>G'NK</span>
            </div>
            <div className="lbl-eyebrow" style={{ color: 'rgba(255,255,255,0.55)' }}>DEBIT</div>
          </div>
          <div style={{
            marginTop: 36, fontFamily: 'ui-monospace, monospace',
            fontSize: 22, color: '#fff', letterSpacing: 3,
          }}>
            {(number || '4242 1234 5678').padEnd(16, '•').replace(/(.{4})/g, '$1 ').trim().slice(0, 19)}
          </div>
          <div style={{ marginTop: 20, display: 'flex', justifyContent: 'space-between' }}>
            <div>
              <div className="lbl-eyebrow" style={{ color: 'rgba(255,255,255,0.55)' }}>NAME</div>
              <div style={{ color: '#fff', fontWeight: 600, marginTop: 4, fontSize: 14 }}>
                {(name || 'Your Name').toUpperCase()}
              </div>
            </div>
            <div>
              <div className="lbl-eyebrow" style={{ color: 'rgba(255,255,255,0.55)' }}>EXPIRES</div>
              <div style={{ color: '#fff', fontWeight: 600, marginTop: 4, fontSize: 14 }}>
                {exp || 'MM / YY'}
              </div>
            </div>
          </div>
        </div>
      </CardDark>

      {/* Form */}
      <CardLight padding={0} style={{ marginTop: 16 }}>
        <Field label="Card number" value={number} onChange={(v) => setNumber(formatCardNumber(v))} placeholder="4242 1234 5678 9010" inputMode="numeric"/>
        <Hairline/>
        <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr' }}>
          <div style={{ borderRight: '1px solid var(--div-l)' }}>
            <Field label="Expires" value={exp} onChange={(v) => setExp(formatExp(v))} placeholder="MM / YY" inputMode="numeric"/>
          </div>
          <Field label="CVV" value={cvv} onChange={setCvv} placeholder="•••" inputMode="numeric" maxLength={4}/>
        </div>
        <Hairline/>
        <Field label="Name on card" value={name} onChange={setName} placeholder="Ahmed Saleh"/>
      </CardLight>

      <div style={{ display: 'flex', justifyContent: 'flex-end', marginTop: 36 }}>
        <CTAGold onClick={save} disabled={busy}>{busy ? 'Saving…' : 'Save · Pay EGP 1,000'}</CTAGold>
      </div>
    </section>
  );
}

function Field({ label, value, onChange, placeholder, inputMode, maxLength }) {
  return (
    <div style={{ padding: '14px 22px' }}>
      <label className="lbl-eyebrow">{label}</label>
      <input
        value={value}
        onChange={(e) => onChange(e.target.value)}
        placeholder={placeholder}
        inputMode={inputMode}
        maxLength={maxLength}
        style={{
          display: 'block', marginTop: 6,
          width: '100%',
          border: 0, outline: 'none',
          background: 'transparent',
          font: 'inherit',
          fontSize: 16,
          fontWeight: 600,
          letterSpacing: 0.3,
          color: 'var(--text)',
        }}
      />
    </div>
  );
}

function Hairline() {
  return <div style={{ height: 1, background: 'var(--div-l)' }}/>;
}

function formatCardNumber(v) {
  const digits = v.replace(/\D/g, '').slice(0, 16);
  return digits.replace(/(.{4})/g, '$1 ').trim();
}

function formatExp(v) {
  const digits = v.replace(/\D/g, '').slice(0, 4);
  if (digits.length < 3) return digits;
  return `${digits.slice(0, 2)} / ${digits.slice(2)}`;
}
