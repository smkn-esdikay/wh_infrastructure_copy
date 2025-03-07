# attached to roles, allows role to be assumed by groups
# within this account
data "aws_iam_policy_document" "is_assumable" {
  statement {
    actions = [
      "sts:AssumeRole"
    ]
    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
      ]
    }
  }
}

resource "aws_iam_policy" "self_managa_mfa" {
  name        = "SelfManageMFA"
  description = ""
  policy      = <<-EOF
  {
      "Version": "2012-10-17",
      "Statement": [
          {
              "Sid": "AllowViewAccountInfo",
              "Effect": "Allow",
              "Action": [
                  "iam:GetAccountPasswordPolicy",
                  "iam:GetAccountSummary",
                  "iam:ListVirtualMFADevices",
                  "iam:ListUsers"
              ],
              "Resource": "*"
          },
          {
              "Sid": "AllowManageOwnPasswords",
              "Effect": "Allow",
              "Action": [
                  "iam:ChangePassword",
                  "iam:GetUser",
                  "iam:CreateLoginProfile",
                  "iam:DeleteLoginProfile",
                  "iam:GetLoginProfile",
                  "iam:UpdateLoginProfile"
              ],
              "Resource": "arn:aws:iam::*:user/$${aws:username}"
          },
          {
              "Sid": "AllowManageOwnAccessKeys",
              "Effect": "Allow",
              "Action": [
                  "iam:CreateAccessKey",
                  "iam:DeleteAccessKey",
                  "iam:ListAccessKeys",
                  "iam:UpdateAccessKey"
              ],
              "Resource": "arn:aws:iam::*:user/$${aws:username}"
          },
          {
              "Sid": "AllowManageOwnSigningCertificates",
              "Effect": "Allow",
              "Action": [
                  "iam:DeleteSigningCertificate",
                  "iam:ListSigningCertificates",
                  "iam:UpdateSigningCertificate",
                  "iam:UploadSigningCertificate"
              ],
              "Resource": "arn:aws:iam::*:user/$${aws:username}"
          },
          {
              "Sid": "AllowManageOwnSSHPublicKeys",
              "Effect": "Allow",
              "Action": [
                  "iam:DeleteSSHPublicKey",
                  "iam:GetSSHPublicKey",
                  "iam:ListSSHPublicKeys",
                  "iam:UpdateSSHPublicKey",
                  "iam:UploadSSHPublicKey"
              ],
              "Resource": "arn:aws:iam::*:user/$${aws:username}"
          },
          {
              "Sid": "AllowManageOwnGitCredentials",
              "Effect": "Allow",
              "Action": [
                  "iam:CreateServiceSpecificCredential",
                  "iam:DeleteServiceSpecificCredential",
                  "iam:ListServiceSpecificCredentials",
                  "iam:ResetServiceSpecificCredential",
                  "iam:UpdateServiceSpecificCredential"
              ],
              "Resource": "arn:aws:iam::*:user/$${aws:username}"
          },
          {
              "Sid": "AllowManageOwnVirtualMFADevice",
              "Effect": "Allow",
              "Action": [
                  "iam:CreateVirtualMFADevice",
                  "iam:DeleteVirtualMFADevice"
              ],
              "Resource": "arn:aws:iam::*:mfa/$${aws:username}"
          },
          {
              "Sid": "AllowManageOwnUserMFA",
              "Effect": "Allow",
              "Action": [
                  "iam:DeactivateMFADevice",
                  "iam:EnableMFADevice",
                  "iam:ListMFADevices",
                  "iam:ResyncMFADevice"
              ],
              "Resource": "arn:aws:iam::*:user/$${aws:username}"
          },
          {
              "Sid": "DenyAllExceptListedIfNoMFA",
              "Effect": "Deny",
              "NotAction": [
                  "iam:CreateVirtualMFADevice",
                  "iam:EnableMFADevice",
                  "iam:GetUser",
                  "iam:ListMFADevices",
                  "iam:ListVirtualMFADevices",
                  "iam:ResyncMFADevice",
                  "sts:GetSessionToken",
                  "sts:AssumeRole",
                  "iam:ListUsers",
                  "iam:CreateLoginProfile",
                  "iam:GetAccountPasswordPolicy",
                  "iam:ChangePassword",
                  "eks:*"
              ],
              "Resource": "*",
              "Condition": {
                  "Bool": {
                      "aws:MultiFactorAuthPresent": "false"
                  }
              }
          }
      ]
  }
EOF
}
