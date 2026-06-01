import React from 'react';
import { Link } from 'react-router-dom';

export default function NotFound() {
  return (
    <section className="container" style={{ padding: '120px 0', textAlign: 'center' }}>
      <h1 className="h1">404</h1>
      <p style={{ marginTop: 16, color: 'var(--text-mute-l)', fontSize: 16 }}>
        That page is not on the menu.
      </p>
      <p style={{ marginTop: 24 }}>
        <Link to="/" style={{ color: 'var(--gold-deep)', fontWeight: 600 }}>
          ← Back to G'nK
        </Link>
      </p>
    </section>
  );
}
