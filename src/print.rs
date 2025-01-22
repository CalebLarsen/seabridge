use std::ffi::{c_char, CString};

#[no_mangle]
pub extern "C" fn day_rust_2(so_far: *mut c_char) -> *mut i8 {
    let today: String = "Two borrow checks\n".to_owned();
    let cstr = unsafe { CString::from_raw(so_far) };
    let prev: String = cstr.into_string().unwrap();
    let out = CString::new(format!("{}{}", prev, today)).expect("CString::new failed");
    return out.into_raw();
}
