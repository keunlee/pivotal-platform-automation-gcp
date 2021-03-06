# Notes/TODOs

- in pipelines, when using `credhub-interpolate-config`, the `INTERPOLATION_PATHS` param must be set to much more finite list. longer lists of paths will make the task time out. 
- in GCP add the following: 
    - load balancer: pks-cf-pks-harbor
    - add additional subnets to the `pks-pcf-network`: 
        - `pks-pas-subnet` 
        - `pks-services-subnet`
        - for the IP Address ranges, increment to the next available value (look at your exisitng subnets) and use that. i.e. 10.0.x.0/24 
- to enable OCID login with google accounts, enable OICD for UAA in the Enterprise PKS Tile, w/in the Ops Manager console. 
- for each OCID member, either create a group or add the following roles to the following user: 

```
uaac member add pks.clusters.admin <user_email_under_allowable_domain>
uaac member add pks.clusters.admin.read <user_email_under_allowable_domain>
uaac member add pks.clusters.manage <user_email_under_allowable_domain>
```

NOTE: you don't need to add a user to all of the roles above. you can restrict as and where needed. 