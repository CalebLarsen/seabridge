class Print {
  static {
    System.loadLibrary("print");
  }
  private static native long malloc(long size);
  private static native void free(long ptr);
  private static native char access(long ptr, long i);
  private static native void assign(long ptr, long i, char c);
  private static native long strlen(long ptr);

  public static long day_java(long so_far){
    String today = "Twelve factory factories\n";
    long other_len = strlen(so_far);
    long my_len = today.length();
    long out = malloc(other_len + my_len + 1);
    for (int i = 0; i < other_len; i++){
      assign(out, i, (access(so_far, i)));
    }
    for (int i = 0; i < my_len; i++){
      assign(out, i+other_len, today.charAt(i));
    }
    assign(out, other_len+my_len, (char)0);
    free(so_far);
    return out;
  }

}
