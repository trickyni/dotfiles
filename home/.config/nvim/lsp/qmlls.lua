return {
  cmd = { "qmlls6" },
  on_attach = function(client, bufnr)
    client.server_capabilities.semanticTokensProvider = nil
  end,
}
