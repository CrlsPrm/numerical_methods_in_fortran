module intengracion_numerica
implicit none
    PRIVATE
    PUBLIC :: m_trapecio, m_simpson_un_tercio
contains
    subroutine m_trapecio(f, xi, xf, n, rsl)

    interface
            real(8) function f(x)
                real(8), intent(in) :: x
            end function f
    end interface

        real(8), intent(in) :: xi, xf
        integer, intent(in) :: n
        real(8), intent(out) :: rsl
        real(8) :: x , h
        integer :: i

        h = abs(xi - xf)/n
        x = xi
        rsl = 0.0d0

        do i = 1, n
            rsl = rsl + h *(f(x + (i - 1)*h) + f(x + (i)*h))/2
        end do

    end subroutine m_trapecio

    subroutine m_simpson_un_tercio(f, xi, xf, n, rsl)
    interface
            real(8) function f(x)
                real(8), intent(in) :: x
            end function f
    end interface

        real(8), intent(in) :: xi, xf
        integer, intent(in) :: n
        real(8), intent(out) :: rsl
        real(8) :: x , h 
        integer :: i

        h = abs(xi - xf)/n
        x = xi
        rsl = 0.0d0

        do i = 1, n-1, 2
            rsl = rsl + (h/3)*(2*f(x + h*(i+1)) + 4*f(x + i*h))
        end do 

        rsl = rsl + (h/3)* (f(xi) - f(xf))

    end subroutine m_simpson_un_tercio


end module intengracion_numerica