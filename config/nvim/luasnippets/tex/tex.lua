local ls = require "luasnip"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
return {
  s({ trig = ";ds", wordTrig = false, snippetType = "autosnippet" }, { t "\\displaystyle" }),
  s({ trig = ";dp", wordTrig = false, snippetType = "autosnippet" }, { t "\\partial" }),
  s({ trig = ";dm", wordTrig = false, snippetType = "autosnippet" }, { t { "\\[", "\t" }, i(1), t { "", "\\]" } }),
  s({ trig = ";$", wordTrig = false, snippetType = "autosnippet" }, { t "$", i(1), t "$" }),
  s(
    { trig = ";d(%d)", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    { f(function(_, snip)
      return "\\" .. string.rep("d", snip.captures[1]) .. "ot{"
    end), i(1), t "}" }
  ),
  s(
    { trig = ";def", wordTrig = false, snippetType = "autosnippet" },
    { t { "\\begin{definition}", "\t" }, i(1), t { "", "\\end{definition}" } }
  ),
  s({ trig = ";fr", wordTrig = false, snippetType = "autosnippet" }, { t "\\frac{", i(1), t "}{", i(2), t "}" }),
  s({ trig = ";v", wordTrig = false, snippetType = "autosnippet" }, { t "\\vec{", i(1), t "}" }),
  s({ trig = ";_", wordTrig = false, snippetType = "autosnippet" }, { t "_{", i(1), t "}" }),
  s({ trig = ";^", wordTrig = false, snippetType = "autosnippet" }, { t "^{", i(1), t "}" }),
  s({ trig = ";p", wordTrig = false, snippetType = "autosnippet" }, { t "\\left(", i(1), t "\\right)" }),
  s({ trig = ";m", wordTrig = false, snippetType = "autosnippet" }, { t "\\left|", i(1), t "\\right|" }),
  s({ trig = ";|", wordTrig = false, snippetType = "autosnippet" }, { t "\\left|", i(1), t "\\right|" }),
  s({ trig = ";be", wordTrig = false, snippetType = "autosnippet" }, { t "\\left{", i(1), t "\\right}" }),
  s({ trig = ";bk", wordTrig = false, snippetType = "autosnippet" }, { t "\\left[", i(1), t "\\right]" }),
  s({ trig = ";sq", wordTrig = false, snippetType = "autosnippet" }, { t "\\sqrt{", i(1), t "}" }),
  s(
    { trig = ";lm", wordTrig = false, snippetType = "autosnippet" },
    { t "\\lim\\limits_{", i(1), t "\\to", i(2), t "}" }
  ),
  s({ trig = ";sg", wordTrig = false, snippetType = "autosnippet" }, {
    t { "\\begin{figure}[h]", "\t\\centering", "\t\\includesvg[width=0.45\\linewidth]{" },
    i(1),
    t { "}", "\t\\caption{}\\label{fig:" },
    i(2),
    t { "}", "\\end{figure}" },
  }),
  s({ trig = ";sss", wordTrig = false, snippetType = "autosnippet" }, {
    t "\\subsubsection{",
    i(1),
    t "}",
  }),
  s({ trig = ";eq", wordTrig = false, snippetType = "autosnippet" }, {
    t { "\\begin{equation}", "\t" },
    i(1),
    t { "", "\\end{equation}" },
  }),
  s({ trig = ";ex", wordTrig = false, snippetType = "autosnippet" }, {
    t { "\\begin{example}", "\t" },
    i(1),
    t { "", "\\end{example}" },
  }),
  s({ trig = ";tx", wordTrig = false, snippetType = "autosnippet" }, { t "\\text{", i(1), t "}" }),

  s({ trig = "\\approx", wordTrig = false, snippetType = "snippet" }, { t "\\approx" }),
  s({ trig = "\\text", wordTrig = false, snippetType = "snippet" }, { t "\\text{", i(1), t "}" }),
  s(
    { trig = "eqaution:ref", wordTrig = false, priority = 1000, snippetType = "snippet" },
    { i(1, "Equation"), t "~\\ref{eq:", i(2), t "}" }
  ),
  s(
    { trig = ";rfeq", wordTrig = false, priority = 1000, snippetType = "autosnippet" },
    { t "(\\ref{eq:", i(1), t "})" }
  ),
}
