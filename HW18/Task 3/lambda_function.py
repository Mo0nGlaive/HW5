import os
import boto3
from botocore.exceptions import ClientError

ec2 = boto3.client("ec2")

TAG_KEY = os.environ.get("TAG_KEY", "AutoStop")
TAG_VALUE = os.environ.get("TAG_VALUE", "true")


def lambda_handler(event, context):
    filters = [
        {
            "Name": "instance-state-name",
            "Values": ["running"]
        },
        {
            "Name": f"tag:{TAG_KEY}",
            "Values": [TAG_VALUE]
        }
    ]

    paginator = ec2.get_paginator("describe_instances")

    instance_ids = []

    for page in paginator.paginate(Filters=filters):
        for reservation in page.get("Reservations", []):
            for instance in reservation.get("Instances", []):
                instance_ids.append(instance["InstanceId"])

    if not instance_ids:
        print(
            f"No running EC2 instances found with "
            f"tag {TAG_KEY}={TAG_VALUE}"
        )

        return {
            "statusCode": 200,
            "body": "No matching running instances found.",
            "stopped_instances": []
        }

    print(f"Instances to stop: {instance_ids}")

    try:
        response = ec2.stop_instances(
            InstanceIds=instance_ids
        )

        stopped_instances = [
            {
                "instance_id": item["InstanceId"],
                "previous_state": item["PreviousState"]["Name"],
                "current_state": item["CurrentState"]["Name"]
            }
            for item in response.get("StoppingInstances", [])
        ]

        print(f"Stop request submitted: {stopped_instances}")

        return {
            "statusCode": 200,
            "body": "Stop requests submitted successfully.",
            "stopped_instances": stopped_instances
        }

    except ClientError as error:
        print(f"Failed to stop instances: {error}")
        raise