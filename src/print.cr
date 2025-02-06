fun init = crystal_init : Void
  GC.init

  LibCrystalMain.__crystal_main(0, Pointer(Pointer(UInt8)).null)

end

fun day_crystal(so_far: Pointer(UInt8)): Pointer(UInt8)
  today = "Eleven inherited classes\n"
  other_len = LibC.strlen(so_far)
  my_len = today.size
  ret = LibC.malloc(other_len + my_len + 1).as(Pointer(UInt8))
  i = 0
  loop do
    if i >= other_len
      break
    end
    ret[i] = so_far[i]
    i += 1
  end 
  i = 0
  today.each_byte do |c|
    ret[other_len + i] = c
    i += 1
  end
  ret[other_len + my_len] = 0
  LibC.free(so_far)
  return ret

end
