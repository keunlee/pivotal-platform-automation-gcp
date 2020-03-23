#!/bin/bash
DOMAIN=${PCF_SUBDOMAIN_NAME}.${PCF_DOMAIN_NAME} 
EMAIL=${MY_EMAIL}

sudo certbot --agree-tos -m ${EMAIL} \
  certonly --cert-name  ${DOMAIN}  \
  --dns-google \
  -n \
  -d "${DOMAIN}, *.${DOMAIN}, *.apps.${DOMAIN}, *.sys.${DOMAIN}, *.ws.${DOMAIN}, *.login.sys.${DOMAIN}, *.uaa.sys.${DOMAIN}, *.pks.${DOMAIN}, *.pks.pks.${DOMAIN}, *.concourse.${DOMAIN}" \
  --dns-google-credentials /home/keunlee/gcp_credentials.json \
  --dns-google-propagation-seconds 60

