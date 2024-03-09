 aws dynamodb create-table \
    --table-name Courses \
    --attribute-definitions AttributeName=Lesson,AttributeType=S AttributeName=LessonTitle,AttributeType=S \
    --key-schema AttributeName=Lesson,KeyType=HASH AttributeName=LessonTitle,KeyType=RANGE \
    --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5 \
    --tags Key=Owner,Value=blueTeam

aws iam create-role --role-name hello-world-role --assume-role-policy-document '{"Version": "2012-10-17","Statement": [{ "Effect": "Allow", "Principal": {"Service": "lambda.amazonaws.com"}, "Action": "sts:AssumeRole"}]}'

aws iam attach-role-policy --role-name hello-world-role --policy-arn arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole

aws lambda create-function \
--function-name basic-lambda \
--runtime python3.8 \
--zip-file fileb://main.zip \
--handler main.handler \
--role arn:aws:iam::767398075255:role/hello-world-role

aws apigateway create-rest-api --name 'ForLambdaAPI' --description 'This is my API'

aws apigateway get-resources --rest-api-id l6kc98o8wc

aws apigateway create-resource --rest-api-id l6kc98o8wc \
      --region us-east-1 \
      --parent-id ul3kxwcvma \
      --path-part greeting

aws apigateway put-method --rest-api-id l6kc98o8wc \
       --region us-east-1 \
       --resource-id yzkb0m \
       --http-method GET \
       --authorization-type "NONE" \
       --request-parameters method.request.querystring.greeter=false

aws apigateway put-method-response \
        --region us-east-1 \
        --rest-api-id l6kc98o8wc \
        --resource-id yzkb0m \
        --http-method GET \
        --status-code 200

aws apigateway put-integration \
        --region us-east-1 \
        --rest-api-id l6kc98o8wc \
        --resource-id yzkb0m \
        --http-method GET \
        --type AWS \
        --integration-http-method POST \
        --uri arn:aws:apigateway:us-east-1:lambda:path/2024-03-08/functions/arn:aws:lambda:us-east-1:767398075255:function:basic-lambda \
        --request-templates '{"application/json":"{\"greeter\":\"$input.params('greeter')\"}"}' \
        --credentials arn:aws:iam::767398075255:role/hello-world-role

aws apigateway put-integration-response \
        --region us-east-1 \
        --rest-api-id l6kc98o8wc \
        --resource-id yzkb0m \
        --http-method GET \
        --status-code 200 \
        --selection-pattern ""  

aws apigateway create-deployment --rest-api-id l6kc98o8wc --stage-name test --region us-east-1 

