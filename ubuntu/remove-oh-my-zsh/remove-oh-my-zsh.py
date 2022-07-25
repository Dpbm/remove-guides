#!/bin/python3

import os
import sys
import re

USER = os.environ.get("SUDO_USER")
HOME = f'/home/{USER}'
RED = "\033[31m"
ZSHRC = f'{HOME}/.zshrc'


def remove_omz_directory():
    omz_dir = f'{HOME}/.oh-my-zsh'

    try:
        os.system(f'rm -rf {omz_dir}')
    except Exception:
        print(f"\n{RED} Failed on remove .oh-my-zsh directory! \n")


def remove_pre_omz_file():
    pre_omz_file = f'{HOME}/.zshrc.pre-oh-my-zsh'

    try:
        os.system(f'rm -rf {pre_omz_file}')
    except Exception:
        print(f"\n{RED} Failed on remove .zshrc.pre-oh-my-zsh file! \n")


def remove_lines_from_zshrc():
    try:
        lines_list = [line.rstrip() for line in open('oh-my-zsh-template.txt')]
        zshrc_new_file = []

        with open(ZSHRC, 'r') as zshrc_file:
            for line in zshrc_file.readlines():
                actual_line = line.rstrip()

                if(not actual_line in lines_list):
                    zshrc_new_file.append(actual_line + '\n')

        new_file = open(ZSHRC, 'w', encoding='utf-8')
        new_file.writelines(zshrc_new_file)
        new_file.close()

    except Exception:
        print(f"\n{RED} Failed on remove some lines of .zshrc file! \n")


def remove_diferent_lines():
    try:
        pattern = 'ZSH_THEME'
        zshrc_new_file = []

        with open(ZSHRC, 'r') as zshrc_file:
            for line in zshrc_file.readlines():
                actual_line = line.rstrip()

                if(not re.search(pattern, actual_line)):
                    zshrc_new_file.append(actual_line + '\n')

        new_file = open(ZSHRC, 'w', encoding='utf-8')
        new_file.writelines(zshrc_new_file)
        new_file.close()

    except Exception:
        print(f"\n{RED} Failed on remove some lines of .zshrc file! \n")


def main():
    remove_omz_directory()
    remove_pre_omz_file()
    remove_lines_from_zshrc()
    remove_diferent_lines()


if __name__ == '__main__':
    user_type = os.getuid()

    if(user_type != 0):
        print(f"\n{RED} Please Run as Root! \n")
        sys.exit(1)

    main()
