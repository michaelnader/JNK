// BookingContext — wizard state shared across the 4 booking pages plus the
// payment step. Lives at the router root so users can navigate forward and
// back without losing form data.
import React, { createContext, useContext, useMemo, useReducer } from 'react';

const initial = {
  restaurantId: null,
  guestCount: 2,
  date: null,        // ISO date string yyyy-mm-dd
  time: null,        // HH:MM
  occasion: null,
  dietary: [],
  note: '',
};

function reducer(state, action) {
  switch (action.type) {
    case 'start':
      return { ...initial, restaurantId: action.restaurantId };
    case 'patch':
      return { ...state, ...action.patch };
    case 'reset':
      return initial;
    default:
      return state;
  }
}

const Ctx = createContext(null);

export function BookingProvider({ children }) {
  const [state, dispatch] = useReducer(reducer, initial);

  const api = useMemo(() => ({
    state,
    start: (restaurantId) => dispatch({ type: 'start', restaurantId }),
    patch: (patch) => dispatch({ type: 'patch', patch }),
    reset: () => dispatch({ type: 'reset' }),
  }), [state]);

  return <Ctx.Provider value={api}>{children}</Ctx.Provider>;
}

export function useBooking() {
  const ctx = useContext(Ctx);
  if (!ctx) throw new Error('useBooking() outside BookingProvider');
  return ctx;
}
