## Break C program

> Grab the files access.c, md5.c and md5.h from the unit website (labs page).
  Compile with `gcc ­oaccess access.c md5.c`
  It asks for a username and 4-digit PIN and prints either “Success” or “Incorrect”.
  From looking over a colleague's shoulder, you know that their username is david (not
  capitalised) and their password is a 4-digit number ending with 8 (you only saw the last
  number of their PIN). You could try 1000 combinations by hand ... or you could write a
  script to do it for you.
  Find the PIN – for example by calling the program in a loop, trying all remaining
  1000 possibilities. Use any language and tools that you like.

`break_access.py` implements this using Python threads to parallelise the execution.