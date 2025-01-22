module print_fortran
    use, intrinsic :: iso_c_binding

    implicit none

    interface
        subroutine c_free(ptr) bind(c, name="free")
            import c_ptr
            type(c_ptr), value :: ptr
        end subroutine c_free

        ! subroutine c_malloc(ptr, size) bind(c, name="malloc")
        !     import c_ptr, c_int
        !     type(c_ptr) :: ptr
        !     integer(c_int) :: size
        ! end subroutine c_malloc
    end interface

    contains

    ! Lovingly yoinked from https://github.com/vmagnin/gtk-fortran/blob/gtk4/src/gtk-sup.f90
    subroutine c_f_string_ptr(c_string, f_string)
        type(c_ptr), intent(in) :: c_string
        character(len=*), intent(out) :: f_string
        character(len=1, kind=c_char), dimension(:), pointer :: p_chars
        integer :: i
        if (.not. c_associated(c_string)) then
            f_string = ' '
        else
            call c_f_pointer(c_string, p_chars, [huge(0)])

            i = 1
            do while (p_chars(i) /= c_null_char .and. i <= len(f_string))
                f_string(i:i) = p_chars(i)
                i = i + 1
            end do

            if (i < len(f_string)) f_string(i:) = ' ' 
        end if
    end subroutine c_f_string_ptr
    
    function day_fortran_6(so_far) bind(C) result(out)
        type(c_ptr), intent(in), value :: so_far
        character(1000), pointer :: fstring
        type(c_ptr) :: out
        allocate(fstring)
        call c_f_string_ptr(so_far, fstring)
        fstring = trim(fstring)//"Six numbers crunching"//NEW_LINE('A')//c_null_char
        call c_free(so_far)
        out = c_loc(fstring)
    end function day_fortran_6
    
end module
