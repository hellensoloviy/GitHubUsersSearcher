# GitHubUsersSearcher

Demo app using Combine and GitHub REST API.

# What to look at

This project is a try of REST API from Github. The network layer is build using Combine.

# What can it do?

- Search users on GitHub
<img src="/readme_assets/users_search.png" width="350" />

- Show a specific user' profile with repos and short main profile fields, only public data.
- Search repos for a specific user

<img src="/readme_assets/user_profile.png" width="350" />  <img src="/readme_assets/repos_search.png" width="350" />

- Tell you what is happening, for example, no results found :)

<img src="/readme_assets/no_search_results.png" width="350" />

# Troubleshooting

If you happen to have issue that nothing is loading and only error occurs - it means the limit of request for unathorized apps has been reached.

## What to do from here?
- Access token can be added in headers. See `Endpoint` protocol for headers and update. This way there will be much bigger limit
- Just wait a bit and try again.  

<img src="/readme_assets/error_occured.png" width="350" />
