// Mid-density restaurant card — used in the home + restaurants grid.
import React from 'react';
import { Link } from 'react-router-dom';
import { MonoPhoto } from './photo.jsx';

export function RestaurantCard({ r }) {
  return (
    <Link
      to={`/restaurants/${r.id}`}
      style={{
        display: 'block',
        background: 'var(--bg-cream)',
        borderRadius: 24,
        overflow: 'hidden',
        boxShadow: '0 14px 32px rgba(0,0,0,0.08), inset 0 1px 0 rgba(255,255,255,0.6)',
        color: 'inherit',
        transition: 'transform .25s ease, box-shadow .25s ease',
      }}
      onMouseEnter={(e) => {
        e.currentTarget.style.transform = 'translateY(-4px)';
        e.currentTarget.style.boxShadow = '0 22px 40px rgba(0,0,0,0.14), inset 0 1px 0 rgba(255,255,255,0.6)';
      }}
      onMouseLeave={(e) => {
        e.currentTarget.style.transform = 'translateY(0)';
        e.currentTarget.style.boxShadow = '0 14px 32px rgba(0,0,0,0.08), inset 0 1px 0 rgba(255,255,255,0.6)';
      }}
    >
      <div style={{ width: '100%', aspectRatio: '4 / 5', position: 'relative' }}>
        <MonoPhoto src={r.photo} alt={r.name}/>
        <div style={{
          position: 'absolute', inset: 0,
          background: 'linear-gradient(180deg, transparent 50%, rgba(0,0,0,0.55) 100%)',
        }}/>
        <div style={{
          position: 'absolute', left: 20, right: 20, bottom: 18,
          color: '#fff',
        }}>
          <div style={{ fontSize: 11, letterSpacing: 1.2, fontWeight: 700, textTransform: 'uppercase', opacity: 0.85 }}>
            {r.tag}
          </div>
          <div style={{ fontSize: 28, fontWeight: 600, letterSpacing: -0.7, marginTop: 4 }}>
            {r.name}
          </div>
        </div>
      </div>
      <div style={{
        padding: '18px 22px 22px',
        display: 'flex', justifyContent: 'space-between', alignItems: 'center', gap: 12,
      }}>
        <div>
          <div className="lbl-eyebrow">From</div>
          <div style={{ fontSize: 20, fontWeight: 700, letterSpacing: -0.4, color: 'var(--gold-deep)', marginTop: 2 }}>
            EGP {r.deposit}
          </div>
        </div>
        <div style={{
          width: 44, height: 44, borderRadius: '50%',
          background: 'var(--true-black)', color: '#fff',
          display: 'inline-flex', alignItems: 'center', justifyContent: 'center',
          fontSize: 14, letterSpacing: 2,
        }}>›</div>
      </div>
    </Link>
  );
}
