# policies

`s3-read-policy.example.json` is an **example** least-privilege policy that lets the EC2 instances
read the website files from your bucket. The lab supplies its own `bucket-permissions.json`;
use that file if you have it, or this one as a reference.

* Replace `YOUR-BUCKET-ARN` with the ARN of your bucket, e.g. `arn:aws:s3:::arr-bucket-123456`.
* Create it in **IAM > Policies > Create policy > JSON**, name it `S3-ARR-Policy`.
* Attach it to the EC2 role `S3-ARR-Role`.
