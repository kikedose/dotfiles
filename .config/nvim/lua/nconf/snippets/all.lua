local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local f = ls.function_node

ls.add_snippets("all", {
  s("rfc", {
    t({"export default function "}),
    f(function(_, snip) 
      return snip.env.TM_FILENAME_BASE or "Component"
    end, {}),
    t({" () {", "\treturn (", "\t\t<div>", "\t\t\t"}),
    i(1),
    t({"", "\t\t</div>", "\t)", "}", ""}),
  })
})

ls.add_snippets("all", {
  s("lorem", {
    t({
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."
    }),
  })
})
