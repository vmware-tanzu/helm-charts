# VMware Tanzu Helm Charts

![VMware Tanzu](assets/vmware-tanzu-logo.png)

Add VMware Tanzu repository to Helm repos:

```bash
helm repo add vmware-tanzu https://vmware-tanzu.github.io/helm-charts
```

## Charts

### Velero

To install Velero:

```bash
helm install --namespace <YOUR NAMESPACE> \
--set configuration.provider=<PROVIDER NAME> \
--set-file credentials.secretContents.cloud=<FULL PATH TO FILE> \
--set configuration.backupStorageLocation.name=<PROVIDER NAME> \
--set configuration.backupStorageLocation.bucket=<BUCKET NAME> \
--set configuration.backupStorageLocation.config.region=<REGION> \
--set configuration.volumeSnapshotLocation.name=<PROVIDER NAME> \
--set configuration.volumeSnapshotLocation.config.region=<REGION> \
--set image.repository=velero/velero \
--set image.pullPolicy=IfNotPresent \
--set initContainers[0].name=velero-plugin-for-aws \
--set initContainers[0].image=velero/velero-plugin-for-aws:v1.0.0 \
--set initContainers[0].volumeMounts[0].mountPath=/target \
--set initContainers[0].volumeMounts[0].name=plugins \
vmware-tanzu/velero
```

For more details on installing Velero please see the [chart readme](https://github.com/vmware-tanzu/helm-charts/blob/main/charts/velero/README.md).
