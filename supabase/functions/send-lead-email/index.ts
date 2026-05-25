const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
  'Access-Control-Allow-Methods': 'POST, OPTIONS',
}

type LeadPayload = {
  to?: string
  subject?: string
  text?: string
  message?: string
  name?: string
  replyTo?: string
}

const jsonHeaders = { ...corsHeaders, 'Content-Type': 'application/json' }

async function sendWithBrevo({
  apiKey,
  toEmail,
  fromEmail,
  subject,
  content,
  replyTo,
}: {
  apiKey: string
  toEmail: string
  fromEmail: string
  subject: string
  content: string
  replyTo?: string
}) {
  const fromNameMatch = fromEmail.match(/^(.*?)\s*<([^>]+)>$/)
  const sender = fromNameMatch
    ? { name: fromNameMatch[1].trim().replace(/^"|"$/g, ''), email: fromNameMatch[2].trim() }
    : { name: 'ManAndTruck Movers', email: fromEmail.trim() }

  const response = await fetch('https://api.brevo.com/v3/smtp/email', {
    method: 'POST',
    headers: {
      'api-key': apiKey,
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({
      sender,
      to: [{ email: toEmail }],
      subject,
      textContent: content,
      replyTo: replyTo ? { email: replyTo } : undefined,
    }),
  })

  const data = await response.json()

  if (!response.ok) {
    throw new Error(`Brevo request failed: ${JSON.stringify(data)}`)
  }

  return data.messageId || null
}

async function sendWithResend({
  apiKey,
  toEmail,
  fromEmail,
  subject,
  content,
  replyTo,
}: {
  apiKey: string
  toEmail: string
  fromEmail: string
  subject: string
  content: string
  replyTo?: string
}) {
  const response = await fetch('https://api.resend.com/emails', {
    method: 'POST',
    headers: {
      Authorization: `Bearer ${apiKey}`,
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({
      from: fromEmail,
      to: [toEmail],
      subject,
      text: content,
      reply_to: replyTo || undefined,
    }),
  })

  const data = await response.json()

  if (!response.ok) {
    throw new Error(`Resend request failed: ${JSON.stringify(data)}`)
  }

  return data.id || null
}

Deno.serve(async (req) => {
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders })
  }

  if (req.method !== 'POST') {
    return new Response(JSON.stringify({ error: 'Method not allowed' }), {
      status: 405,
      headers: jsonHeaders,
    })
  }

  try {
    const brevoApiKey = Deno.env.get('BREVO_API_KEY')
    const resendApiKey = Deno.env.get('RESEND_API_KEY')
    if (!brevoApiKey && !resendApiKey) {
      return new Response(
        JSON.stringify({ error: 'Missing provider key. Set BREVO_API_KEY or RESEND_API_KEY.' }),
        {
          status: 500,
          headers: jsonHeaders,
        },
      )
    }

    const body = (await req.json()) as LeadPayload
    const subject = body.subject?.trim() || 'New Website Lead'
    const content = body.text?.trim() || body.message?.trim() || 'No message provided.'

    const toEmail = Deno.env.get('LEAD_TO_EMAIL') || body.to || 'underspecific@gmail.com'
    const fromEmail =
      Deno.env.get('MAIL_FROM_EMAIL') ||
      Deno.env.get('BREVO_FROM_EMAIL') ||
      Deno.env.get('RESEND_FROM_EMAIL') ||
      'ManAndTruck Movers <no-reply@manandtruck-moving-business.vercel.app>'

    let provider: 'brevo' | 'resend' = 'resend'
    let messageId: string | null = null

    try {
      if (brevoApiKey) {
        provider = 'brevo'
        messageId = await sendWithBrevo({
          apiKey: brevoApiKey,
          toEmail,
          fromEmail,
          subject,
          content,
          replyTo: body.replyTo,
        })
      } else if (resendApiKey) {
        provider = 'resend'
        messageId = await sendWithResend({
          apiKey: resendApiKey,
          toEmail,
          fromEmail,
          subject,
          content,
          replyTo: body.replyTo,
        })
      }
    } catch (providerErr) {
      return new Response(
        JSON.stringify({
          error: 'Lead email provider request failed',
          details: providerErr instanceof Error ? providerErr.message : 'Unknown provider error',
          provider,
        }),
        {
          status: 502,
          headers: jsonHeaders,
        },
      )
    }

    return new Response(JSON.stringify({ success: true, id: messageId, provider }), {
      status: 200,
      headers: jsonHeaders,
    })
  } catch (err) {
    return new Response(
      JSON.stringify({
        error: 'Unexpected function error',
        details: err instanceof Error ? err.message : 'Unknown error',
      }),
      {
        status: 500,
        headers: jsonHeaders,
      },
    )
  }
})
