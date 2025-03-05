variable repos {
  type = list(string)
  description = "Container repositories to create"
}

variable account_ids {
  type = list(string)
  description = "Accounts which can pull from the repos"
}
