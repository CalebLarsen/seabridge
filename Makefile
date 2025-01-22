CFLAGS= -g
# CFLAGS= $(CFLAGS) $(shell /opt/homebrew/bin/python3-config --cflags)
# # Python
# LDFLAGS=$(shell /opt/homebrew/bin/python3-config --ldflags --embed)
# Rust
LDFLAGS := $(LDFLAGS) -lprint_rust -L./target/debug
# Zig
LDFLAGS := $(LDFLAGS) -lprint_zig -L./zig-out/lib
# Go
LDFLAGS := $(LDFLAGS) -lprint_go -L./go-out
# Haskell
LDFLAGS := $(LDFLAGS) -I/opt/homebrew/lib/ghc-9.10.1/lib/aarch64-osx-ghc-9.10.1/rts-1.0.2/include
# Fortran
LDFLAGS := $(LDFLAGS) -lgfortran -L/opt/homebrew/lib/gcc/current

all: seabridge
	leaks -quiet --atExit -- ./seabridge fortran
# ./seabridge c
# ./seabridge rust
# ./seabridge zig
# ./seabridge go

# seabridge: c-out/main.o target/debug/libprint_rust.a zig-out/lib/libprint_zig.a src/print.py
seabridge: src/main.c target/debug/libprint_rust.a zig-out/lib/libprint_zig.a hs-out/Print.o go-out/libprint_go.a fortran-out/libprint_fortran.o
	ghc $(LDFLAGS) --make -no-hs-main -optc-O -g src/main.c hs-out/Print.o fortran-out/libprint_fortran.o -o seabridge
# @clang $(LDFLAGS) -o seabridge c-out/main.o

# c-out/main.o: src/main.c src/print.py
c-out/main.o: src/main.c
	@mkdir -p c-out
	clang $(CFLAGS) -o c-out/main.o -c src/main.c

target/debug/libprint_rust.a: src/print.rs
	cargo build

zig-out/lib/libprint_zig.a: src/print.zig
	zig build

hs-out/Print.o: src/print.hs
	ghc -c src/print.hs -outputdir hs-out

go-out/libprint_go.a: src/print.go
	go build -buildmode=c-archive -o ./go-out/libprint_go.a src/print.go

fortran-out/libprint_fortran.o: src/print.f90
	@mkdir -p fortran-out
	gfortran $(CFLAGS) -o fortran-out/libprint_fortran.o -c src/print.f90

.PHONY: clean
clean:
	rm -f src/main.o
	rm -rf target/
	rm -rf zig-out/
	rm -rf go-out
	rm -rf fortran-out
	rm *.mod
