{ self, ... }:

{
  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.settings = {
    PasswordAuthentication = false;
  };

  users.users.root.openssh.authorizedKeys.keyFiles = [
    (self + "/authorized_keys")
  ];
}
