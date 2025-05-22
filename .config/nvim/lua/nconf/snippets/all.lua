local ls = require('luasnip')
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local f = ls.function_node
local c = ls.choice_node

ls.add_snippets('all', {
  s('rfc', {
    t({ 'export default function ' }),
    f(function(_, snip)
      return snip.env.TM_FILENAME_BASE or 'Component'
    end, {}),
    t({ '() {', '\treturn (', '\t\t<div>', '\t\t\t' }),
    i(1),
    t({ '', '\t\t</div>', '\t)', '}', '' }),
  }),
})

ls.add_snippets('all', {
  s('lorem', {
    t({
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
    }),
  }),
})

ls.add_snippets('html', {
  s('html5', {
    t({ '<!DOCTYPE html>', '<html lang="' }),
    c(1, {
      t('en'),
      t('fr'),
      t('es'),
      t('de'),
      t('zh'),
      i(nil, ''),
    }),
    t({
      '">',
      '<head>',
      '  <meta charset="UTF-8">',
      '  <meta name="viewport" content="width=device-width, initial-scale=1.0">',
      '  <title>',
    }),
    i(2, 'Document Title'),
    t({ '</title>', '  ' }),
    i(3, ''),
    t({ '', '</head>', '<body>', '  ' }),
    i(4, ''),
    t({ '', '</body>', '</html>' }),
  }),
})
