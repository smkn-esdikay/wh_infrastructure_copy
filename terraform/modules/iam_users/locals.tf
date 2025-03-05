locals {
  roles = [
    "Administrator",
    "PinTVRW",
    "PinTVRO",
    "KubernetesAdmin",
    "KubernetesPinTVRW",
    "KubernetesPinTVRO",
  ]

  # a mapping of group => roles
  groups = {
    "Administrators" = [
      "Administrator",
      "KubernetesAdmin",
      "PinTVRW"
    ],
    "KubernetesAdmin" = ["KubernetesAdmin"],
    "PinTVRW" = ["KubernetesPinTVRW", "PinTVRW"],
    "PinTVRO" = ["KubernetesPinTVRO", "PinTVRO"],
  }

  # construct a map of roles to authorized users by looking at each user's groups and their associated roles
  roles_to_authorized_users = {
    for role in local.roles: role => (toset(flatten(
      [for user, usergroups in var.users: toset(flatten(
        [for usergroup in usergroups: [for grouprole in local.groups[usergroup]: user if role == grouprole]
        ]
      ))

      ]
    )))
  }
}

output "roles_to_authorized_users" {
  value = local.roles_to_authorized_users
}
