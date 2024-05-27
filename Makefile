# Variables
LAMBDA_NAME := codeExecutorLambda
ZIP_FILE := function.zip
ROLE_ARN := arn:aws:iam::062634955764:role/lambda-full-access-execution
RUNTIME := nodejs18.x
HANDLER := index.handler
PROFILE := fantasia
REGION := eu-west-2
TIMEOUT := 15 # Increase this to a suitable value (e.g., 15 seconds)
MEMORY_SIZE := 512 # Increase this to a suitable value (e.g., 512 MB)

# Default target
all: deploy

# Install dependencies
install:
	npm install

# Package the Lambda function
package: install
	zip -r $(ZIP_FILE) index.js package.json node_modules

# Create the Lambda function
create: package
	aws lambda create-function \
		--function-name $(LAMBDA_NAME) \
		--zip-file fileb://$(ZIP_FILE) \
		--handler $(HANDLER) \
		--runtime $(RUNTIME) \
		--role $(ROLE_ARN) \
		--profile $(PROFILE) \
		--region $(REGION) \

# Full deploy (create or update)
deploy: create update-config -timeout $(TIMEOUT) --memory-size $(MEMORY_SIZE)

# Update the Lambda function code
update: package
	aws lambda update-function-code \
		--function-name $(LAMBDA_NAME) \
		--zip-file fileb://$(ZIP_FILE) \
		--profile $(PROFILE) \
		--region $(REGION)

# Update the Lambda function configuration
update-config:
	aws lambda update-function-configuration \
		--function-name $(LAMBDA_NAME) \
		--timeout $(TIMEOUT) \
		--memory-size $(MEMORY_SIZE) \
		--profile $(PROFILE) \
		--region $(REGION)

# Invoke the Lambda function
invoke:
	aws lambda invoke \
		--function-name $(LAMBDA_NAME) \
		--profile $(PROFILE) \
		--region $(REGION) \
		output.txt
	cat output.txt

# Clean up the zip file
clean:
	rm -f $(ZIP_FILE) 
