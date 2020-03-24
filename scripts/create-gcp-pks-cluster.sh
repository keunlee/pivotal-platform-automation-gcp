# (1) create an .env file and supply the following values outside of this repository (do NOT check it in)

# PKS_API_URL=<CHANGE_ME>                                 // i.e. api.35-185-51-253.sslip.io:9443
# PKS_CLI_USERNAME=<CHANGE_ME>                            // i.e. pksadmin@domain.com
# PKS_CLI_PASSWORD=<CHANGE_ME>                            // i.e. 65b6f26c-7e27-4f74-aaf7-7e6d1a3f4450

# (2) in your terminal: source .env

# (3) execute this script: 

# CLUSTER_NAME=<CHANGE_ME> CLUSTER_PLAN=<CHANGE_ME>  GCP_REGION=<CHANGE_ME> source create-gcp-pks-cluster.sh

# sample 
# GCP_REGION=us-east1
# CLUSTER_NAME=mycluster
# CLUSTER_PLAN=small    // i.e. small, medium, large

### The following instruction shows how to create a cluster named "${CLUSTER_NAME}"

# Log into PKS
pks login -k -a ${PKS_API_URL} -u ${PKS_CLI_USERNAME} -p ${PKS_CLI_PASSWORD}

# Create an external load balancer for ${CLUSTER_NAME} cluster
gcloud compute addresses create ${CLUSTER_NAME}-master-api-ip --region ${GCP_REGION}
gcloud compute target-pools create ${CLUSTER_NAME}-master-api --region ${GCP_REGION}

### Create a Cluster
MASTER_EXTERNAL_IP=$(gcloud compute addresses describe ${CLUSTER_NAME}-master-api-ip --region ${GCP_REGION} --format json | jq -r .address)
pks create-cluster ${CLUSTER_NAME} -e ${MASTER_EXTERNAL_IP} -p ${CLUSTER_PLAN}

### Monitor Cluster Creation
watch pks cluster ${CLUSTER_NAME}

### Configure your external load balancer to point to the master vm
CLUSTER_UUID=$(pks clusters | grep ${CLUSTER_NAME} | awk '{print $3}')
MASTER_INSTANCE_NAMES=$(gcloud compute instances list --filter "tags:service-instance-${CLUSTER_UUID}-master" --format "csv[no-heading](selfLink)" | tr '\n' ',' | sed 's/.$//')
gcloud compute target-pools add-instances ${CLUSTER_NAME}-master-api --instances ${MASTER_INSTANCE_NAMES} 
gcloud compute forwarding-rules create ${CLUSTER_NAME}-master-api-8443 --region ${GCP_REGION} \
        --address ${CLUSTER_NAME}-master-api-ip --target-pool ${CLUSTER_NAME}-master-api --ports 8443

### Access your cluster
pks get-credentials ${CLUSTER_NAME}
kubectl cluster-info

