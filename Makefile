monoid:
	nixos-rebuild switch --flake .#monoid

lambda:
	nixos-rebuild switch --flake .#lambda

semigroup:
	nixos-rebuild switch --flake .#semigroup

vector:
	nix build .#darwinConfigurations.vector.system
	./result/sw/bin/darwin-rebuild switch --flake .#vector

up:
	nix flake update

# Update specific input
# usage: make upp i=wallpapers
upp:
	nix flake lock --update-input $(i)

history:
	nix profile history --profile /nix/var/nix/profiles/system

gc:
	# remove all generations older than 7 days
	sudo nix profile wipe-history --profile /nix/var/nix/profiles/system  --older-than 7d

	# garbage collect all unused nix store entries
	sudo nix store gc --debug

fmt:
	# format the nix files in this repo
	nix fmt

.PHONY: clean
clean:
	rm -rf result
