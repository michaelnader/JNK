// Buttons, chips, steppers, badges — the small Off Duty primitives that don't
// belong in cards.jsx.
import React from 'react';

// ─── "Start ›››" pill button. Two variants: dark / light. ────────────────
export function CTAStart({ children, dark = false, type = 'button', onClick, style }) {
  const bg       = dark ? 'var(--true-black)' : 'var(--bg-cream)';
  const fg       = dark ? '#fff' : 'var(--text)';
  const innerBg  = dark ? 'var(--bg-cream)' : 'var(--true-black)';
  const innerFg  = dark ? 'var(--text)' : '#fff';
  return (
    <button type={type} onClick={onClick} style={{
      display: 'inline-flex', alignItems: 'center', gap: 16,
      height: 56, padding: '4px 4px 4px 24px',
      borderRadius: 9999,
      background: bg, color: fg,
      fontSize: 15, fontWeight: 600, letterSpacing: -0.2,
      maxWidth: '100%',
      boxShadow: dark
        ? '0 8px 22px rgba(0,0,0,0.20), inset 0 1px 0 rgba(255,255,255,0.08)'
        : '0 8px 22px rgba(0,0,0,0.12), inset 0 1px 0 rgba(255,255,255,0.6)',
      cursor: 'pointer',
      ...style,
    }}>
      <span>{children}</span>
      <ArrowDisc bg={innerBg} fg={innerFg}/>
    </button>
  );
}

// ─── Denim-gradient CTA — primary forward action. ────────────────────────
export function CTAGold({ children, type = 'button', onClick, disabled = false, style }) {
  return (
    <button type={type} onClick={onClick} disabled={disabled} style={{
      display: 'inline-flex', alignItems: 'center', gap: 16,
      height: 56, padding: '4px 4px 4px 24px',
      borderRadius: 9999,
      background: disabled
        ? 'var(--chrome)'
        : 'linear-gradient(160deg, var(--gold-light), var(--gold))',
      color: 'var(--text)',
      fontSize: 15, fontWeight: 600, letterSpacing: -0.2,
      maxWidth: '100%',
      boxShadow: disabled
        ? 'none'
        : '0 8px 22px rgba(47,62,74,0.30), inset 0 1px 0 rgba(255,255,255,0.32)',
      cursor: disabled ? 'not-allowed' : 'pointer',
      opacity: disabled ? 0.7 : 1,
      ...style,
    }}>
      <span>{children}</span>
      <ArrowDisc bg="var(--true-black)" fg="#fff"/>
    </button>
  );
}

function ArrowDisc({ bg, fg }) {
  return (
    <span style={{
      width: 48, height: 48,
      borderRadius: '50%',
      background: bg, color: fg,
      display: 'inline-flex', alignItems: 'center', justifyContent: 'center',
      fontSize: 15, letterSpacing: 2, fontWeight: 500,
      flexShrink: 0,
    }}>›››</span>
  );
}

// ─── Pill chip ───────────────────────────────────────────────────────────
export function Chip({ children, active = false, dark = false, gold = false, onClick, type = 'button' }) {
  let bg, fg, border;
  if (active) {
    if (gold) { bg = 'var(--gold)'; fg = 'var(--text)'; border = 'var(--gold)'; }
    else if (dark) { bg = 'var(--bg-cream)'; fg = 'var(--text)'; border = 'var(--bg-cream)'; }
    else { bg = 'var(--true-black)'; fg = '#fff'; border = 'var(--true-black)'; }
  } else {
    bg = 'transparent';
    fg = dark ? 'var(--text-mute-d)' : 'var(--text-mute-l)';
    border = dark ? 'var(--div-d)' : 'var(--div-l)';
  }
  return (
    <button type={type} onClick={onClick} style={{
      display: 'inline-flex', alignItems: 'center', gap: 6,
      padding: '8px 16px',
      borderRadius: 9999,
      background: bg, color: fg, border: `1px solid ${border}`,
      fontSize: 13, fontWeight: 500, letterSpacing: -0.05,
      whiteSpace: 'nowrap',
      cursor: onClick ? 'pointer' : 'default',
    }}>{children}</button>
  );
}

// ─── Step indicator (booking wizard) ─────────────────────────────────────
export function Stepper({ current = 1, total = 4 }) {
  return (
    <div style={{ display: 'flex', alignItems: 'center', gap: 12 }}>
      <span className="lbl-eyebrow">Step {current} of {total}</span>
      <div style={{ display: 'flex', gap: 6 }}>
        {Array.from({ length: total }, (_, i) => i + 1).map(n => (
          <span key={n} style={{
            width: n === current ? 28 : 16,
            height: 4,
            borderRadius: 4,
            background: n <= current ? 'var(--gold)' : 'rgba(14,14,14,0.12)',
            transition: 'all .25s ease',
          }}/>
        ))}
      </div>
    </div>
  );
}

// ─── Round icon button ───────────────────────────────────────────────────
export function RoundBtn({ children, size = 42, dark = false, onClick, ariaLabel, type = 'button' }) {
  return (
    <button type={type} onClick={onClick} aria-label={ariaLabel} style={{
      width: size, height: size,
      borderRadius: '50%',
      background: dark ? 'var(--true-black)' : 'var(--bg-cream)',
      color: dark ? '#fff' : 'var(--text)',
      display: 'inline-flex', alignItems: 'center', justifyContent: 'center',
      boxShadow: dark
        ? '0 4px 14px rgba(0,0,0,0.2), inset 0 1px 0 rgba(255,255,255,0.08)'
        : '0 4px 14px rgba(0,0,0,0.1), inset 0 1px 0 rgba(255,255,255,0.6)',
      cursor: onClick ? 'pointer' : 'default',
      flexShrink: 0,
    }}>{children}</button>
  );
}

// ─── Status badge ────────────────────────────────────────────────────────
export function StatusBadge({ children, tone = 'gold' }) {
  const tones = {
    gold:  { bg: 'var(--gold)',       fg: 'var(--text)' },
    dark:  { bg: 'var(--true-black)', fg: 'var(--gold)' },
    cream: { bg: 'var(--bg-cream)',   fg: 'var(--text)' },
  };
  const t = tones[tone] ?? tones.gold;
  return (
    <span style={{
      display: 'inline-block',
      padding: '6px 12px',
      borderRadius: 9999,
      background: t.bg, color: t.fg,
      fontSize: 10, fontWeight: 700, letterSpacing: 0.8,
      textTransform: 'uppercase',
    }}>{children}</span>
  );
}
