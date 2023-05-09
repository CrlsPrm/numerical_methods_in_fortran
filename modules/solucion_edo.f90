module solucion_edo
    implicit none
    private
    public :: m_euler_ad, m_runge_kutta, m_runge_kutta_4or

contains
    ! Solucion de edo's de primer orden
    subroutine m_runge_kutta(dy, x0, y0, n, x, y)

      interface
        real(8) function dy(x, y)
        real(8), intent(in) :: x, y
        end function dy
      end interface
        
        real(8), intent(in) :: x0, y0, x
        integer, intent(in) :: n
        real(8), intent(out) :: y
        real(8) :: norma, xt, h, k1, k2, k3, k4
        integer :: i
        character(len=25) :: filename

        filename = "data/x_y_y1.dat"

        open(unit=100, file=filename, status="unknown", action="write")

        xt = x0
        y = y0
        norma = abs(x - x0)/n
        h = norma

        do i = 1, n, 1
            xt = xt + h
                k1 = h * dy(xt, y)
                k2 = h * dy(xt + 0.5* h, y + 0.5*k1)
                k3 = h * dy(xt + h*0.5, y + k2 *0.5)
                k4 = h * dy(xt + h, y + k3)
            y = y + (k1 + 2*k2 + 2*k3 + k4)/6
        write(100, *) xt, y
        end do

    end subroutine m_runge_kutta


    ! Solcuion de edo's de segundo orden
    subroutine m_euler_ad(d2y, x0, y0, dy0, n, x, y, y1, y2)

    interface
        real(8) function d2y(x, y, dy)
        real(8), intent(in) :: x, y, dy
        end function d2y
    end interface
        
        real(8), intent(in) :: x0, y0, dy0, x
        integer, intent(in) :: n
        real(8), intent(out) :: y, y1, y2
        real(8) :: norma, xt
        character(len=25) :: filename

        filename = "data/x_y_y1_y2.dat"

        open(unit=110, file=filename, status="unknown", action="write")

        norma =  abs(x - x0)/n
        xt = x0
        y = y0
        y1 = dy0

        do while (abs(xt) <= abs(x))
            xt = xt + norma
            y2 = d2y(xt, y, y1) 
            y = y + norma * y1
            y1 = y1 + norma * y2      
            !write(*,'(A4,ES15.4,1X,A3,ES20.10,1X,A5,ES20.10,1X,A5,ES20.10)')"|x_=",xt,"|y=",y,"|y_1=",y1,"|y_2=",y2  
            write(110, *) xt, y, y1, y2
        end do

    end subroutine m_euler_ad
            
    subroutine m_runge_kutta_4or(d2y, x0, y0, dy0, n, x, y, y1)
    interface
        real(8) function d2y(x, y, dy)
        real(8), intent(in) :: x, y, dy
        end function d2y
    end interface
        
        real(8), intent(in) :: x0, y0, dy0, x
        integer, intent(in) :: n
        real(8), intent(out) :: y, y1
        real(8) :: h, xt, k1, l1, k2, l2, k3, l3, k4, l4
        integer :: i
        character(len=25) :: filename

        filename = "data/rk-x_y_dy.dat"

        open(unit=120, file=filename, status="unknown", action="write")

        h = abs(x - x0)/n
        xt = x0
        y = y0
        y1 = dy0

        do i = 1, n
            xt = xt + h

            k1 = h * y1
            l1 = h * d2y(xt, y, y1)

            k2 = h * (y1 + l1*0.5)
            l2 = h * d2y(xt + h*0.5, y + k1*0.5, y1 + l1*0.5)

            k3 = h * (y1 + l2*0.5)
            l3 = h * d2y(xt + h*0.5, y + k2*0.5, y1 + l2*0.5)

            k4 = h * (y1 + l3)
            l4 = h * d2y(xt + h, y + k3, y1 + l3)

        y = y + (k1 + 2*k2 + 2*k3 + k4)/6
        y1 = y1 + (l1 + 2*l2 + 2*l3 + l4)/6
            
        write(120, *) xt, y, y1

        end do

    end subroutine m_runge_kutta_4or

end module solucion_edo
