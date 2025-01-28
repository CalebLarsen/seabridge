#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <luajit-2.1/lauxlib.h>
#include <luajit-2.1/lua.h>
#include <luajit-2.1/lualib.h>
#include "../go-out/libprint_go.h"

#include "../hs-out/Print_stub.h"

extern char* day_rust_2(char*);
extern char* day_zig_3(char*);
extern char* day_fortran_6(char*);
extern char* day_asm_7(char*);


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

char* day_lua_8(char* so_far){
    lua_State* L = luaL_newstate();
    luaL_openlibs(L);
    luaL_dostring(L, 
"local ffi = require(\"ffi\")\n"
"ffi.cdef[[\n"
"  void* malloc(size_t);\n" 
"  void free(void*);\n" 
"  size_t strlen(const char*);\n" 
"  int printf(const char* fmt, ...);\n" 
"]]\n"
"function day_lua_8(so_far)\n"
"  local today = \"Eight embedded scripts\\n\"\n"
"  local all = ffi.string(so_far) .. today\n"
"  out = ffi.C.malloc(#all+1)\n"
"  ffi.fill(out, #all+1, 0)\n"
"  ffi.copy(out, all, #all)\n"
"  ffi.C.free(so_far)\n"
 " local joe = ffi.cast(\"intptr_t\", out)\n"
"  return tonumber(joe)\n"
"end\n"
                  );
    lua_getglobal(L, "day_lua_8");
    char* result = NULL;
    if (lua_isfunction(L, -1)){
      lua_pushlightuserdata(L, so_far);
      int status = lua_pcall(L, 1, 1, 0);
      if (status != LUA_OK){
        printf("Lua call error\n");
        printf("Error: %s\n", lua_tostring(L, -1));
      } else {
        if (lua_isnumber(L, -1)){
          double addr = lua_tonumber(L, -1);
          result = (char*)(long long)addr;
        }
      }
    } else {
      printf("Lua function not found\n");
    }
    return result;
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
  else if (strcmp("asm", argv[1]) == 0){
    char* start = strdup("On the seventh day of PL, Turing gave to me:\n");
    char* seven  = day_asm_7(start);
    char* six  = day_fortran_6(seven);
    char* five  = day_haskell_5(six);
    char* four  = day_go_4(five);
    char* three = day_zig_3(four);
    char* two   = day_rust_2(three);
    char* one   = day_c_1(two);
    printf("%s", one);
    free(one);
  }

  else if (strcmp("lua", argv[1]) == 0){
    char* start = strdup("On the eigth day of PL, Turing gave to me:\n");
    char* eight = day_lua_8(start);
    char* seven  = day_asm_7(eight);
    char* six  = day_fortran_6(seven);
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
