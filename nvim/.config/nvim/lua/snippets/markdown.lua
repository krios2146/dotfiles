---@diagnostic disable: undefined-global

local function get_frontmatter()
  local now = os.time()
  local monday = now - (7 * 24 * 60 * 60)
  local past_sunday = monday - (24 * 60 * 60)
  local next_monday = now + (26 * 60 * 60)

  local time = os.date('%T', now)
  local date = os.date('%F', now)

  local current_month = os.date('[[%G-%B]]', now)
  local monday_month = os.date('[[%G-%B]]', monday)

  local month = current_month
  if current_month ~= monday_month then
    month = '\n\t- ' .. current_month .. '\n\t- ' .. monday_month
  end

  local past_week = os.date('[[%G-W%V]]', past_sunday)
  local next_week = os.date('[[%G-W%V]]', next_monday)

  return { time = time, date = date, month = month, past_week = past_week, next_week = next_week }
end

return {
  s('nt', {
    t { '---', '' },
    f(function()
      local frontmatter = get_frontmatter()
      return {
        'date: ' .. frontmatter.date,
        'time: ' .. frontmatter.time,
      }
    end),
    c(1, {
      sn(nil, { t { '', 'tags: #' }, i(1) }),
      sn(nil, { t { '', 'tags: #' }, i(1), t { '', 'sources: ' }, i(2) }),
    }),
    t { '', '---', '', '' },
    i(0),
  }),
  s('wk', {
    f(function()
      local frontmatter = get_frontmatter()
      return {
        '---',
        'time: ' .. frontmatter.time,
        'date: ' .. frontmatter.date,
        'month: ' .. frontmatter.month,
        'past_week: ' .. frontmatter.past_week,
        'next_week: ' .. frontmatter.next_week,
        'tags: #journal/weekly',
        '---',
        '',
        '',
      }
    end, {}),
    i(1),
  }),
}
