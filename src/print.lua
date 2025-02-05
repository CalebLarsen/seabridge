local ffi = require("ffi")
ffi.cdef[[
  void* malloc(size_t);
  void free(void*);
  size_t strlen(const char*);
  int printf(const char* fmt, ...);
]]
function day_lua_8(so_far)
  local today = "Eight embedded scripts\n"
  local all = ffi.string(so_far) .. today
  out = ffi.C.malloc(#all+1)
  ffi.fill(out, #all+1, 0)
  ffi.copy(out, all, #all)
  ffi.C.free(so_far)
  local joe = ffi.cast("intptr_t", out)
  return tonumber(joe)
end
