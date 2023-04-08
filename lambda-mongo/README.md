# pkg to zip file, then upload to aws lambda, and then add variables about atlas uri
- cd lambda-mongo
- rm -rf aws.zip && zip -r aws.zip *
