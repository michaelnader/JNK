import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { BookingShell } from './BookingShell.jsx';
import { CardDark, CardLight } from '../../components/cards.jsx';
import { Chip, CTAGold } from '../../components/ui.jsx';
import { useBooking } from '../../lib/booking.jsx';

const OPTS = ['Birthday', 'Anniversary', 'Date night', 'Business', 'Celebration', 'Just because'];
const DIET = ['Vegetarian', 'Pescatarian', 'Gluten-free'];

export default function BookingOccasion() {
  const navigate = useNavigate();
  const b = useBooking();
  const [occasion, setOccasion] = useState(b.state.occasion ?? 'Anniversary');
  const [note, setNote] = useState(b.state.note ?? '');
  const [dietary, setDietary] = useState(new Set(b.state.dietary?.length ? b.state.dietary : ['Pescatarian']));

  const toggleDiet = (d) => setDietary(prev => {
    const n = new Set(prev);
    n.has(d) ? n.delete(d) : n.add(d);
    return n;
  });

  return (
    <BookingShell
      step={3}
      eyebrow="Optional · helps us prepare"
      title="A bit more."
    >
      <CardLight padding={22}>
        <div className="lbl-eyebrow" style={{ marginBottom: 12 }}>Occasion</div>
        <div style={{ display: 'flex', flexWrap: 'wrap', gap: 8 }}>
          {OPTS.map(o => (
            <Chip key={o} active={occasion === o} gold={occasion === o} onClick={() => setOccasion(o)}>
              {o}
            </Chip>
          ))}
        </div>
      </CardLight>

      <CardLight padding={22} style={{ marginTop: 16 }}>
        <label className="lbl-eyebrow" style={{ display: 'block', marginBottom: 10 }}>Special request</label>
        <textarea
          value={note}
          onChange={(e) => setNote(e.target.value)}
          placeholder="A quiet corner table, a cake at the end…"
          rows={3}
          style={{
            width: '100%',
            border: 0,
            outline: 'none',
            background: 'transparent',
            font: 'inherit',
            fontSize: 14,
            lineHeight: 1.55,
            color: 'var(--text)',
            resize: 'vertical',
          }}
        />
      </CardLight>

      <CardDark padding={18} style={{ marginTop: 16 }}>
        <div className="lbl-eyebrow" style={{ color: 'rgba(255,255,255,0.55)', marginBottom: 10 }}>Dietary</div>
        <div style={{ display: 'flex', flexWrap: 'wrap', gap: 8 }}>
          {DIET.map(d => (
            <Chip key={d} dark active={dietary.has(d)} gold={dietary.has(d)} onClick={() => toggleDiet(d)}>
              {d}
            </Chip>
          ))}
        </div>
      </CardDark>

      <div style={{ display: 'flex', justifyContent: 'flex-end', marginTop: 28 }}>
        <CTAGold onClick={() => {
          b.patch({ occasion, note, dietary: Array.from(dietary) });
          navigate('/book/review');
        }}>Continue to review</CTAGold>
      </div>
    </BookingShell>
  );
}
