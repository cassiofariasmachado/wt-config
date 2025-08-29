# 👩‍💻 Windows Terminal Configuration

This repository contains the configuration I usually use for Windows Terminal.

## Installation

To install:

1. Clone repo with `git submodules`:

    ```powershell
    git clone --recursive https://github.com/cassiofariasmachado/posh-config.git
    ```

2. Enter the repo folder:

    ```powershell
    cd posh-config
    ```

3. Install the font of your choice (I use `MesloLGL Nerd Font`):

    ```powershell
    .\InstallFont.ps1 -fontPatch Meslo
    ```

4. Install Windows Terminal:

    ```powershell
    .\Install.ps1
    ```

## References

- [Install and get started setting up Windows Terminal](https://learn.microsoft.com/en-us/windows/terminal/install)