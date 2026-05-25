const MS_PER_DAY = 24 * 60 * 60 * 1000

function toLocalNoon(date) {
  return new Date(date.getFullYear(), date.getMonth(), date.getDate(), 12)
}

export function parseDateInput(value) {
  if (!value || typeof value !== 'string') return null
  const parts = value.split('-').map(Number)
  if (parts.length !== 3 || parts.some(Number.isNaN)) return null

  const [year, month, day] = parts
  const parsed = new Date(year, month - 1, day, 12)
  if (
    parsed.getFullYear() !== year ||
    parsed.getMonth() !== month - 1 ||
    parsed.getDate() !== day
  ) {
    return null
  }
  return parsed
}

export function formatDateInput(date) {
  const year = date.getFullYear()
  const month = String(date.getMonth() + 1).padStart(2, '0')
  const day = String(date.getDate()).padStart(2, '0')
  return `${year}-${month}-${day}`
}

export function isWeekendDate(date) {
  const day = date.getDay()
  return day === 0 || day === 6
}

export function minimumMoveDate(baseDate = new Date(), minDaysAhead = 14) {
  const base = toLocalNoon(baseDate)
  return new Date(base.getTime() + minDaysAhead * MS_PER_DAY)
}

export function firstBookableWeekend(baseDate = new Date(), minDaysAhead = 14) {
  const date = minimumMoveDate(baseDate, minDaysAhead)
  while (!isWeekendDate(date)) {
    date.setDate(date.getDate() + 1)
  }
  return date
}

export function isValidMoveDate(value, minDaysAhead = 14, baseDate = new Date()) {
  const parsed = parseDateInput(value)
  if (!parsed) return false
  if (!isWeekendDate(parsed)) return false

  const minDate = minimumMoveDate(baseDate, minDaysAhead)
  return parsed.getTime() >= minDate.getTime()
}
