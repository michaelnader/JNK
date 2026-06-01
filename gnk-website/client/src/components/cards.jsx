// Off Duty card surfaces — dark / light / denim-gradient / monochrome photo.
// These are the building blocks every page composes from.
import React from 'react';
import { MonoPhoto } from './photo.jsx';

const baseRadius = 28;

export function CardDark({ children, padding = 24, radius = baseRadius, style }) {
  return (
    <div style={{
      background: 'var(--true-black)',
      color: '#fff',
      borderRadius: radius,
      padding,
      position: 'relative',
      overflow: 'hidden',
      boxShadow: '0 10px 30px rgba(0,0,0,0.18), inset 0 1px 0 rgba(255,255,255,0.06)',
      ...style,
    }}>{children}</div>
  );
}

export function CardLight({ children, padding = 24, radius = baseRadius, style }) {
  return (
    <div style={{
      background: 'var(--bg-cream)',
      color: 'var(--text)',
      borderRadius: radius,
      padding,
      position: 'relative',
      overflow: 'hidden',
      boxShadow:
        '0 10px 30px rgba(0,0,0,0.08),' +
        ' inset 0 1px 0 rgba(255,255,255,0.6),' +
        ' inset 0 -1px 0 rgba(0,0,0,0.05)',
      ...style,
    }}>
      <div style={{
        position: 'absolute', top: 0, left: 0, right: 0, height: '40%',
        background: 'linear-gradient(180deg, rgba(255,255,255,0.35), transparent)',
        pointerEvents: 'none',
      }}/>
      <div style={{ position: 'relative' }}>{children}</div>
    </div>
  );
}

export function CardGold({ children, padding = 24, radius = baseRadius, style }) {
  return (
    <div style={{
      background: 'linear-gradient(160deg, var(--gold-light), var(--gold) 60%, var(--gold-deep))',
      color: 'var(--text)',
      borderRadius: radius,
      padding,
      position: 'relative',
      overflow: 'hidden',
      boxShadow:
        '0 10px 30px rgba(47,62,74,0.30),' +
        ' inset 0 1px 0 rgba(255,255,255,0.30),' +
        ' inset 0 -1px 0 rgba(0,0,0,0.10)',
      ...style,
    }}>{children}</div>
  );
}

export function CardPhoto({ photo, padding = 24, radius = baseRadius, style, children }) {
  return (
    <div style={{
      position: 'relative',
      overflow: 'hidden',
      borderRadius: radius,
      color: '#fff',
      boxShadow: '0 14px 32px rgba(0,0,0,0.28), inset 0 1px 0 rgba(255,255,255,0.10)',
      ...style,
    }}>
      <div style={{ position: 'absolute', inset: 0 }}>
        <MonoPhoto src={photo}/>
      </div>
      <div style={{
        position: 'absolute', inset: 0,
        background: 'linear-gradient(180deg, rgba(0,0,0,0.10) 0%, rgba(0,0,0,0.55) 100%)',
        pointerEvents: 'none',
      }}/>
      <div style={{ position: 'relative', padding, zIndex: 1 }}>{children}</div>
    </div>
  );
}
