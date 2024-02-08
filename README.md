# Vault Agent for Home Assistant

This add-on requires a working vault server with
[token auth](https://developer.hashicorp.com/vault/docs/auth/token) and the
[pki secrets engine](https://developer.hashicorp.com/vault/docs/secrets/pki)
enabled.

The add-on then takes the following configuration
```
vault_server: str
vault_token: str
vault_pki_role: str
vault_pki_common_name: str
vault_tls_skip_verify: bool
```

And runs [Vault Agent](https://developer.hashicorp.com/vault/docs/agent-and-proxy),
rendering a TLS key pair for `vault_pki_common_name` to
`/ssl/fullchain.pem` and `/ssl/privkey.pem`. This is the default location where
the
[nginx proxy add-on](https://github.com/home-assistant/addons/tree/master/nginx_proxy)
looks for a key pair.

vault-agent will automatically update the certificates before expiry, and
nginx has a
[daily check](https://github.com/home-assistant/addons/blob/37c3cdc139a7563208b04ae57bf9f8c98bbcee18/nginx_proxy/rootfs/etc/periodic/daily/check_certificate_renewal)
that'll reload the proxy if certificates have changed.
