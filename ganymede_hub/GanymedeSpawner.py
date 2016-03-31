from dockerspawner import SystemUserSpawner
from tornado.web import HTTPError
from .QueryUser import add_user

class GanymedeSpawner(SystemUserSpawner):
    container_image = "lab41/ganymede_nbserver"

    # This function is included due to an issue in dockerspawner/systemuserspawner.py. _env_default refers to a
    # superclass method _env_default whose name was changed to get_env in PR #84.
    def get_env(self):
        # Skip SystemUserSpawner's call to env, which may call _env_default.
        env = super(SystemUserSpawner, self).get_env()
        env.update(dict(
            JPY_USER=self.user.name,
            JPY_COOKIE_NAME=self.user.server.cookie_name,
            JPY_BASE_URL=self.user.server.base_url,
            JPY_HUB_PREFIX=self.hub.server.base_url
        ))

        if self.notebook_dir:
            env['NOTEBOOK_DIR'] = self.notebook_dir

        if self.hub_ip_connect:
           hub_api_url = self._public_hub_api_url()
        else:
           hub_api_url = self.hub.api_url
        env['JPY_HUB_API_URL'] = hub_api_url

        return env

    def _user_id_default(self):
        """
        Query the REST user client running on a local socket.
        """
        response = add_user(self.user.name)
        if "uid" not in response:
            raise HTTPError(403)
        return response['uid']