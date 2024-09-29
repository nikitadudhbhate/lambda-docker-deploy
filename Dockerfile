# Dockerfile

# Use an official AWS Lambda Python 3.9 image
FROM public.ecr.aws/lambda/python:3.9

# Copy the function code to the Lambda task root
COPY lambda_function/app.py ${LAMBDA_TASK_ROOT}

# Set the entry point for the Lambda function
CMD ["app.lambda_handler"]
