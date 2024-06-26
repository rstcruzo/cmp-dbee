-- source is the source of the completion items.
local source = {}

local dbee = require("dbee")
local handler = require("cmp-dbee.handler")
local is_available = dbee.api.core.is_loaded() and dbee.api.ui.is_loaded()

--- Constructor for nvim-cmp source
---@param cfg Config
function source:new(cfg)
  local cls = { handler = nil, cfg = cfg }
  setmetatable(cls, self)
  self.__index = self
  return cls
end

function source:get_handler()
  if not self.handler then
    self.handler = handler:new(self.cfg, true)
  end

  return self.handler
end

function source:complete(_, callback)
  local items = self:get_handler():get_completion()
  callback {
    items = items,
    isIncomplete = false,
  }
end

function source:is_available()
  return dbee.api.core.is_loaded() and dbee.api.ui.is_loaded()
end

function source:get_trigger_characters()
  return { '"', "`", "[", "]", ".", "(", ")" }
end

function source:get_debug_name()
  return "cmp-dbee"
end

return source
