if is_use_icons() then
  return {
    Error = " ",
    Warn = " ",
    Info = " ",
    Hint = " ",
  }
else
  return {
    Error = "E ",
    Warn = "W ",
    Info = "I ",
    Hint = "H ",
  }
end
