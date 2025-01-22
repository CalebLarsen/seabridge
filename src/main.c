#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "../go-out/libprint_go.h"

#include "../hs-out/Print_stub.h"
// #define PY_SSIZE_T_CLEAN
// #include <Python.h>

extern char* day_rust_2(char*);
extern char* day_zig_3(char*);
extern char* day_fortran_6(char*);


char* day_c_1(char* so_far){
  char* today = "And a null pointer crashing my code\n";
  int other_len = strlen(so_far);
  int my_len = strlen(today);
  char* out = malloc(other_len + my_len + 1);
  memcpy(out, so_far, other_len);
  memcpy(out+other_len, today, my_len);
  out[other_len+my_len] = 0;
  free(so_far);
  return out;
}

int main(int argc, char** argv){
  hs_init(&argc, &argv);
  
  if (argc < 2) {
    printf("[Usage] seabridge LANGUAGE\n");
    // return 1;
  }
  else if (strcmp("c", argv[1]) == 0){
    char* f = strdup("On the first day of PL, Turing gave to me:\n");
    char* o = day_c_1(f);
    printf("%s", o);
    free(o);
  }
  else if (strcmp("rust", argv[1]) == 0){
    char* start = strdup("On the second day of PL, Turing gave to me:\n");
    char* two = day_rust_2(start);
    char* one = day_c_1(two);
    printf("%s", one);
    free(one);
  }
  else if (strcmp("zig", argv[1]) == 0){
    char* start = strdup("On the third day of PL, Turing gave to me:\n");
    char* three = day_zig_3(start);
    char* two   = day_rust_2(three);
    char* one   = day_c_1(two);
    printf("%s", one);
    free(one);
  }
  else if (strcmp("go", argv[1]) == 0){
    char* start = strdup("On the fourth day of PL, Turing gave to me:\n");
    char* four  = day_go_4(start);
    char* three = day_zig_3(four);
    char* two   = day_rust_2(three);
    char* one   = day_c_1(two);
    printf("%s", one);
    free(one);
  }
  else if (strcmp("haskell", argv[1]) == 0){
    char* start = strdup("On the fifth day of PL, Turing gave to me:\n");
    char* five  = day_haskell_5(start);
    char* four  = day_go_4(five);
    char* three = day_zig_3(four);
    char* two   = day_rust_2(three);
    char* one   = day_c_1(two);
    printf("%s", one);
    free(one);
  }
  else if (strcmp("fortran", argv[1]) == 0){
    char* start = strdup("On the sixth day of PL, Turing gave to me:\n");
    char* six  = day_fortran_6(start);
    char* five  = day_haskell_5(six);
    char* four  = day_go_4(five);
    char* three = day_zig_3(four);
    char* two   = day_rust_2(three);
    char* one   = day_c_1(two);
    printf("%s", one);
    free(one);
  }

  hs_exit();
}
