# IAM Policies for each module
locals {
  networking_policies = [
    "ec2:*",
  ]

  ecr_policies = [
    "ecr:*"
  ]

  eks_policies = [
    "dynamodb:*",
    "kms:Create*",
    "kms:Describe*",
    "kms:Enable*",
    "kms:List*",
    "kms:Put*",
    "kms:Update*",
    "kms:Revoke*",
    "kms:Disable*",
    "kms:Get*",
    "kms:Delete*",
    "kms:TagResource",
    "kms:UntagResource",
    "kms:ScheduleKeyDeletion",
    "kms:CancelKeyDeletion",
    "iam:CreateRole",
    "iam:GetRole",
    "iam:TagRole",
    "iam:UpdateAssumeRolePolicy",
    "iam:ListInstanceProfilesForRole",
    "iam:DeleteRole",
    "iam:AttachRolePolicy",
    "iam:ListAttachedRolePolicies",
    "iam:DetachRolePolicy",
    "iam:PassRole",
    "iam:CreatePolicy",
    "iam:GetPolicy",
    "iam:GetPolicyVersion",
    "iam:ListPolicyVersions",
    "iam:DeletePolicy",
    "iam:CreateOpenIDConnectProvider",
    "iam:GetOpenIDConnectProvider",
    "iam:DeleteOpenIDConnectProvider",
    "iam:UpdateOpenIDConnectProviderThumbprint",
    "iam:CreatePolicyVersion",
    "logs:PutRetentionPolicy",
    "logs:CreateLogGroup",
    "logs:DescribeLogGroups",
    "logs:ListTagsLogGroup",
    "logs:DeleteLogGroup",
    "eks:*",
    "iam:DeletePolicyVersion",
    "iam:CreateServiceLinkedRole",
    "acm:RequestCertificate",
    "acm:AddTagsToCertificate",
    "acm:DescribeCertificate",
    "acm:ListTagsForCertificate",
    "acm:DeleteCertificate",
    "acm:ImportCertificate",
  ]

  route53_policies = [
    "route53:CreateHostedZone",
    "route53:GetChange",
    "route53:GetHostedZone",
    "route53:ListResourceRecordSets",
    "route53:ListTagsForResource",
    "route53:DeleteHostedZone",
    "route53:AssociateVPCWithHostedZone",
    "route53:DisassociateVPCFromHostedZone",
    "route53:ListHostedZonesByVPC",
    "route53:CreateVPCAssociationAuthorization",
    "route53:ListVPCAssociationAuthorizations",
    "route53:DeleteVPCAssociationAuthorization",
    "route53:ChangeResourceRecordSets",
  ]

  s3_policies = [
    "s3:*"
  ]

  cloudfront_policies = [
    "cloudfront:*"
  ]

  iam_policies = [
    "iam:*"
  ]
}
