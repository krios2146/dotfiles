---@diagnostic disable: undefined-global

local function get_frontmatter()
  local now = os.time()
  local monday = now - (6 * 24 * 60 * 60)
  local past_sunday = monday - (24 * 60 * 60)
  local next_monday = now + (26 * 60 * 60)

  local time = os.date('%T', now)
  local date = os.date('%F', now)

  local current_month = os.date('[[%G-%B]]', now)
  local monday_month = os.date('[[%G-%B]]', monday)

  local months = { current_month }
  if current_month ~= monday_month then
    table.insert(months, monday_month)
  end

  local past_week = os.date('[[%G-W%V]]', past_sunday)
  local next_week = os.date('[[%G-W%V]]', next_monday)

  return { time = time, date = date, months = months, past_week = past_week, next_week = next_week }
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
    t { '---', '' },
    f(function()
      local frontmatter = get_frontmatter()

      local lines = {
        'time: ' .. frontmatter.time,
        'date: ' .. frontmatter.date,
      }

      if #frontmatter.months == 1 then
        table.insert(lines, 'month: ' .. frontmatter.months[1])
      else
        table.insert(list, 'month: ')
        for _, month in ipairs(frontmatter.months) do
          table.insert(lines, '\t- ' .. month)
        end
      end

      table.insert(lines, 'past_week: ' .. frontmatter.past_week)
      table.insert(lines, 'next_week: ' .. frontmatter.next_week)

      return lines
    end),
    t { '', 'tags: #journal/weekly', '---', '', '' },
    i(1),
  }),
}
