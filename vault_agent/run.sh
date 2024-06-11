#!/usr/bin/with-contenv bashio

set -e
set -o pipefail

VAULT_AUTH_ROLE_ID_FILE=/data/.approle-id

VAULT_ADDR="$(bashio::config 'vault_server')"
VAULT_AUTH_ROLE_ID="$(bashio::config 'vault_auth_role_id')"
VAULT_PKI_ROLE="$(bashio::config 'vault_pki_role')"
VAULT_PKI_CERT_CN="$(bashio::config 'vault_pki_common_name')"
VAULT_TLS_SKIP_VERIFY="$(bashio::config 'vault_tls_skip_verify')"

echo "$VAULT_AUTH_ROLE_ID" > $VAULT_AUTH_ROLE_ID_FILE

printf "$(cat /vault-agent.tmpl)" \
    "$VAULT_ADDR" \
    "$VAULT_TLS_SKIP_VERIFY" \
    "$VAULT_AUTH_ROLE_ID_FILE" \
    "$VAULT_PKI_ROLE" \
    "$VAULT_PKI_CERT_CN" \
    "$VAULT_PKI_ROLE" \
    "$VAULT_PKI_CERT_CN" \
> /data/config.hcl

cat /data/config.hcl

vault agent -config=/data/config.hcl -log-level=info
