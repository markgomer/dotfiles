local get_state = ya.sync(function(state)
  return state.source_path
end)

local set_state = ya.sync(function(state, value)
  state.source_path = value
end)

local get_hovered_path = ya.sync(function()
  local hovered = cx.active.current.hovered
  if hovered then
    return tostring(hovered.url)
  end
  return nil
end)

local get_cwd = ya.sync(function()
    return tostring(cx.active.current.cwd)
end)

local function create_link(link_type)
  local source_path = get_state()
  if not source_path then
    ya.notify({ title = "makelink", content = "No source path saved. Use the 'save' action first.", level = "error", timeout = 5 })
    return
  end

  local destination_dir = get_cwd()
  local link_command_args

  if link_type == "soft" then
    link_command_args = { "-s" }
    ya.notify({ title = "makelink", content = "Creating soft link...", level = "info", timeout = 1 })
  elseif link_type == "hard" then
    link_command_args = {}
    ya.notify({ title = "makelink", content = "Creating hard link...", level = "info", timeout = 1 })
  else
    ya.notify({ title = "makelink", content = "Invalid link type specified.", level = "error", timeout = 5 })
    return
  end

  local source_url = Url(source_path)
  local source_name = source_url.name
  if not source_name or source_name == "" then
    ya.notify({ title = "makelink", content = "Could not determine source name from path: " .. source_path, level = "error", timeout = 5 })
    set_state(nil)
    return
  end
  local final_destination = tostring(Url(destination_dir):join(source_name))

  table.insert(link_command_args, source_path)
  table.insert(link_command_args, final_destination)

  local child, err = Command("ln")
    :arg(link_command_args)
    :stderr(Command.PIPED)
    :spawn()

  if err then
    ya.notify({ title = "makelink", content = "Failed to execute ln command: " .. tostring(err), level = "error", timeout = 5 })
    set_state(nil)
    return
  end

  local status, wait_err = child:wait()
  if wait_err then
    ya.notify({ title = "makelink", content = "Error waiting for link creation: " .. tostring(wait_err), level = "error", timeout = 5 })
  elseif status and status.success then
    ya.notify({ title = "makelink", content = "Link created successfully!", level = "info", timeout = 1 })
  else
    local stderr_output = ""
    while true do
        local line, event = child:read_line()
        if event == 2 then break end
        if event == 1 and line then stderr_output = stderr_output .. line end
    end
    if stderr_output == "" then stderr_output = "Command failed with no stderr output." end
    ya.notify({ title = "makelink", content = "Error creating link: " .. stderr_output, level = "error", timeout = 5 })
  end

  set_state(nil) -- Reset for next use
end

return {
  entry = function(_, job)
    local action = job.args[1] or "default"

    if action == "save" then
      local hovered_path = get_hovered_path()
      if hovered_path then
        set_state(hovered_path)
        ya.notify({ title = "makelink", content = "Source path saved: " .. hovered_path, level = "info", timeout = 1 })
      else
        ya.notify({ title = "makelink", content = "No file or directory hovered.", level = "error", timeout = 5 })
      end
    elseif action == "soft" then
      create_link("soft")
    elseif action == "hard" then
      create_link("hard")
    else
      ya.notify({ title = "makelink", content = "Invalid action. Pass 'save', 'soft', or 'hard' as an argument.", level = "error", timeout = 5 })
    end
  end,
}