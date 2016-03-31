from dockerspawner import SystemUserSpawner
from .QueryUser import add_user

class GanymedeSpawner(SystemUserSpawner):
    container_image = "Lab41/ganymede_nbserver"

    def _user_id_default(self):
        """
        Query the REST user client running on a local socket.
        """
        response = add_user(self.user.name)
        return response['uid']