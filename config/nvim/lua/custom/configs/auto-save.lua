local autosave = require("auto-save")
autosave.setup({
  trigger_events = { "InsertLeave" }
})
