local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  s("main", {
    t({
      "public static void main(String[] args) {",
      "    "
    }),
    i(1, "System.out.println(\"Hello World\");"),
    t({
      "",
      "}"
    })
  }),

  s("sysout", {
    t("System.out.println("),
    i(1, "\"\""),
    t(");")
  }),

  s("fori", {
    t("for (int "),
    i(1, "i"),
    t(" = 0; "),
    i(2, "i"),
    t(" < "),
    i(3, "n"),
    t("; "),
    i(4, "i"),
    t("++) {"),
    t({ "", "    " }),
    i(5),
    t({ "", "}" })
  }),

  s("class", {
    t("public class "),
    i(1, "MyClass"),
    t({ " {", "", "    " }),
    i(2),
    t({ "", "}" })
  }),
}
