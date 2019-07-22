# Assembly-code-search

This was a school project where the objective was to create a program in Assembly language that prompts the user to enter a valid opcode. Upon doing this, and after pressing enter, the program will output the 4 bit binary code associated with that opcode. If the opcode was not valid, the program output an error message. the input is Case Insensitive. The program terminates when the user enters quit and presses enter.

This program utilizes a custom hash map for indirect-addressing of strings. This is not the most space-efficient or file-size efficient approach, however, it allows the computer to perform much of the processing while the user is typing. This way, when the ENTER key is pressed, an address is calculated simply by multiplying the hash value by 2. This memory address holds the address of the desired string. By using this method, the time elapsed between ENTER key-press and console output is minimized.

It is important to note that the hash value includes a tripling of the first character due to some "simple" sums being identical. Also a doubling of the entire hash allows space for a verification value to preceed each entry without overlap.

