# This Makefile allows you to build on osx, using homebrew rather than
# MacPorts, for reasons that will be obvious to anybody who uses
# homebrew and has tried to use *both* homebrew and MacPorts on the
# same box before.
#
# Using it is fairly straightforward:
#
# Step 1: install homebrew.
#
# Step 2: Run make
# ```
# make -f osx.mk all
# ```

CC_FILES=$(shell find . -name "*.cc")
HH_FILES=$(shell find . -name "*.hh")

all : build/performous

build/performous: .cmake $(CC_FILES) $(HH_FILES)
	cd build && make

clean:
	rm -rf build

.cmake : .dependencies
	mkdir -p build
	pushd build && cmake \
		-D Crypto_INCLUDE_DIR=/usr/local/Cellar/openssl/1.0.2h_1/include/openssl/ \
		-D Ssl_INCLUDE_DIR=/usr/local/Cellar/openssl/1.0.2h_1/include/openssl/ .. \
		&& popd
	touch $@

run: all
	build/performous

debug: all
	build/performous --log debug

.dependencies: .install-cmake .install-libsdl2 .install-help2man .install-libepoxy .install-cairo .install-librsvg .install-portaudio .install-portmidi .install-opencv .install-dylibbundler .install-libxml++ .install-jsoncpp .install-openssl .install-libressl .install-boost .install-libcurl #.install-cppnetlib
	touch $@

.install-cppnetlib:
	echo $@
	brew install earlye/homebrew-boneyard/cpp-netlib
	touch $@

.install-boost:
	echo $@
	if brew ls --versions boost > /dev/null; then echo "boost is installed" ; else brew install boost; fi
	touch $@

.install-libcurl:
	echo $@
	if brew ls --versions libcurl > /dev/null; then echo "libcurl is installed" ; else brew install curl; fi
	touch $@

.install-libressl:
	echo $@
	brew install libressl
	touch $@

.install-openssl:
	echo $@
	brew install openssl
	touch $@

.install-jsoncpp:
	echo $@
	brew install jsoncpp
	touch $@

.install-libxml++:
	echo $@
	brew install libxml++
	touch $@

.install-cmake:
	echo $@
	brew install cmake
	touch $@

.install-libsdl2 :
	echo $@
	brew install sdl2
	touch $@

.install-help2man:
	echo $@
	brew install help2man
	touch $@

.install-libepoxy:
	echo $@
	brew install libepoxy
	touch $@

.install-cairo:
	echo $@
	brew install cairo
	touch $@

.install-librsvg:
	echo $@
	brew install librsvg
	touch $@

.install-portaudio:
	echo $@
	brew install portaudio
	touch $@

.install-portmidi:
	echo $@
	brew install portmidi
	touch $@

.install-opencv:
	echo $@
	brew tap homebrew/science
	brew install opencv3
	touch $@

.install-dylibbundler:
	echo $@
	brew install dylibbundler
	touch $@
