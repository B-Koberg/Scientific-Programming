program hello
use mpi
implicit none
integer :: ierror, rank, size

call mpi_init(ierror)
call mpi_comm_size(mpi_comm_world, size, ierror)
call mpi_comm_rank(mpi_comm_world, rank, ierror)

write(*,*) "hello world! i am process", rank, "of", size

call mpi_finalize(ierror)
end program hello
