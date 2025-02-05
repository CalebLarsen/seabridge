CFLAGS := $(CFLAGS) -g
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
# Lua
LDFLAGS := $(LDFLAGS) -I/usr/local/include/luajit-2.1 -lluajit-5.1.2 -L/usr/local/lib
# Chapel
CHPL_LIB_PIC = pic
CHPL_RUNTIME_LIB = /opt/homebrew/Cellar/chapel/2.3.0/libexec/lib
CHPL_RUNTIME_INCL = /opt/homebrew/Cellar/chapel/2.3.0/libexec/runtime/include
CHPL_THIRD_PARTY = /opt/homebrew/Cellar/chapel/2.3.0/libexec/third-party
CHPL_HOME = /opt/homebrew/Cellar/chapel/2.3.0/libexec
CHPL_LDFLAGS = -Lchapel-out -lprint_chapel -optc-Wl,-rpath,chapel-out -L$(CHPL_RUNTIME_LIB)/darwin/llvm/arm64/cpu-native/loc-flat/comm-none/tasks-qthreads/tmr-generic/unwind-none/mem-jemalloc/atomics-cstdlib/hwloc-system/re2-bundled/fs-none/lib_pic-none/san-none -lchpl -L$(CHPL_THIRD_PARTY)/qthread/install/darwin-arm64-native-llvm-none-flat-jemalloc-system/lib -optc-Wl,-rpath,$(CHPL_THIRD_PARTY)/qthread/install/darwin-arm64-native-llvm-none-flat-jemalloc-system/lib -lqthread -L/opt/homebrew/Cellar/hwloc/2.11.2/lib -L$(CHPL_THIRD_PARTY)/re2/install/darwin-arm64-native-llvm-none/lib -lre2 -optc-Wl,-rpath,$(CHPL_THIRD_PARTY)/re2/install/darwin-arm64-native-llvm-none/lib -lm -lpthread -L/opt/homebrew/Cellar/gmp/6.3.0/lib -lgmp -L/opt/homebrew/Cellar/hwloc/2.11.2/lib -optc-Wl,-rpath,/opt/homebrew/Cellar/hwloc/2.11.2/lib -lhwloc -L/opt/homebrew/Cellar/jemalloc/5.3.0/lib -optc-Wl,-rpath,/opt/homebrew/Cellar/jemalloc/5.3.0/lib -ljemalloc -L/opt/homebrew/lib
CHPL_CFLAGS = -Ichapel-out -optc-Wno-unused -optc-Wno-uninitialized -optc-Wno-pointer-sign -optc-Wno-incompatible-pointer-types -optc-Wno-tautological-compare -I/opt/homebrew/Cellar/chapel/2.3.0/libexec/modules/internal -I$(CHPL_RUNTIME_INCL)/localeModels/flat -I$(CHPL_RUNTIME_INCL)/localeModels -I$(CHPL_RUNTIME_INCL)/comm/none -I$(CHPL_RUNTIME_INCL)/comm -I$(CHPL_RUNTIME_INCL)/tasks/qthreads -I$(CHPL_RUNTIME_INCL)/. -I$(CHPL_RUNTIME_INCL)/./qio -I$(CHPL_RUNTIME_INCL)/./atomics/cstdlib -I$(CHPL_RUNTIME_INCL)/./mem/jemalloc -I$(CHPL_THIRD_PARTY)/utf8-decoder -I$(CHPL_THIRD_PARTY)/qthread/install/darwin-arm64-native-llvm-none-flat-jemalloc-system/include -optc -Wno-error=unused-variable -I$(CHPL_THIRD_PARTY)/re2/install/darwin-arm64-native-llvm-none/include -I. -I/opt/homebrew/Cellar/gmp/6.3.0/include -I/opt/homebrew/Cellar/hwloc/2.11.2/include -I/opt/homebrew/Cellar/jemalloc/5.3.0/include -I/opt/homebrew/include
CFLAGS := $(CFLAGS) $(CHPL_CFLAGS)
LDFLAGS := $(LDFLAGS) $(CHPL_LDFLAGS)
# Lisp
LDFLAGS := $(LDFLAGS) -lecl -L./lisp-out -lprint_lisp

all: seabridge
	leaks -quiet --atExit -- ./seabridge lisp

seabridge: src/main.c target/debug/libprint_rust.a zig-out/lib/libprint_zig.a hs-out/Print.o go-out/libprint_go.a fortran-out/libprint_fortran.o asm-out/asm_print.o chapel-out/libprint_chapel.so lisp-out/libprint_lisp.a lua-out/print_lua.h
	ghc $(CFLAGS) $(LDFLAGS) --make -no-hs-main -optc-O -g src/main.c hs-out/Print.o fortran-out/libprint_fortran.o asm-out/asm_print.o -o seabridge
	@rm src/main.o

c-out/main.o: src/main.c
	@mkdir -p c-out
	clang $(CFLAGS) -o c-out/main.o -c src/main.c

asm-out/asm_print.o: src/print.s
	@mkdir -p asm-out
	as -g -o asm-out/asm_print.o src/print.s

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

lua-out/print_lua.h: src/print.lua
	@mkdir -p lua-out
	xxd -i src/print.lua > lua-out/print_lua.h

chapel-out/libprint_chapel.so: src/print.chpl
	chpl --library --dynamic --library-dir=chapel-out src/print.chpl -o print_chapel

lisp-out/libprint_lisp.a: src/print.lisp build.lisp
	@mkdir -p lisp-out
	ecl -load build.lisp
	@rm src/print.o

.PHONY: clean
clean:
	rm -f src/main.o
	rm -rf target/
	rm -rf zig-out/
	rm -rf go-out
	rm -rf fortran-out
	rm -rf asm-out
	rm -rf chapel-out
	rm -rf lisp-out
	rm -rf lua-out
	rm *.mod
