import requests
import os


# Replace with your details
repo_owner = 'sagar349'
repo_name = 'Git'

# GitHub API URL to fetch PRs
url = f'https://api.github.com/repos/sagar349/Git/pulls'

api_token = os.getenv('API_TOKEN')

# Headers with your personal GitHub token
headers = {'Authorization': f'api_token {api_token}'}

# Send GET request to fetch PR information
response = requests.get(url, headers=headers)

# Check the response and print PR details
if response.status_code == 200:
    pr_info = response.json()
    for pr in pr_info:
        print(f"PR Title: {pr['title']}")
        print(f"PR Number: {pr['number']}")
        print(f"PR State: {pr['state']}")
        print(f"PR Created At: {pr['created_at']}")
        print(f"PR URL: {pr['html_url']}")
        print('-' * 50)
else:
    print(f"Failed to fetch pull requests: {response.status_code}")
    print(response.json())