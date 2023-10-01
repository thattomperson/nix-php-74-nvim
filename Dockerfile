FROM nixos/nix

ENV NIX_CONFIG "experimental-features = nix-command flakes"

WORKDIR /app

COPY flake.nix flake.nix

RUN nix flake check

RUN nix develop

ENTRYPOINT = ["nix", "develop", "--command"]

CMD ["nvim"]
