from tornado.web import HTTPError
from .QueryUser import add_user
from .SystemUserSpawner import SystemUserSpawner

class GanymedeSpawner(SystemUserSpawner):
    container_image = "lab41/ganymede_nbserver"

    def _user_id_default(self):
        """
        Query the REST user client running on a local socket.
        """
        response = add_user(self.user.name)
        if "uid" not in response:
            raise HTTPError(403)
        return response['uid']