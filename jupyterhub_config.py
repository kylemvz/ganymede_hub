import os

c.JupyterHub.spawner_class = 'ganymede_hub.GanymedeSpawner'
c.JupyterHub.authenticator_class = 'oauthenticator.GitHubOAuthenticator'

c.GitHubOAuthenticator.oauth_callback_url = os.environ['OAUTH_CALLBACK_URL']
c.GitHubOAuthenticator.client_id = os.environ['GITHUB_CLIENT_ID']
c.GitHubOAuthenticator.client_secret = os.environ['GITHUB_CLIENT_SECRET']

c.JupyterHub.hub_ip = os.environ['HUB_IP']

c.DockerSpawner.hub_ip_connect = os.environ['HUB_IP_CONNECT']
c.DockerSpawner.use_internal_ip = (os.environ['USE_INTERNAL_IP'] == "True")