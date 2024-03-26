require("lspconfig").zls.setup({
  capabilities = require("coq").lsp_ensure_capabilities({})
})
