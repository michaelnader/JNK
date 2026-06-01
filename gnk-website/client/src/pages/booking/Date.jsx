import React from 'react';
import { useNavigate } from 'react-router-dom';
import { BookingShell } from './BookingShell.jsx';
import { CardLight } from '../../components/cards.jsx';
import { CTAGold, RoundBtn } from '../../components/ui.jsx';
import { useBooking } from '../../lib/booking.jsx';

export default function BookingDate() {
  const navigate = useNavigate();
  const b = useBooking();
  const { guestCount } = b.state;

  // Anchor to today; render a 5-week grid (Mon-start) starting from the
  // first Monday on/before today. The "selected" cell is today + 3 days.
  const today = React.useMemo(() => new Date(), []);
  const [picked, setPicked] = React.useState(addDays(today, 3));

  const month = picked.toLocaleString('en-GB', { month: 'long', year: 'numeric' });
  const cells = buildCalendar(picked.getFullYear(), picked.getMonth(), today);

  const continueNext = () => {
    b.patch({ date: picked.toISOString().slice(0, 10), guestCount });
    navigate('/book/time');
  };

  return (
    <BookingShell
      step={1}
      eyebrow={b.state.restaurantId
        ? `${cap(b.state.restaurantId)} · ${guestCount} guests`
        : 'Pick a date'}
      title="Choose a date."
    >
      {/* Party size */}
      <CardLight padding={22} style={{ marginBottom: 16 }}>
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', gap: 16 }}>
          <div>
            <div className="lbl-eyebrow">Party size</div>
            <div style={{ fontSize: 28, fontWeight: 700, letterSpacing: -0.5, marginTop: 4 }}>
              {guestCount} {guestCount === 1 ? 'guest' : 'guests'}
            </div>
          </div>
          <div style={{ display: 'flex', gap: 8 }}>
            <RoundBtn ariaLabel="Decrease guests" onClick={() => b.patch({ guestCount: Math.max(1, guestCount - 1) })}>
              <span style={{ fontSize: 18 }}>−</span>
            </RoundBtn>
            <RoundBtn ariaLabel="Increase guests" onClick={() => b.patch({ guestCount: Math.min(12, guestCount + 1) })}>
              <span style={{ fontSize: 18 }}>+</span>
            </RoundBtn>
          </div>
        </div>
      </CardLight>

      {/* Calendar */}
      <CardLight padding={22}>
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: 16 }}>
          <div style={{ fontSize: 18, fontWeight: 700 }}>{month}</div>
          <div style={{ display: 'flex', gap: 8 }}>
            <RoundBtn size={36} onClick={() => setPicked(addMonths(picked, -1))} ariaLabel="Previous month">‹</RoundBtn>
            <RoundBtn size={36} onClick={() => setPicked(addMonths(picked, 1))} ariaLabel="Next month">›</RoundBtn>
          </div>
        </div>

        <Calendar cells={cells} picked={picked} onPick={setPicked} today={today}/>
      </CardLight>

      <div style={{ display: 'flex', justifyContent: 'flex-end', marginTop: 28 }}>
        <CTAGold onClick={continueNext}>
          {picked.toLocaleDateString('en-GB', { weekday: 'short', day: 'numeric', month: 'short' })}
        </CTAGold>
      </div>
    </BookingShell>
  );
}

function Calendar({ cells, picked, onPick, today }) {
  const dows = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
  return (
    <div>
      <div style={{ display: 'grid', gridTemplateColumns: 'repeat(7, 1fr)', marginBottom: 6 }}>
        {dows.map((d, i) => (
          <div key={i} style={{ textAlign: 'center', color: 'var(--text-mute-l)', fontSize: 11, fontWeight: 600 }}>{d}</div>
        ))}
      </div>
      <div style={{ display: 'grid', gridTemplateColumns: 'repeat(7, 1fr)', gap: 4 }}>
        {cells.map((d, i) => {
          if (!d) return <div key={i} style={{ aspectRatio: '1 / 1' }}/>;
          const isPicked = sameDay(d, picked);
          const isToday = sameDay(d, today);
          const isPast = d < startOfDay(today);
          return (
            <button
              key={i}
              disabled={isPast}
              onClick={() => onPick(d)}
              style={{
                aspectRatio: '1 / 1',
                borderRadius: '50%',
                background: isPicked ? 'var(--gold)'
                  : (isToday ? 'rgba(14,14,14,0.07)' : 'transparent'),
                color: isPicked ? 'var(--text)' : (isPast ? 'var(--text-faint-l)' : 'var(--text)'),
                fontSize: 14,
                fontWeight: isPicked ? 700 : 500,
                cursor: isPast ? 'not-allowed' : 'pointer',
                transition: 'background .15s',
              }}>{d.getDate()}</button>
          );
        })}
      </div>
    </div>
  );
}

// ─── date helpers ────────────────────────────────────────────────────────
function addDays(d, n) { const x = new Date(d); x.setDate(x.getDate() + n); return x; }
function addMonths(d, n) { const x = new Date(d); x.setMonth(x.getMonth() + n); return x; }
function startOfDay(d) { const x = new Date(d); x.setHours(0,0,0,0); return x; }
function sameDay(a, b) {
  return a.getFullYear() === b.getFullYear() && a.getMonth() === b.getMonth() && a.getDate() === b.getDate();
}

function buildCalendar(year, month) {
  const first = new Date(year, month, 1);
  // Make Monday the first column
  const startCol = (first.getDay() + 6) % 7;
  const daysInMonth = new Date(year, month + 1, 0).getDate();
  const cells = [];
  for (let i = 0; i < startCol; i++) cells.push(null);
  for (let d = 1; d <= daysInMonth; d++) cells.push(new Date(year, month, d));
  while (cells.length % 7 !== 0) cells.push(null);
  return cells;
}

function cap(s) { return s.charAt(0).toUpperCase() + s.slice(1); }
