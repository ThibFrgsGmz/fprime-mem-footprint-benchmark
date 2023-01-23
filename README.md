# fprime-mem-footprint-benchmark
FPrime memory footprint benchmark


| ELF Header  | |
|-------------|-------------------------------|
| Class       | ELF64 |
| Data        | 2's complement, little endian |
| OS/ABI      |  UNIX - System V |
| ABI Version |  0 |
| Machine     |  Advanced Micro Devices X86-64 |


| Step | Description                       | Size .text | Size .rodata | Size .data | Size .bss | Size elf | Size bin |
|------|-----------------------------------|------------|--------------|------------|-----------|----------|----------|
| 1    | Default                           | 26 Kb      | 3.2 Kb       | 24 bits    | 760 bits  | 488 Kb   | 353 Kb   |
| 2    | FW_OBJECT_NAMES = 0               | 24.5 Kb    | 2.7 Kb       | 24 bits    | 296 bits  | 487 Kb   | 353 Kb   |
| 3    | FW_OBJECT_REGISTRATION = 0        | 24.3 Kb    | 2.7 Kb       | 24 bits    | 288 bits  | 485 Kb   | 353 Kb   |
| 4    | FW_PORT_TRACING = 0               | 23.7 Kb    | 2.7 Kb       | 24 bits    | 224 bits  | 465 Kb   | 337 Kb   |
| 5    | FW_ENABLE_TEXT_LOGGING = 0        | 23.7 Kb    | 2.7 Kb       | 24 bits    | 224 bits  | 465 Kb   | 337 Kb   |
| 6    | FW_SERIALIZABLE_TO_STRING = 0     | 21.5 Kb    | 2.4 Kb       | 24 bits    | 224 bits  | 412 Kb   | 295 Kb   |
| 7    | FW_PORT_SERIALIZATION = 0         | 10.2 Kb    | 2.1 Kb       | 24 bits    | 216 bits  | 276 Kb   | 204 Kb   |

