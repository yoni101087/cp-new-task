import os
import requests
import boto3
import json
import time

# Load from environment variables (populated by GitHub Actions or local)
ALB_URL = os.getenv("ALB_URL")
SQS_QUEUE_URL = os.getenv("SQS_QUEUE_URL")
S3_BUCKET_NAME = os.getenv("S3_BUCKET_NAME")
AWS_REGION = os.getenv("AWS_REGION", "us-west-2")
SSM_PARAM_NAME = "token"

ssm = boto3.client("ssm", region_name=AWS_REGION)
s3 = boto3.client("s3", region_name=AWS_REGION)

assert ALB_URL, "Missing ALB_URL"
assert S3_BUCKET_NAME, "Missing S3_BUCKET_NAME"

def get_token_from_ssm():
    print(f"[+] Fetching token from SSM parameter: {SSM_PARAM_NAME}")
    response = ssm.get_parameter(Name=SSM_PARAM_NAME, WithDecryption=True)
    return response["Parameter"]["Value"]

def send_api_request():
    token = get_token_from_ssm()
    payload = {
        "token": token,
        "data": {
            "email_subject": "System Test Subject",
            "email_sender": "system@test.com",
            "email_timestream": str(int(time.time())),
            "email_content": "Test system content"
        }
    }

    print(f"[+] Sending POST request to {ALB_URL}")
    response = requests.post(ALB_URL, json=payload)
    assert response.status_code == 200, f"Unexpected status code: {response.status_code}, Response: {response.text}"
    print("[+] Request accepted")
    return payload["data"]

def wait_for_s3(expected_data, timeout=60):
    print(f"[+] Waiting for S3 upload in bucket: {S3_BUCKET_NAME}")
    start_time = time.time()
    while time.time() - start_time < timeout:
        response = s3.list_objects_v2(Bucket=S3_BUCKET_NAME)
        for obj in response.get("Contents", []):
            key = obj["Key"]
            if obj["LastModified"].timestamp() < start_time - 5:
                continue
            s3_obj = s3.get_object(Bucket=S3_BUCKET_NAME, Key=key)
            content = s3_obj["Body"].read().decode()
            try:
                data = json.loads(content)
                if data == expected_data:
                    print(f"[+] Found matching object in S3: {key}")
                    return
            except json.JSONDecodeError:
                continue
        time.sleep(5)
    raise TimeoutError("Failed to find matching S3 object")

def main():
    print("====== SYSTEM TEST STARTED ======")
    data = send_api_request()
    wait_for_s3(data)
    print("====== SYSTEM TEST PASSED ======")

if __name__ == "__main__":
    main()
