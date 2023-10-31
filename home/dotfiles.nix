{
  userfullname,
  useremail,
  userghname,
  ...
}: {
  home = {
    file.".stack/config.yaml".text = ''
      templates:
        params:
          author-name: ${userfullname}
          author-email: ${useremail}
          github-username: ${userghname}
          copyright: 'Copyright: (c) 2023 ${userfullname}'
      nix:
        enable: true
        packages: [zlib]
      system-ghc: true
    '';

    file.".ghci".text = ''
      :set editor ~/.nix-profile/bin/vi
    '';

    file.".haskeline".text = ''
      editMode: Vi
    '';

    file.".inputrc".text = ''
      set editing-mode vi
      set keymap vi
    '';

    file.".face".source = ./face.png;
  };
}
