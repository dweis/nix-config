{
  pkgs,
  pkgs-unstable,
  ...
}: {
  home.packages = with pkgs; [
    # Google cloud
    google-cloud-sdk
    # Knative CLI
    kn
    # Kind (local k8s)
    kind
    # Flyctl
    pkgs-unstable.flyctl
  ];
}
