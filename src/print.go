// package name: print_go
package main

/*
#include <stdlib.h>
*/
import "C"
import (
	"fmt"
	"unsafe"
)

//export day_go_4
func day_go_4(so_far *C.char) *C.char {
	today := "Four err != nils\n"
	out := C.CString(fmt.Sprintf("%s%s", C.GoString(so_far), today))
	C.free(unsafe.Pointer(so_far))
	return out
}

func main() {}
