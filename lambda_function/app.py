# lambda_function/app.py

def lambda_handler(event, context):
    """
    A simple AWS Lambda function that returns 'Hello, World!'
    """
    return {
        'statusCode': 200,
        'body': 'Hello, World! This is a Dockerized Lambda function!'
    }
