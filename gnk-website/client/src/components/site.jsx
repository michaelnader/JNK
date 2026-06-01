// Site shell: top header (logo + nav + sign-in CTA) and bottom footer.
// All responsive rules live in index.css via classes — no inline @media tricks.
import React, { useState } from 'react';
import { Link, NavLink } from 'react-router-dom';

export function SiteHeader({ transparent = false }) {
  const [open, setOpen] = useState(false);
  const links = [
    { to: '/restaurants', label: 'Restaurants' },
    { to: '/reservations', label: 'Reservations' },
  ];

  return (
    <header style={{
      position: transparent ? 'absolute' : 'sticky',
      top: 0, left: 0, right: 0,
      zIndex: 50,
      background: transparent
        ? 'linear-gradient(180deg, rgba(0,0,0,0.30), transparent)'
        : 'var(--bg-sand)',
      color: transparent ? '#fff' : 'var(--text)',
      borderBottom: transparent ? 'none' : '1px solid var(--div-l)',
    }}>
      <div className="container site-header-row">
        <Link to="/" style={{
          display: 'inline-flex', alignItems: 'center', gap: 10,
          letterSpacing: -0.4,
        }} onClick={() => setOpen(false)}>
          <span style={{
            display: 'inline-block', width: 10, height: 10, borderRadius: '50%',
            background: 'var(--gold)',
          }}/>
          <span style={{ fontWeight: 700, fontSize: 18 }}>G'nK</span>
        </Link>

        <nav className="site-nav">
          {links.map(l => (
            <NavLink key={l.to} to={l.to} style={({ isActive }) => ({
              fontSize: 14,
              fontWeight: isActive ? 600 : 500,
              opacity: isActive ? 1 : 0.85,
              borderBottom: isActive ? '2px solid var(--gold)' : '2px solid transparent',
              paddingBottom: 2,
            })}>{l.label}</NavLink>
          ))}
        </nav>

        <Link
          to="/restaurants"
          className="site-cta"
          style={{
            background: transparent ? '#fff' : 'var(--true-black)',
            color: transparent ? 'var(--text)' : '#fff',
          }}
        >
          Reserve a table
        </Link>

        <button
          onClick={() => setOpen(o => !o)}
          aria-label={open ? 'Close menu' : 'Open menu'}
          className="site-burger"
          style={{
            background: transparent ? 'rgba(255,255,255,0.15)' : 'var(--bg-cream)',
            color: 'inherit',
          }}>
          {open ? '✕' : '≡'}
        </button>
      </div>

      <div className={`site-mobile-nav ${open ? 'is-open' : ''}`} style={{
        background: transparent ? 'rgba(0,0,0,0.85)' : 'var(--bg-sand)',
      }}>
        {links.map(l => (
          <NavLink key={l.to} to={l.to} onClick={() => setOpen(false)}>
            {l.label}
          </NavLink>
        ))}
        <Link
          to="/restaurants"
          onClick={() => setOpen(false)}
          style={{
            display: 'inline-flex', alignItems: 'center',
            marginTop: 8, height: 44, padding: '0 22px',
            borderRadius: 9999,
            background: 'var(--gold)', color: 'var(--text)',
            fontSize: 14, fontWeight: 600,
          }}
        >Reserve a table</Link>
      </div>
    </header>
  );
}

export function SiteFooter() {
  return (
    <footer style={{
      marginTop: 96,
      borderTop: '1px solid var(--div-l)',
      background: 'var(--bg-cream)',
    }}>
      <div className="container footer-cols" style={{ padding: '48px 0 32px' }}>
        <div>
          <div style={{ display: 'inline-flex', alignItems: 'center', gap: 10 }}>
            <span style={{ display: 'inline-block', width: 10, height: 10, borderRadius: '50%', background: 'var(--gold)' }}/>
            <span style={{ fontWeight: 700, fontSize: 18 }}>G'nK</span>
          </div>
          <p style={{ color: 'var(--text-mute-l)', fontSize: 13, marginTop: 10, lineHeight: 1.6, maxWidth: 280 }}>
            Six rooms, one table. Reservations open seven days ahead across the group.
          </p>
        </div>

        <FooterCol title="The Rooms" links={[
          ['Stanley', '/restaurants/stanley'],
          ['Sax', '/restaurants/sax'],
          ['byGanz', '/restaurants/byganz'],
          ["KIKI's Beach", '/restaurants/kikis'],
          ['Buoy', '/restaurants/buoy'],
          ['Mazeej', '/restaurants/mazeej'],
        ]}/>

        <FooterCol title="Account" links={[
          ['My reservations', '/reservations'],
          ['Sign in', '#'],
          ['Help', '#'],
        ]}/>

        <FooterCol title="Group" links={[
          ['About', '#'],
          ['Press', '#'],
          ['Careers', '#'],
          ['Contact', '#'],
        ]}/>
      </div>

      <div className="container" style={{
        padding: '20px 0',
        borderTop: '1px solid var(--div-l)',
        fontSize: 12, color: 'var(--text-mute-l)',
        display: 'flex', justifyContent: 'space-between', flexWrap: 'wrap', gap: 12,
      }}>
        <span>© {new Date().getFullYear()} G'nK Restaurants Group · Cairo · Sahel · Red Sea</span>
        <span>Off Duty palette · v8</span>
      </div>
    </footer>
  );
}

function FooterCol({ title, links }) {
  return (
    <div>
      <div className="lbl-eyebrow" style={{ marginBottom: 14 }}>{title}</div>
      <ul style={{ listStyle: 'none', padding: 0, margin: 0, display: 'grid', gap: 8 }}>
        {links.map(([label, to]) => (
          <li key={label}>
            <Link to={to} style={{ fontSize: 14, color: 'var(--text)', opacity: 0.85 }}>{label}</Link>
          </li>
        ))}
      </ul>
    </div>
  );
}
