# [Kube-Score](https://kube-score.com/) Report

Report from Tue Jan  6 12:51:41 CET 2026 on `kubernetes/kustomize/nscale/overlays/azure/cluster`

| Resource Type | Resource Name | Summary |
| - | - | - |
|apps/v1/Deployment: | administrator | Container has the same readiness and liveness probe |
|apps/v1/Deployment: | administrator | (administrator) The container running with a low group ID |
|apps/v1/Deployment: | administrator | (administrator) The pod has a container with a writable root filesystem |
|apps/v1/Deployment: | administrator | Deployment: Deployment few replicas |
|apps/v1/Deployment: | application-layer-web | (application-layer-web) The container running with a low group ID |
|apps/v1/Deployment: | application-layer-web | (application-layer-web) The pod has a container with a writable root filesystem |
|apps/v1/Deployment: | application-layer-web | The deployment is targeted by a HPA, but a static replica count is configured in the DeploymentSpec |
|apps/v1/Deployment: | cmis-connector | (cmis-connector) The container running with a low group ID |
|apps/v1/Deployment: | cmis-connector | (cmis-connector) The pod has a container with a writable root filesystem |
|apps/v1/Deployment: | cmis-connector | Container has the same readiness and liveness probe |
|apps/v1/Deployment: | cmis-connector | Deployment: Deployment few replicas |
|apps/v1/Deployment: | console | (console) The container running with a low group ID |
|apps/v1/Deployment: | console | (console) The pod has a container with a writable root filesystem |
|apps/v1/Deployment: | console | Deployment: Deployment few replicas |
|apps/v1/Deployment: | erp-cmis-connector | (erp-cmis-connector) The container running with a low group ID |
|apps/v1/Deployment: | erp-cmis-connector | (erp-cmis-connector) The pod has a container with a writable root filesystem |
|apps/v1/Deployment: | erp-cmis-connector | Container has the same readiness and liveness probe |
|apps/v1/Deployment: | erp-cmis-connector | Deployment: Deployment few replicas |
|apps/v1/Deployment: | erp-ilm-connector | (erp-ilm-connector) The pod has a container with a writable root filesystem |
|apps/v1/Deployment: | erp-ilm-connector | Container is missing a readinessProbe |
|apps/v1/Deployment: | erp-ilm-connector | (erp-ilm-connector) The container running with a low group ID |
|apps/v1/Deployment: | erp-ilm-connector | Deployment: Deployment few replicas |
|apps/v1/Deployment: | monitoring-console | Container has the same readiness and liveness probe |
|apps/v1/Deployment: | monitoring-console | (monitoring-console-conf) The container running with a low group ID |
|apps/v1/Deployment: | monitoring-console | (monitoring-console) The container running with a low group ID |
|apps/v1/Deployment: | monitoring-console | Deployment: Deployment update strategy |
|apps/v1/Deployment: | monitoring-console | Deployment: Deployment few replicas |
|apps/v1/Deployment: | postgresql | (postgresql) The pod has a container with a writable root filesystem |
|apps/v1/Deployment: | postgresql | (postgresql) The container running with a low group ID |
|apps/v1/Deployment: | postgresql | Deployment: Deployment update strategy |
|apps/v1/Deployment: | postgresql | Deployment: Deployment few replicas |
|apps/v1/Deployment: | process-automation-modeler | Container has the same readiness and liveness probe |
|apps/v1/Deployment: | process-automation-modeler | (process-automation-modeler) The container running with a low group ID |
|apps/v1/Deployment: | process-automation-modeler | (process-automation-modeler) The pod has a container with a writable root filesystem |
|apps/v1/Deployment: | process-automation-modeler | Deployment: Deployment few replicas |
|apps/v1/Deployment: | rendition-server | (rendition-server) The container running with a low group ID |
|apps/v1/Deployment: | rendition-server | (rendition-server) The pod has a container with a writable root filesystem |
|apps/v1/Deployment: | rendition-server | Container has the same readiness and liveness probe |
|apps/v1/Deployment: | rendition-server | The deployment is targeted by a HPA, but a static replica count is configured in the DeploymentSpec |
|apps/v1/Deployment: | webdav-connector | Container is missing a readinessProbe |
|apps/v1/Deployment: | webdav-connector | (webdav-connector) The container running with a low group ID |
|apps/v1/Deployment: | webdav-connector | (webdav-connector) The pod has a container with a writable root filesystem |
|apps/v1/Deployment: | webdav-connector | Deployment: Deployment few replicas |
|apps/v1/Deployment: | xta-connector | (xta-connector) The container running with a low group ID |
|apps/v1/Deployment: | xta-connector | (xta-connector) The pod has a container with a writable root filesystem |
|apps/v1/Deployment: | xta-connector | Container has the same readiness and liveness probe |
|apps/v1/Deployment: | xta-connector | Deployment: Deployment few replicas |
|autoscaling/v2/HorizontalPodAutoscaler: | application-layer | HPA few replicas |
|autoscaling/v2/HorizontalPodAutoscaler: | application-layer-web | HPA few replicas |
|autoscaling/v2/HorizontalPodAutoscaler: | rendition-server | HPA few replicas |
|batch/v1/Job: | application-layer-setup | (application-layer) The pod has a container with a writable root filesystem |
|batch/v1/Job: | application-layer-setup | (wait-for-application-layer) Ephemeral Storage limit is not set |
|batch/v1/Job: | application-layer-setup | (wait-for-application-layer) Ephemeral Storage request is not set |
|batch/v1/Job: | application-layer-setup | (wait-for-application-layer) The container running with a low group ID |
|batch/v1/Job: | application-layer-setup | (application-layer) The container running with a low group ID |
|batch/v1/Job: | application-layer-setup2 | (wait-for-application-layer-and-da) The container running with a low group ID |
|batch/v1/Job: | application-layer-setup2 | (application-layer-setup) The container running with a low group ID |
|batch/v1/Job: | application-layer-setup2 | (application-layer-setup) The pod has a container with a writable root filesystem |
|batch/v1/Job: | monitoring-console-setup | (wait-for-monitoring-console) Ephemeral Storage limit is not set |
|batch/v1/Job: | monitoring-console-setup | (wait-for-monitoring-console) Ephemeral Storage request is not set |
|batch/v1/Job: | monitoring-console-setup | (wait-for-monitoring-console) The container running with a low group ID |
|batch/v1/Job: | monitoring-console-setup | (monitoring-console) The container running with a low group ID |
|batch/v1/Job: | monitoring-console-setup | (monitoring-console) The pod has a container with a writable root filesystem |
|apps/v1/StatefulSet: | application-layer | (wait-for-database) The container running with a low group ID |
|apps/v1/StatefulSet: | application-layer | (application-layer) The container running with a low group ID |
|apps/v1/StatefulSet: | application-layer | (application-layer) The pod has a container with a writable root filesystem |
|apps/v1/StatefulSet: | application-layer | (wait-for-database) Ephemeral Storage limit is not set |
|apps/v1/StatefulSet: | application-layer | (wait-for-database) Ephemeral Storage request is not set |
|apps/v1/StatefulSet: | pipeliner | (wait-for-application-layer) The container running with a low group ID |
|apps/v1/StatefulSet: | pipeliner | (pipeliner) The container running with a low group ID |
|apps/v1/StatefulSet: | pipeliner | (pipeliner) The pod has a container with a writable root filesystem |
|apps/v1/StatefulSet: | pipeliner | (wait-for-application-layer) Ephemeral Storage limit is not set |
|apps/v1/StatefulSet: | pipeliner | (wait-for-application-layer) Ephemeral Storage request is not set |
|apps/v1/StatefulSet: | storage-layer | (storage-layer) The pod has a container with a writable root filesystem |
|apps/v1/StatefulSet: | storage-layer | (storage-layer-conf) The container running with a low group ID |
|apps/v1/StatefulSet: | storage-layer | (storage-layer) The container running with a low group ID |
