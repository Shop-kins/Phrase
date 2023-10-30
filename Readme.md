# Phrase Assignment

### Usage

#### Remote state setup

To deploy this system, you require a terraform s3 backend. if you need assistance setting one up you can run `terraform apply` from within `terraform/remote-state`
and it will set up a remote state for you. You may wish to edit `variables.tf` to alter the buckets name

#### Deploying System

To deploy the whole system simply run `terraform apply` from within `terraform/main` if you altered the buckets name in the previous step then you will need to edit the bucket name
in `variables.tf` here.

#### Readying Application Changes For Deploy 

The application is currently stored in `chef/cookbooks/docker/files/default/application` if you wish to deploy changes to this app then you can edit the files in this location
and then run `terraform apply` as described in the "Deploying the System" section. 

#### Deploying the Application (Automated)

any readied updates will be rolled out at **27 Minutes past the hour**. 

#### Deploying the Application (Manual)

If you wish to deploy the updates manually and not wait for the cron, you can perform the following

1) ssh onto the box as an appropriate user (phrase_admin)
2) `sudo su`
3) navigate to `/opt/bin`
4) run `./chef_cron.sh` and this will rollout all updated changes


### Future Work

- Add a database to the existing server
- Not rely on local chef execution (use a chef server or a different tool altogether)
- Deploy docker image to a proper registry instead of using an awkward temporary one
- Use OIDC/Api gateway or other relevant tool for restricting access to endpoints
- Block application shut down if not ready (requires a bit more research)

