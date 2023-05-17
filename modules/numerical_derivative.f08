
module numerical_derivative
    implicit none
    private
    public :: forward_difference, backward_difference, centered_difference, func_type, func_wrapper

    abstract interface
        real(8) function func_type(x)
            real(8), intent(in) :: x
        end function func_type
    end interface

    type func_wrapper
        procedure(func_type), pointer, nopass :: f
    end type func_wrapper

contains

    subroutine forward_difference(f_wrap, x, h, df)
        type(func_wrapper), intent(in) :: f_wrap
        real(8), intent(in) :: x, h
        real(8), intent(out) :: df
        df = (f_wrap%f(x + h) - f_wrap%f(x)) / h
    end subroutine forward_difference

    subroutine backward_difference(f_wrap, x, h, df)
        type(func_wrapper), intent(in) :: f_wrap
        real(8), intent(in) :: x, h
        real(8), intent(out) :: df
        df = (f_wrap%f(x) - f_wrap%f(x - h)) / h
    end subroutine backward_difference

    subroutine centered_difference(f_wrap, x, h, df)
        type(func_wrapper), intent(in) :: f_wrap
        real(8), intent(in) :: x, h
        real(8), intent(out) :: df
        df = (f_wrap%f(x + h) - f_wrap%f(x - h)) / (2 * h)
    end subroutine centered_difference

end module numerical_derivative

