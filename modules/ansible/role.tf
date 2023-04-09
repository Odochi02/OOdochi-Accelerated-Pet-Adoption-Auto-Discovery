# Create IAM policy with a policy document to allow Ansible Node perform specific actions on AWS account to discover
# instances created by ASG without escalating the Ansible Node priviledges
data "aws_iam_policy_document" "OAPAAD-Ansible-policydoc" {
  statement {
    effect = "Allow"
    actions = [
      "ec2:Describe*",
      "autoscaling:Describe*",
      "ec2:DescribeTags*"
    ]
    resources = ["*"]
  }
}
resource "aws_iam_policy" "OAPAAD-Ansible-policy" {
  name   = "OAPAAD-policy-aws-cli"
  path   = "/"
  policy = data.aws_iam_policy_document.OAPAAD-Ansible-policydoc.json
}

# Create IAM role with a policy document to allow Ansible Node assume role
data "aws_iam_policy_document" "OAPAAD-Ansible-policydoc-role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}
resource "aws_iam_role" "OAPAAD-Ansible-role" {
  name               = "OAPAAD-Ansible-aws-role"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.OAPAAD-Ansible-policydoc-role.json
}

# Attach the IAM policy to the IAM role created
resource "aws_iam_role_policy_attachment" "OAPAAD-policy-role-attach" {
  role       = aws_iam_role.OAPAAD-Ansible-role.name
  policy_arn = aws_iam_policy.OAPAAD-Ansible-policy.arn
}

# Create IAM instance profile to be attached to our Ansible Node
resource "aws_iam_instance_profile" "OAPAAD-Ansible-Node-profile" {
  name = "OAPAAD-Ansible-Node-profile"
  role = aws_iam_role.OAPAAD-Ansible-role.name
}