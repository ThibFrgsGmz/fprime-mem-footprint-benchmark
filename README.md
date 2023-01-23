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
| 1    | Default                           | 65b5       | 0c9d         | 018        | 02f8      | 77576     | 56576 |
| 2    | FW_OBJECT_NAMES = 0               | 05fd5      | 0acd         | 018        | 0128      | 77184     | 56576 |
| 3    | FW_OBJECT_REGISTRATION = 0        | 5f35       | 00aad        | 018        | 00120     | 76768     | 56576 |
| 4    | FW_PORT_TRACING = 0               | 5cb5       | 0a8d         | 018        | 000e0     | 71976     | 52480 |
| 5    | FW_ENABLE_TEXT_LOGGING = 0        | 5cb5       | 0a8d         | 018        | 000e0     | 71976     | 52480 |
| 6    | FW_SERIALIZABLE_TO_STRING = 0     | 53f5       | 09b4         | xxx        | xxx       | 66192     | 48384 |
| 2    |                                   | xxxx       | xxxx         | xxx        | xxx       | xxxx      | xxx   |
| 2    |                                   | xxxx       | xxxx         | xxx        | xxx       | xxxx      | xxx   |

