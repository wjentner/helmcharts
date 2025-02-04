# db-backup-retention


![Version: 0.0.1](https://img.shields.io/badge/Version-0.0.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v0.0.1](https://img.shields.io/badge/AppVersion-v0.0.1-informational?style=flat-square) 

A Helm chart to set up a database backup (including timed retention) using a CronJob.

## Minimal examples

### MariaDB/MySQL

The following example creates an hourly backup of a maria/mysql database system and keeps those backups for 30 days before deleting them.
The backups are created by executing `mysqldump` inside the database pod.
This will create files in your mounted folder similar to:

```shell
my-db-backup-2025-02-04T20:00:01+00:00.sql.gz
my-db-backup-2025-02-04T21:00:01+00:00.sql.gz
```

```yaml
config:
  dbPod: my-mariadb-0
  dbUser:
    value: root
    #secret:
    #  name: my-db-secret
    #  key: my-secret-user-key
  dbPassword:
    # value: keepMeSecret! (not recommended)
    secret:
      name: my-db-secret
      key: MARIADB_ROOT_PASSWORD
  # backup all databases or name them explicitly
  backupDatabases: --all-databases
  # 30 days
  retentionMinutes: 43200
  backupFilePrefix: my-db-backup

persistence:
  enabled: true
  size: 10Gi
  storageClass: my-storage

# cronjob:
#   schedule: 0 * * * *
#   concurrencyPolicy: Forbid
#   failedJobsHistoryLimit: 2
#   successfulJobsHistoryLimit: 1
#   backoffLimit: 2
#   restartPolicy: Never
```



## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| Wolfgang Jentner | <wolfgang.jentner@gmail.com> | <https://wjentner.io> |

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| oci://registry-1.docker.io/bitnamicharts | common | 2.x.x |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| commonAnnotations | object | `{}` | common annotations to add to all resources |
| commonLabels | object | `{}` | common labels to add to all resources |
| config.backupDatabases | string | `"--all-databases"` | the database name to backup or `--all-databases` if mysqldump is used. Will be ignored for pg_dumpall. |
| config.backupExec | string | `"mysqldump"` | the executable to run for backup. Allowed values are: mysqldump, pg_dump, pg_dumpall. |
| config.backupFilePrefix | string | `"db-backup"` | the prefix for the backup file (will produce: db-backup-2025-02-04T20:00:01+00:00.sql.gz) |
| config.backupMountPath | string | `"/backups"` | the path to store the backup file |
| config.dbPassword | object | `{"secret":{"key":"my-secret-password-key","name":"my-db-secret"}}` | the database password to use for backup (either direct value or through secret) |
| config.dbPod | string | `"my-mariadb-0"` | the name of the pod running the database (will be used to run backup command) |
| config.dbUser | object | `{"value":"root"}` | the name of the database user to use for backup (either direct value or through secret) |
| config.dbUser.value | string | `"root"` | the name of the database user to use for backup |
| config.retentionMinutes | int | `43200` | the retention time in minutes for backups (default 43200 minutes = 30 days) |
| cronjob.backoffLimit | int | `2` |  |
| cronjob.concurrencyPolicy | string | `"Forbid"` | cronjob concurrency policy |
| cronjob.failedJobsHistoryLimit | int | `2` |  |
| cronjob.restartPolicy | string | `"Never"` |  |
| cronjob.schedule | string | `"0 * * * *"` | cronjob schedule in cron format (visit https://crontab.guru/ for help with the syntax). Default is every hour. |
| cronjob.successfulJobsHistoryLimit | int | `1` |  |
| fullnameOverride | string | `""` | string to fully override db-backup-rentention.fullname |
| fullnameOverride | string | `""` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"ghcr.io/wjentner/k8s-db-backup-retention"` |  |
| image.tag | string | `""` | Overrides the image tag whose default is the chart appVersion. |
| imagePullSecrets | list | `[]` |  |
| nameOverride | string | `""` |  |
| nameOverride | string | `""` | string to partially override db-backup-rentention.fullname |
| nodeSelector | object | `{}` |  |
| persistence.accessModes | list | `["ReadWriteOnce"]` | primary.persistence.accessModes MariaDB primary persistent volume access Modes |
| persistence.annotations | object | `{}` | primary.persistence.annotations MariaDB primary persistent volume claim annotations |
| persistence.enabled | bool | `true` | persistence.enabled Enable persistence to store backups using a `PersistentVolumeClaim`. If false, use emptyDir - for testing only. |
| persistence.existingClaim | string | `""` | persistence.existingClaim Name of an existing `PersistentVolumeClaim` for  NOTE: When it's set the rest of persistence parameters are ignored |
| persistence.labels | object | `{}` | primary.persistence.labels Labels for the PVC |
| persistence.selector | object | `{}` | primary.persistence.selector Selector to match an existing Persistent Volume selector:   matchLabels:     app: my-app |
| persistence.size | string | `"8Gi"` | primary.persistence.size MariaDB primary persistent volume size |
| persistence.storageClass | string | `""` | persistence.storageClass backups persistent volume storage class If defined, storageClassName: <storageClass> If set to "-", storageClassName: "", which disables dynamic provisioning If undefined (the default) or set to null, no storageClassName spec is   set, choosing the default provisioner.  (gp2 on AWS, standard on   GKE, AWS & OpenStack)  |
| podAnnotations | object | `{}` |  |
| podSecurityContext | object | `{}` |  |
| rbac.create | bool | `true` |  |
| rbac.role.annotations | object | `{}` |  |
| rbac.role.name | string | `""` |  |
| rbac.roleBinding.annotations | object | `{}` |  |
| rbac.roleBinding.name | string | `""` |  |
| resources | object | `{}` |  |
| securityContext | object | `{}` |  |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| tolerations | list | `[]` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
