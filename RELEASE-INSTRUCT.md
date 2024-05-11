Here is an instruction about the Velero helm charts release.

It involves Helm charts version control and branch control.

### Helm Charts Version Control

Our Helm charts are released under two scenarios:
- **Velero Release:** When Velero itself is released.

- **Chart Updates:** When there are updates specific to the Helm charts.

The version is defined in [Chart.yaml](charts/velero/Chart.yaml).

#### Guidelines
To comply with the [Semantic Versioning (semver)](https://semver.org/#summary) rule, follow these instructions:
- **Velero Release:**
  - For each Velero minor version release, increase the major version of the Helm charts. For example, if Velero v1.13.0 is released, the Helm charts version becomes 6.0.0; for Velero v1.14.0, it becomes 7.0.0.
  
  - For each Velero patch version release, increase the minor version. For instance, for Velero v1.13.1, the Helm charts version is 6.1.0; for Velero v1.13.2, it's 6.2.0.
- **Helm Charts Updates:**
  - For breaking changes, increase the major version.
  
  - For added functionality, increase the minor version.
  
  - For bug fixes, increase the patch version.

#### Note:
Breaking changes are only allowed for the **latest Helm version**. This restriction ensures that older Helm versions do not have higher major versions than newer ones, preventing helm upgrade issues.

### Branch Control

Follow these rules for branch control:
- Our main branch should always align with the latest Velero major version. For example, if Velero v1.13 is the latest major version, any updates in the main branch should target Velero v1.13.

- Create a new branch prefixed with `velero-helm-charts-v` when Velero releases a new major version. For instance, if the main branch refers to Velero v1.13 and Velero v1.14 is released, name the new branch `velero-helm-charts-v7`. The branch version should match the major version of the Helm charts.

- Submit PRs for updates related to the newest Velero major version to the main branch. For updates related to older Velero major versions, submit PRs to the corresponding Helm charts branch (e.g., PRs for Velero v1.13.4 go to the `velero-helm-charts-v6` branch if it exists).

These guidelines ensure consistency and version control for our Helm charts releases.