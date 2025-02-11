#import <jni.h>
#include <string.h>
#include <stdlib.h>

JNIEXPORT jlong JNICALL Java_Print_malloc
  (JNIEnv *env, jclass _, jlong size) {
  void* ptr = malloc((unsigned long)size);
  return (jlong)ptr;
}
JNIEXPORT void JNICALL Java_Print_free
  (JNIEnv *env, jclass _, jlong ptr){
  free((void*)ptr);
}
JNIEXPORT jchar JNICALL Java_Print_access
  (JNIEnv * env, jclass _, jlong ptr, jlong i){
  char c = ((char*)ptr)[i];
  return (jchar)c;
}
JNIEXPORT void JNICALL Java_Print_assign
  (JNIEnv * env, jclass _, jlong ptr, jlong i, jchar c){
  ((char*)ptr)[i] = (char)c;
}

JNIEXPORT long JNICALL Java_Print_strlen
  (JNIEnv * env, jclass _, jlong ptr){
 return strlen((char*)ptr);
}
