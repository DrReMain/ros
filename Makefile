.PHONY: c_env rs_env qemu_env init

c_env:
	sudo apt-get update -y && sudo apt-get upgrade -y
	sudo apt-get install -y git build-essential gdb-multiarch qemu-system-misc gcc-riscv64-linux-gnu binutils-riscv64-linux-gnu

rs_env:
	curl https://sh.rustup.rs -sSf | sh
	. /home/codespace/.cargo/env
	rustup install nightly
	rustup default nightly
	rustup target add riscv64gc-unknown-none-elf
	cargo install cargo-binutils
	rustup component add llvm-tools-preview
	rustup component add rust-src

qemu_env:
	sudo apt install -y autoconf automake autotools-dev curl libmpc-dev libmpfr-dev libgmp-dev gawk build-essential bison flex texinfo gperf libtool patchutils bc zlib1g-dev libexpat-dev pkg-config libglib2.0-dev libpixman-1-dev libsdl2-dev libslirp-dev git tmux python3 python3-pip ninja-build

# cd ..
# wget https://download.qemu.org/qemu-7.0.0.tar.xz
# tar xvJf qemu-7.0.0.tar.xz
# cd qemu-7.0.0
# ./configure --target-list=riscv64-softmmu,riscv64-linux-user --enable-sdl --enable-slirp
# make -j$(nproc)
# vim ~/.bashrc
# export PATH=$PATH:/workspaces/qemu-7.0.0/build
# qemu-system-riscv64 --version
# qemu-riscv64 --version

init: c_env rs_env qemu_env
