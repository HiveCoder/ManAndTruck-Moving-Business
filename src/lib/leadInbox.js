import { supabase } from '@/lib/supabase.js'

export const LEAD_INBOX_EMAIL = 'underspecific@gmail.com'

const configuredFunction = import.meta.env.VITE_SUPABASE_LEAD_FUNCTION
const functionCandidates = [...new Set([
  configuredFunction,
  'send-lead-email',
])].filter(Boolean)

export async function sendLeadEmail({
  subject,
  lines = [],
  name = 'Website Lead',
  replyTo = '',
}) {
  const message = lines.filter(Boolean).join('\n')

  for (const fnName of functionCandidates) {
    try {
      const { error } = await supabase.functions.invoke(fnName, {
        body: {
          to: LEAD_INBOX_EMAIL,
          subject,
          text: message,
          message,
          name,
          replyTo,
          source: 'manandtruck-web',
        },
      })

      if (!error) return true
    } catch {
      // Try next candidate if available.
    }
  }

  return false
}
