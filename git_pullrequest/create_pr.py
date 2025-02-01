import requests
import os

# Replace with your details
repo_owner = 'sagar349'
repo_name = 'Git'
branch_name = 'master'
base_branch = 'main'  # or the branch you want to merge into
pr_title = 'first-pr'
pr_body = 'Just to check'

# GitHub API URL to create a PR
url = f'https://api.github.com/repos/sagar349/Git/pulls'

token = os.getenv('API_TOKEN')


# Headers with your personal GitHub token
headers = {'Authorization': f'token {token}'}

# PR data
data = {
    'title': pr_title,
    'head': branch_name,  # The branch you are merging from
    'base': base_branch,  # The branch you are merging into
    'body': pr_body       # The PR description
}

# Send the request to create the PR
response = requests.post(url, json=data, headers=headers)

# Check the response
if response.status_code == 201:
    print("Pull request created successfully!")
else:
    print(f"Failed to create pull request: {response.status_code}")
    print(response.json())

