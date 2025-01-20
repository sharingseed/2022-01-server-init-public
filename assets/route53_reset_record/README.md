
```bash
set -e

EC2_INSTANCE_ID="${1:-}"
HOSTED_ZONE_ID="${2:-}"

ROLE_NAME="2025-01-ap-instance-role"
POLICY_NAME="2025-01-ap-instance-role-policy"
INSTANCE_PROFILE_NAME="2025-01-ap-instance-profile"

# 必要な引数のチェック
if [ -z "$EC2_INSTANCE_ID" ]; then
    echo "使用方法: $0 <EC2_INSTANCE_ID> [<HOSTED_ZONE_ID>]"
    exit 1
fi

echo "IAMロールを作成中..."

# 信頼ポリシーの作成
TRUST_POLICY=$(cat << EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
)

# Route 53ポリシーの作成
ROUTE53_POLICY=$(cat << 'EOF'
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "Route53ListHostedZones",
            "Effect": "Allow",
            "Action": [
                "route53:ListHostedZonesByName"
            ],
            "Resource": "*"
        },
        {
            "Sid": "Route53ChangeRecords",
            "Effect": "Allow",
            "Action": [
                "route53:ChangeResourceRecordSets"
            ],
            "Resource": "arn:aws:route53:::hostedzone/${HOSTED_ZONE_ID:-*}"
        }
    ]
}
EOF
)

# IAMロールの作成
aws iam create-role \
    --role-name "$ROLE_NAME" \
    --assume-role-policy-document "$TRUST_POLICY" \
    --output text

echo "Route 53ポリシーをアタッチ中..."

# インラインポリシーの追加
aws iam put-role-policy \
    --role-name "$ROLE_NAME" \
    --policy-name "$POLICY_NAME" \
    --policy-document "$ROUTE53_POLICY"

echo "インスタンスプロファイルを作成中..."

# インスタンスプロファイルの作成
aws iam create-instance-profile \
    --instance-profile-name "$INSTANCE_PROFILE_NAME"

# インスタンスプロファイルにロールを追加
aws iam add-role-to-instance-profile \
    --instance-profile-name "$INSTANCE_PROFILE_NAME" \
    --role-name "$ROLE_NAME"

# プロファイルがIAMに完全に伝播されるまで待機
echo "プロファイルの伝播を待機中..."
sleep 10

echo "EC2インスタンスにプロファイルをアタッチ中..."

# EC2インスタンスにプロファイルをアタッチ
aws ec2 associate-iam-instance-profile \
    --instance-id "$EC2_INSTANCE_ID" \
    --iam-instance-profile Name="$INSTANCE_PROFILE_NAME"
```
