{ pkgs, ... }: 

{
  # Enable virtualbox.
  virtualisation.virtualbox.host = {
    enable = true;
    #enableExtensionPack = true;
  };
  users.extraGroups.vboxusers.members = [ "derrick" ];

  # Enable docker.
  virtualisation.docker.enable = true;

  environment.systemPackages = with pkgs; [
    # ---- Kubernetes / Docker
    docker
    docker-machine
    minikube
    kubectl
    kubernetes-helm
  ];
}
