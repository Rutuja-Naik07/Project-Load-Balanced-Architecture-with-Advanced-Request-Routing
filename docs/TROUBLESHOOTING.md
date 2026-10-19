# Troubleshooting

## Target shows "unhealthy"

| Check | How |
|-------|-----|
| Health check path | The target group must use `/red/index.html` (Red) or `/blue/index.html` (Blue). A typo causes 404 and an unhealthy target. |
| Apache running | Connect to the instance and run `systemctl status httpd`. |
| Files present | `ls /var/www/html/red` (or `blue`) should list `index.html` and the assets. |
| Security group | `WebsiteSG` must allow HTTP 80. |
| Wait | New targets can take a minute or two to pass the health check. |

## ALB returns 502 / 503

A `503` usually means the target group has **no healthy targets**. Fix the health problem above. A `502` means the target closed the connection or sent an invalid response; check that Apache is running.

## Instance shows the default Apache page

The files were not copied from S3. Common reasons:

1. `YOUR-BUCKET-NAME` was not replaced in the user data, or the name has a typo.
2. The `S3-ARR-Role` instance profile was not attached.
3. The policy has the wrong bucket ARN.
4. A file name in the script does not exist in the bucket.

Look at the user data log on the instance:

```bash
sudo cat /var/log/cloud-init-output.log | tail -50
```

Test the permission manually:

```bash
aws s3 ls s3://<your-bucket-name>/
```

If this returns `AccessDenied`, the role or policy is the problem.

## Connection times out

- The security group must allow inbound TCP 80 from `0.0.0.0/0`.
- The instance needs a public IP to be tested directly; the ALB DNS name works regardless.
- Make sure you are using `http://` and not `https://` (the lab only has an HTTP listener).

## Path rules do not work

- The condition must be `/red*` and `/blue*` (with the `*`), otherwise `/red/index.html` will not match.
- Priorities must be unique. Lower numbers are checked first.
- Remember the default action sends anything unmatched to **Blue**, so a wrong path can look like it "works" but show the Blue page.

## Host rules do not match

- The host header must exactly equal the rule value (for example `red.yourdomainname.com`).
- Test without DNS: `curl -H "Host: red.yourdomainname.com" http://<ALB-DNS-name>/`.
- If you delete the path rules but forget to add host rules, everything goes to the default (Blue).

## Useful commands

```bash
# on the instance
systemctl status httpd
sudo tail -n 50 /var/log/httpd/access_log
sudo tail -n 50 /var/log/httpd/error_log
curl -I http://localhost/red/index.html

# from your computer
curl -I http://<ALB-DNS-name>/red
curl -I http://<ALB-DNS-name>/blue
```
