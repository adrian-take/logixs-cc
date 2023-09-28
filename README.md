# Logixs CC

Welcome to the beginning of the Logixs CC project.

## Prerequisites

- [Go](https://golang.org/dl/)
- [AWS CLI](https://aws.amazon.com/cli/)
- [Serverless Framework](https://www.serverless.com/)

## Getting Started

1. Clone this repository:

   ```shell
   git clone https://github.com/adrian-take/logixs-cc.git
   ```

2. Build the Go binary:

    ```shell
    GOARCH=amd64 GOOS=linux go build -o main main.go
    ```

3. Deploy the Lambda function using the AWS CLI:

```shell
aws lambda create-function --function-name MyGoLambda \
  --zip-file fileb://./main.zip --handler main \
  --runtime go1.x --role arn:aws:iam::your-account-id:role/your-role-name
```

4. Invoke the Lambda function:

```shell
aws lambda invoke --function-name MyGoLambda output.txt
```

## Customization

* Modify **\`main.go\`** to implement your Lambda function logic.
* Update the **\`serverless.yml\`** for additional AWS Lambda configuration.
* Add environment variables and triggers as needed.

## Deployment

Use a serverless framework like [AWS SAM](https://aws.amazon.com/serverless/sam/) or [Serverless Framework](https://www.serverless.com/) for more advanced deployments and automation.

## License

This project is licensed under the MIT License - see the [LICENSE](https://opensource.org/license/mit/) file for details.

Please make sure to customize it according to your project's specific details, folder structure, and requirements.