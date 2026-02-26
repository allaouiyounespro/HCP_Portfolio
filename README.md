# Static Portfolio – AWS Infrastructure with Terraform
---
## Project Structure
terraform-portfolio/
├── main.tf          # Terraform & provider configuration
├── variables.tf     # Input variables
├── outputs.tf       # Output values
├── s3.tf            # S3 bucket + policy + index.html upload
├── cloudfront.tf    # CloudFront distribution + OAC
├── cloudwatch.tf    # Alerting
├── acm.tf           # SSL certificate + DNS validation
├── routing.tf       # Hosted zone + DNS records
├── index.html       # website
└── README.md
```


## 🌐 4. Configure your Domain Registrar

After `terraform apply`, retrieve the Route 53 nameservers:

```bash
terraform output route53_nameservers
```

You will get 4 nameservers like:
```
ns-123.awsdns-45.com
ns-678.awsdns-90.net
ns-111.awsdns-22.org
ns-999.awsdns-55.co.uk
```

➡️ **Go to your registrar** (OVH, Gandi, Namecheap…) and replace the existing nameservers with these.

⏱️ DNS propagation: 15 min to 48h depending on your registrar.

---

## ✅ 5. Verify the Deployment

```bash
# CloudFront URL (available immediately)
terraform output cloudfront_url

# Final website URL (after DNS propagation)
terraform output website_url
```

---

