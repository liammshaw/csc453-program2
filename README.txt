Program 2 README

Liam Shaw (lmshaw@calpoly.edu)
Briana Kuo (brkuo@calpoly.edu)

This LWP library differs from a real thread management library in the sense
that it has very limited functionality in comparison to a real thread library.
For example, the POSIX thread library provides subroutines which allow signals
to be sent to threads, as well as pushing and pulling handlers to the stack.
This library also includes subroutines to set thread priority and much more.

This LWP library API could be improved by the following:
   - Implement support for thread signaling and handling.
   - Implement support for thread priority.
   - Implement methods for interthread communication.

