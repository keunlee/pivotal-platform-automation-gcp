gcloud dns managed-zones create test-zone --dns-name ${CONCOURSE_SUBDOMAIN_NAME}.${PCF_DOMAIN_NAME}. --description "PCF ZONE"
DOMAIN=${CONCOURSE_SUBDOMAIN_NAME}.${PCF_DOMAIN_NAME} EMAIL=${MY_EMAIL} ../bin/certbot.sh
gcloud dns managed-zones delete test-zone

GOOGLE_APPLICATION_CREDENTIALS=~/gcp_credentials.json \
  control-tower deploy \
    --region ${GCP_REGION} \
    --iaas gcp \
    --workers 3 \
    --domain concourse.${CONCOURSE_SUBDOMAIN_NAME}.${PCF_DOMAIN_NAME} \
    --tls-cert "$(sudo cat /etc/letsencrypt/live/${CONCOURSE_SUBDOMAIN_NAME}.${PCF_DOMAIN_NAME}/fullchain.pem)" \
    --tls-key "$(sudo cat /etc/letsencrypt/live/${CONCOURSE_SUBDOMAIN_NAME}.${PCF_DOMAIN_NAME}/privkey.pem)" \
    pautomation