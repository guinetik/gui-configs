#!/usr/bin/env bash
echo -e "$(tput setaf 6)\u2699 Installing rust...$(tput sgr 0)"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh