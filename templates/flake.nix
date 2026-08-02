{
  description = "unbiased's personal Nix templates";

  outputs = { self, ... }: {
    templates = {
      default = {
        path = ./default;
        description = "A default template to build on.";
      };

      c = {
        path = ./c;
        description = "A simple flake for C/C++ projects with batteries included.";
      };

      python = {
        path = ./python;
        description = "A simple Python flake with pip.";
      };

      rust = {
        path = ./rust;
        description = "A simple Rust flake with full LSP support.";
      };

      rust-vulkan = {
        path = ./rust-vulkan;
        description = "A Rust flake with full Vulkan support.";
      };

      defaultTemplate = self.templates.trivial;
    };
  };
}
