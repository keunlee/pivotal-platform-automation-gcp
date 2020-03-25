# (1) create an .env file and supply the following values outside of this repository (do NOT check it in)

# PKS_API_URL=<CHANGE_ME>                                 // i.e. api.35-185-51-253.sslip.io:9443
# PKS_CLI_USERNAME=<CHANGE_ME>                            // i.e. pksadmin@domain.com
# PKS_CLI_PASSWORD=<CHANGE_ME>                            // i.e. 65b6f26c-7e27-4f74-aaf7-7e6d1a3f4450

# (2) in your terminal: source .env

# (3) execute this script: 

# CLUSTER_NAME=<CHANGE_ME> GCP_REGION=<CHANGE_ME> source delete-gcp-pks-cluster.sh

# sample 
# GCP_REGION=us-east1
# CLUSTER_NAME=mycluster
# CLUSTER_PLAN=small    // i.e. small, medium, large

### Log in to PKS
pks login -k -a ${PKS_API_URL} -u ${PKS_CLI_USERNAME} -p ${PKS_CLI_PASSWORD}
pks delete-cluster ${CLUSTER_NAME}
watch -n 5 pks cluster ${CLUSTER_NAME}
gcloud compute forwarding-rules delete ${CLUSTER_NAME}-master-api-8443 --region ${GCP_REGION} --quiet
gcloud compute target-pools delete ${CLUSTER_NAME}-master-api -region ${GCP_REGION} --quiet
gcloud compute addresses delete ${CLUSTER_NAME}-master-api-ip -region ${GCP_REGION} --quiet
pks clusters