// Shared wrapper for the 4 booking steps — title, stepper, content slot.
import React from 'react';
import { Link } from 'react-router-dom';
import { Stepper } from '../../components/ui.jsx';

export function BookingShell({ step, total = 4, eyebrow, title, children }) {
  return (
    <section className="container" style={{
      paddingTop: 56, paddingBottom: 96, maxWidth: 880,
    }}>
      <Stepper current={step} total={total}/>
      <header style={{ marginTop: 16, marginBottom: 36 }}>
        {eyebrow && <div className="lbl-eyebrow" style={{ marginBottom: 8 }}>{eyebrow}</div>}
        <h1 className="h2">{title}</h1>
      </header>
      {children}
      <div style={{ marginTop: 48, display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
        <Link to="/restaurants" style={{ color: 'var(--text-mute-l)', fontSize: 13, fontWeight: 500 }}>
          ← Cancel
        </Link>
        {/* `Continue` CTA is provided per-step via children */}
      </div>
    </section>
  );
}
