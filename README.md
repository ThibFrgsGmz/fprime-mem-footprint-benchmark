# F´ (FPrime) memory footprint benchmark

This project aims to make a brief benchmark of the memory footprint of the F' framework to get an idea of it.

In order to evaluate the memory footprint of F´ we simplified the reference deployment topology "Ref", which we replicated in "App" and then simplified.
The metrics considered relevant to evaluate the minimum size of F´ are:
- the size of the `.text`/`.rodata`/`.data`/`.bss` sections of the binary
- the size of the `ELF`
- the size of the `binary` from the ELF by the command `objcopy -O binary App.bin`.

| ELF Header  |                                |
|-------------|--------------------------------|
| Class       | ELF64                          |
| Data        | 2's complement, little endian  |
| OS/ABI      |  UNIX - System V               |
| ABI Version |  0                             |
| Machine     |  Advanced Micro Devices X86-64 |

Initially we measured these artifacts only by customizing some symbols dimensioning the compiled code of the framework. Let's say:
- [FW_OBJECT_NAMES](./fprime/docs/UsersGuide/dev/configuring-fprime.md#object-naming),
- [FW_OBJECT_REGISTRATION](./fprime/docs/UsersGuide/dev/configuring-fprime.md#object-registry),
- [FW_PORT_TRACING](./fprime/docs/UsersGuide/dev/configuring-fprime.md#port-tracing#),
- [FW_ENABLE_TEXT_LOGGING](./fprime/docs/UsersGuide/dev/configuring-fprime.md#text-logging),
- [FW_SERIALIZABLE_TO_STRING](./fprime/docs/UsersGuide/dev/configuring-fprime.md#object-to-string),
- [FW_PORT_SERIALIZATION](./fprime/docs/UsersGuide/dev/configuring-fprime.md#port-serialization).

> So notice that we didn't play with the options passed to the compiler or the linker at all. In fact, no options are passed to both, except for warnings to the compiler.

For more information, see the note on the configuration of F´ available in the project documentation: [fprime/docs/UsersGuide/dev/configuring-fprime.md](./fprime/docs/UsersGuide/dev/configuring-fprime.md)


We proceeded in 7 steps, the step n repeats the same configurations as the previous step n-1 to which we add a delta by deactivating a previously activated symbol.

| Step | Description                       | Size .text | Size .rodata | Size .data | Size .bss | Size elf | Size bin |
|------|-----------------------------------|------------|--------------|------------|-----------|----------|----------|
| 1    | Default                           | 26 Kb      | 3.2 Kb       | 24 bits    | 760 bits  | 488 Kb   | 353 Kb   |
| 2    | FW_OBJECT_NAMES = 0               | 24.5 Kb    | 2.7 Kb       | 24 bits    | 296 bits  | 487 Kb   | 353 Kb   |
| 3    | FW_OBJECT_REGISTRATION = 0        | 24.3 Kb    | 2.7 Kb       | 24 bits    | 288 bits  | 485 Kb   | 353 Kb   |
| 4    | FW_PORT_TRACING = 0               | 23.7 Kb    | 2.7 Kb       | 24 bits    | 224 bits  | 465 Kb   | 337 Kb   |
| 5    | FW_ENABLE_TEXT_LOGGING = 0        | 23.7 Kb    | 2.7 Kb       | 24 bits    | 224 bits  | 465 Kb   | 337 Kb   |
| 6    | FW_SERIALIZABLE_TO_STRING = 0     | 21.5 Kb    | 2.4 Kb       | 24 bits    | 224 bits  | 412 Kb   | 295 Kb   |
| 7    | FW_PORT_SERIALIZATION = 0         | 10.2 Kb    | 2.1 Kb       | 24 bits    | 216 bits  | 276 Kb   | 204 Kb   |

