#!/usr/bin/with-contenv bashio

set -e
set -o pipefail

VAULT_ADDR="$(bashio::config 'vault_server')"
VAULT_TOKEN="$(bashio::config 'vault_token')"
VAULT_TOKEN_FILE="/data/.vault-token"
VAULT_PKI_ROLE="$(bashio::config 'vault_pki_role')"
VAULT_PKI_CERT_CN="$(bashio::config 'vault_pki_common_name')"
VAULT_TLS_SKIP_VERIFY="$(bashio::config 'vault_tls_skip_verify')"

echo "$VAULT_TOKEN" > $VAULT_TOKEN_FILE

printf "$(cat /vault-agent.tmpl)" \
    "$VAULT_ADDR" \
    "$VAULT_TLS_SKIP_VERIFY" \
    "$VAULT_TOKEN_FILE" \
    "$VAULT_PKI_ROLE" \
    "$VAULT_PKI_CERT_CN" \
    "$VAULT_PKI_ROLE" \
    "$VAULT_PKI_CERT_CN" \
> /data/config.hcl

cat /data/config.hcl

vault agent -config=/data/config.hcl -log-level=info
