# Deploy a Static Website on s3 with a CDN - CloudFront <a id ='top'></a>

<br>
<br>

## Summary

<br>
<br>

## Tech Stack

- AWS S3
- AWS IAM
- AWS CloudFront
- HTML, CSS, JS
- AWS CLI

<br>
<br>
<br>

# Contents

- [Objective](#obj)
- [Steps](#steps)
- [Via Cloud Formation](#0)
- [Via Terraform](#1)
- [Via CLI/Bash Script](#2)
- [Via Console](#3)
- [Resources](#res)
- [go to top](#top)

<br>
<br>

# Objective <a id='obj'></a> ([go to top](#top))

Host a static website on S3 and accessing the cached website pages using CloudFront content delivery network (CDN) service.

<br>
<br>
<br>

# Steps <a id='steps'></a> ([go to top](#top))

- Create a bucket `travel-website-bucket-temikelani`
- Enable `static website hosting` on the Bucket
- Upload the web files to s3
- Create a `Cloud Front Distribution`
- Make the bucket a `Cloud Front Origin Access Identity` for that Distribution
- Create a `bucket Policy` that `grants public read access` to the `CLoud Front Distriubtion only`
- Access the website via the cloud front Distrubution

<br>
<br>
<br>

# Via CLoud Formation <a id='0'></a> ([go to top](#top))

<details>
<summary> Expand to see Details </summary>

- Make sure you are in the root directory of this repo `s3-cFront-static-website`
- Run `aws configure` to set up your CLI
- Deploy the [CloudFormation template](./cloudformation/template.yaml) to AWS and save the outputs asn env variables

  - [`create-stack`](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/cloudformation/create-stack.html)

  ```
  export STACK_NAME=travel-website
  ```

  ```
  aws cloudformation create-stack \
  --stack-name $STACK_NAME \
  --template-body file://cloudformation/template.yaml
  ```

- Describe the stack to get the outputs (Bucket name and url, CDN ID and domain name )

  - [`describe-stacks`](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/cloudformation/describe-stacks.html)

  ```
  aws cloudformation describe-stacks --stack-name $STACK_NAME
  ```

  ```
  aws cloudformation describe-stacks --stack-name $STACK_NAME --query "Stacks[].Outputs"
  ```

  ```
  export BUCKET_NAME=$(aws cloudformation describe-stacks --stack-name $STACK_NAME --query "Stacks[*].Outputs[0].OutputValue" --output text)
  ```

  ```
  export CDN_ID=$(aws cloudformation describe-stacks --stack-name $STACK_NAME --query "Stacks[*].Outputs[1].OutputValue" --output text)
  ```

  ```
  export BUCKET_URL=$(aws cloudformation describe-stacks --stack-name $STACK_NAME --query "Stacks[*].Outputs[2].OutputValue" --output text)
  ```

  ```
  export CDN_DOMAIN=$(aws cloudformation describe-stacks --stack-name $STACK_NAME --query "Stacks[*].Outputs[3].OutputValue" --output text)
  ```

- Upload Files to the bucket

  - [`cp`](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/s3/cp.html)

  ```
  aws s3 cp ./web-files s3://$BUCKET_NAME/ --recursive
  ```

- Access the site via the CloudFront Domain Name.

  ```
  curl $CDN_DOMAIN
  ```

  ```bash
  #on mac
  open "http://$CDN_DOMAIN"
  #on linux
  xdg-open "http://$CDN_DOMAIN"
  ```

- Clean Up & Delete All Resources

  - [Empty S3 Bucket](https://docs.aws.amazon.com/AmazonS3/latest/userguide/empty-bucket.html)
  - [`delete-stack`](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/cloudformation/delete-stack.html)

  ```bash
  #empty s3 bucket
  aws s3 rm s3://$BUCKET_NAME --recursive
  ```

  ```bash
  # delete-stack
  aws cloudformation delete-stack --stack-name $STACK_NAME
  ```

</details>

<br>
<br>
<br>

# Via Terraform <a id='1'></a> ([go to top](#top))

<details>
<summary> Coming Soon </summary>
Coming Soon
</details>

<br>
<br>
<br>

# Via CLI/Bash Script<a id='2'></a> ([go to top](#top))

<details>
<summary> Coming Soon </summary>
Coming Soon
</details>

<br>
<br>
<br>

# Via Console <a id='3'></a> ([go to top](#top))

<details>
<summary> Coming Soon </summary>
Coming Soon
</details>

<br>
<br>
<br>

# Resources <a id='res'></a> ([go to top](#top))

<br>
<br>
<br>
