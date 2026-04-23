program fun
    implicit none

    integer, parameter :: min_value = 0
    integer, parameter :: max_value = 10
    integer, parameter :: runs = 10000

    integer :: i
    integer :: n_values
    integer, allocatable :: counts(:)
    integer, allocatable :: sampled(:)
    real, allocatable :: random_values(:)
    real :: rel_freq
    
    character(len=*), parameter :: output_file = 'tsunami_output.txt'

    n_values = max_value - min_value + 1
    if (n_values <= 0) then
        print *, 'Fehler: max_value muss >= min_value sein.'
        stop 1
    end if

    allocate(counts(min_value:max_value))
    allocate(sampled(runs))
    allocate(random_values(runs))
    counts = 0

    call random_seed()
    call random_number(random_values)

    do concurrent (i = 1:runs)
        sampled(i) = min_value + int(random_values(i) * real(n_values))
        if (sampled(i) > max_value) sampled(i) = max_value
    end do

    do i = 1, runs
        counts(sampled(i)) = counts(sampled(i)) + 1
    end do

    open(unit=10, file=output_file, status='replace', action='write')
    write(10, '(A)') '# value count relative_frequency'

    do i = min_value, max_value
        rel_freq = real(counts(i)) / real(runs)
        write(10, '(I8,1X,I12,1X,F12.8)') i, counts(i), rel_freq
    end do

    close(10)
    print *, 'Ergebnisse geschrieben nach: ', trim(output_file)

    deallocate(counts)
    deallocate(sampled)
    deallocate(random_values)
end program fun