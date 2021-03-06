# Red Hat HelloWorld MSA (Microservice Architecture)

The [Red Hat HelloWorld MSA](https://github.com/redhat-helloworld-msa/helloworld-msa) combines a variety of technologies, such as Node, JEE, Spring Boot and Hystrix into a microservice architecture that emits "Hello World" in different languages. This application is commonly used by Red Hat consultants to demonstrate microservice deployments on OpenShift.

Here's how to deploy this application on our [OpenShift demo environment](https://github.com/dynatrace-innovationlab/openshift-demo-environment).

## 1. Log into OpenShift

![OpenShift Web UI: Login](https://github.com/dynatrace-innovationlab/openshift-demo-environment/raw/images/openshift-web-ui-login.png)

Where username and password are 'developer' and 'developer', respectively.

## 2. Select the "helloworld-msa" project

![OpenShift Web UI: Select Project](https://github.com/dynatrace-innovationlab/openshift-demo-environment/raw/images/openshift-web-ui-helloworld-msa-1.png)

## 3. Add to the "helloworld-msa" project

![OpenShift Web UI: Add to Project](https://github.com/dynatrace-innovationlab/openshift-demo-environment/raw/images/openshift-web-ui-helloworld-msa-2.png)

## 4. Select the "helloworld-msa" template from the catalog

![OpenShift Web UI: Select Template](https://github.com/dynatrace-innovationlab/openshift-demo-environment/raw/images/openshift-web-ui-helloworld-msa-3.png)

## 5. Create the "helloworld-msa" application inside your project

![OpenShift Web UI: Create Application](https://github.com/dynatrace-innovationlab/openshift-demo-environment/raw/images/openshift-web-ui-helloworld-msa-4.png)

## 6. Verify that the "helloworld-msa" application has been created

![OpenShift Web UI: Validate Creation](https://github.com/dynatrace-innovationlab/openshift-demo-environment/raw/images/openshift-web-ui-helloworld-msa-5.png)

![OpenShift Web UI: Validate Deployment](https://github.com/dynatrace-innovationlab/openshift-demo-environment/raw/images/openshift-web-ui-helloworld-msa-6.png)

![OpenShift Web UI: Validate Application](https://github.com/dynatrace-innovationlab/openshift-demo-environment/raw/images/openshift-web-ui-helloworld-msa-7.png)

![OpenShift Web UI: Validate Application](https://github.com/dynatrace-innovationlab/openshift-demo-environment/raw/images/openshift-web-ui-helloworld-msa-8.png)

![OpenShift Web UI: Validate Application](https://github.com/dynatrace-innovationlab/openshift-demo-environment/raw/images/openshift-web-ui-helloworld-msa-9.png)

![OpenShift Web UI: Validate Application](https://github.com/dynatrace-innovationlab/openshift-demo-environment/raw/images/openshift-web-ui-helloworld-msa-10.png)

![OpenShift Web UI: Validate Application](https://github.com/dynatrace-innovationlab/openshift-demo-environment/raw/images/openshift-web-ui-helloworld-msa-11.png)

![OpenShift Web UI: Validate Application](https://github.com/dynatrace-innovationlab/openshift-demo-environment/raw/images/openshift-web-ui-helloworld-msa-12.png)

You can now access the application via the exposed frontend's route `http://frontend-helloworld-msa.1.2.3.4.xip.io/`, where `1.2.3.4` refers to your cluster's (actually the cluster master's) IP address.

## Manual Deployments

Here's how to deploy the application on any OpenShift cluster. In the following examples, `OS_MASTER_IP` refers to the IP of your OpenShift cluster's master node, assuming `1.2.3.4`. Once deployed, you can access the everest application via the exposed route `http://frontend-helloworld-msa.1.2.3.4.xip.io/`.

### Linux / MacOS

```
export OS_MASTER_IP=1.2.3.4
export OS_PROJECT=helloworld-msa

oc login https://${OS_MASTER_IP}:8443 -u developer -p developer --insecure-skip-tls-verify

oc new-project ${OS_PROJECT}
oc policy add-role-to-user admin system:serviceaccount:${OS_PROJECT}:turbine
oc process -f ${OS_PROJECT}.yml -v OS_MASTER_IP=${OS_MASTER_IP} -v OS_PROJECT=${OS_PROJECT} | oc apply -f -
```

### Windows

```
@echo off
set OS_MASTER_IP=1.2.3.4
set OS_PROJECT=helloworld-msa
 
oc login https://%OS_MASTER_IP%:8443 -u developer -p developer --insecure-skip-tls-verify
 
oc new-project %OS_PROJECT%
oc policy add-role-to-user admin system:serviceaccount:%OS_PROJECT%:turbine
oc process -f %OS_PROJECT%.yml -v OS_MASTER_IP=%OS_MASTER_IP% -v OS_PROJECT=%OS_PROJECT% > %OS_PROJECT%.processed.yml
oc apply -f %OS_PROJECT%.processed.yml
```
