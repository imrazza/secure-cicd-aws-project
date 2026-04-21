# DevSecOps CI/CD Pipeline on AWS

A CI/CD pipeline that automatically scans and deploys AWS infrastructure on every GitHub push.

---

## Tools Used
- **Jenkins** - CI/CD pipeline
- **Trivy** - Security scanning
- **Terraform** - Infrastructure as Code
- **AWS S3 + KMS** - Cloud storage with encryption
- **GitHub Webhooks** - Auto trigger pipeline on push
- **ngrok** - Expose Jenkins to GitHub

---

## Pipeline Flow

```
GitHub Push → Jenkins → Trivy Scan → Terraform Init → Terraform Plan → Terraform Apply → AWS
```

---

## Project Files

```
├── Jenkinsfile   # Pipeline stages
├── main.tf       # AWS infrastructure code
└── README.md
```

---

## How to Run

1. Clone the repo
```bash
git clone https://github.com/imrazza/secure-cicd-aws-project.git
```

2. Add AWS credentials in Jenkins
   - `aws-access-key`
   - `aws-secret-key`

3. Start ngrok and add webhook URL in GitHub
```bash
ngrok http 8080
```

4. Push any change to trigger the pipeline
```bash
git add .
git commit -m "trigger pipeline"
git push origin main
```

---

## AWS Resources Created
- S3 bucket with KMS encryption
- Public access blocked
- Versioning enabled
- Access logging enabled
