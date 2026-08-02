{
  description = "unbiased's personal Nix templates";

  outputs = { self, ... }: {
    templates = {
      trivial = {
        path = ./default;
        description = "A default template to build on.";
      };

      python-script = {
        path = ./c;
        description = "A simple flake for C/C++ projects with batteries included.";
      };

      python-package = {
        path = ./python;
        description = "A simple Python flake with pip.";
      };

      haskell-simple-app = {
        path = ./rust;
        description = "A simple Rust flake with full LSP support.";
      };

      haskell-tinker-shell = {
        path = ./rust-vulkan;
        description = "A Rust flake with full Vulkan support.";
      };

      defaultTemplate = self.templates.trivial;
    };
  };
}
