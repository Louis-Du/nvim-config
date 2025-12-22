local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

-- System.out.println
ls.add_snippets("java", {
  s("sout", {
    t("System.out.println("),
    i(1),
    t(");")
  }),

-- main method
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

-- for loop
  s("fori", {
    t("for (int i = 0; i < "),
    i(1),
    t("; i++) {"),
    t({ "", "    " }),
    i(2),
    t({ "", "}" })
  }),

-- Scanner
  s("scn", {
    t("Scanner "),
    i(1, "scanner"),
    t(" = new Scanner(System.in);")
  }),
})
