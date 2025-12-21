local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node

-- Clase básica
ls.add_snippets("java", {
  s("class", {
    t("public class "),
    i(1, "NombreClase"),
    t({" {", "", "    "}),
    i(2),
    t({"", "}"})
  }),

-- main
  s("main", {
    t({
      "public static void main(String[] args) {",
      "    "
    }),
    i(1),
    t({
      "",
      "}"
    })
  }),
})
