function normalize(value) {
  return (value || '').toLowerCase()
}

function includesAny(text, patterns) {
  return patterns.some((pattern) => text.includes(pattern))
}

export function buildMoveAssistantPlan({ fromPostal, toPostal, moveDate, includePacking, notes }) {
  const normalizedNotes = normalize(notes)
  const samePrefix = fromPostal && toPostal && fromPostal[0] === toPostal[0]

  let moveType = 'intercity'
  if (samePrefix) moveType = 'local'
  if (includesAny(normalizedNotes, ['ottawa', 'thunder bay', 'windsor', 'sudbury'])) moveType = 'long-haul'

  let crewSize = 3
  if (includesAny(normalizedNotes, ['studio', '1 bedroom', 'one bedroom'])) crewSize = 2
  if (includesAny(normalizedNotes, ['3 bedroom', 'four bedroom', 'office', 'warehouse'])) crewSize = 4
  if (includesAny(normalizedNotes, ['piano', 'safe', 'pool table', 'antique'])) crewSize = Math.max(crewSize, 4)

  const summary = [
    `Suggested move type: ${moveType}.`,
    `Recommended crew: ${crewSize} movers + 1 truck.`,
    includePacking
      ? 'Packing service selected: prep can start 7 to 10 days before move day.'
      : 'Self-packing selected: start packing non-essentials 10 to 14 days before move day.',
  ].join(' ')

  const checklist = [
    'Confirm building access, elevator booking, and parking permits.',
    'Label boxes by room and priority (open first, fragile, storage).',
    'Separate valuables, medications, and documents into a personal essentials bag.',
    'Disassemble large furniture the day before (beds, tables, sectional legs).',
    'Take photos of electronics before unplugging cables for faster setup.',
  ]

  if (includesAny(normalizedNotes, ['piano', 'safe', 'art', 'antique'])) {
    checklist.push('Request specialty handling equipment for heavy or delicate items.')
  }

  const timeline = moveDate
    ? [
        '14+ days before: finalize inventory and reserve weekend slot.',
        '7 days before: complete change-of-address and utility transfer.',
        '2 days before: finish packing and keep only essentials out.',
        'Move day: do room-by-room walkthrough before truck departure.',
      ]
    : [
        'Now: draft inventory and shortlist preferred weekend windows.',
        'When date is set: complete the 14-day prep sequence automatically.',
      ]

  const riskFlags = []
  if (moveType === 'long-haul') riskFlags.push('Long-haul route: add buffer time for same-day delivery expectations.')
  if (!moveDate) riskFlags.push('No date selected: book early to keep preferred weekend availability.')
  if (includesAny(normalizedNotes, ['stairs', 'no elevator'])) riskFlags.push('Access constraints detected: confirm carry distance and stair flights in advance.')

  return {
    summary,
    checklist,
    timeline,
    riskFlags,
  }
}
