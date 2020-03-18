# Notes/TODOs

- in pipelines, when using `credhub-interpolate-config`, the `INTERPOLATION_PATHS` param must be set to much more finite list. longer lists of paths will make the task time out. 
- in GCP add the following: 
    - load balancer: pks-cf-pks-harbor
    - add additional subnets to the `pks-pcf-network`: 
        - `pks-pas-subnet` 
        - `pks-services-subnet`
        - for the IP Address ranges, increment to the next available value (look at your exisitng subnets) and use that. i.e. 10.0.x.0/24 