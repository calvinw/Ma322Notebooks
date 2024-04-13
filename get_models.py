import requests
import json
import os
from dotenv import load_dotenv
load_dotenv()

def print_models(theList):
  # Extract the IDs from the list
  ids = [item['id'] for item in theList]

  for id in ids:
    print(id)

response = requests.get("https://openrouter.ai/api/v1/models")

# Parse the JSON string into a Python dictionary
data = json.loads(response.text)

# Get the list of models
myList = data['data']

print("Models from openrouter:")
print_models(myList)

print("   ")

api_key=os.environ["TOGETHER_API_KEY"]
headers = {"Authorization": f"Bearer {api_key}"}
response = requests.get("https://api.together.xyz/v1/models", headers=headers)

# Parse the JSON string into a Python list
myList = json.loads(response.text)

print("Models at together ai:")
print_models(myList)
