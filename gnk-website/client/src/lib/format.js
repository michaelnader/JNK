// Tiny formatters — keep dates + money consistent across pages.

const fmtMoney = new Intl.NumberFormat('en-EG', {
  style: 'currency', currency: 'EGP', maximumFractionDigits: 0,
});
export const money = (v) => fmtMoney.format(v).replace('EGP', 'EGP ');

export function formatDate(iso, opts = {}) {
  if (!iso) return '';
  const d = new Date(iso);
  if (Number.isNaN(d.getTime())) return iso;
  return d.toLocaleDateString('en-GB', {
    weekday: 'short', day: 'numeric', month: 'short',
    ...opts,
  });
}

export function formatTime(t) {
  return t ?? '';
}
