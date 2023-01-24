# F´ (FPrime) memory footprint benchmark

This project aims to make a brief benchmark of the memory footprint of the F' framework to get an idea of it.

In order to evaluate the memory footprint of F´ we simplified the reference deployment topology "Ref", which we replicated in "App" and then simplified.
The metrics considered relevant to evaluate the minimum size of F´ are:
- the size of the `.text`/`.rodata`/`.data`/`.bss` sections of the binary
- the size of the `ELF`
- the size of the `binary` from the ELF by the command `objcopy -O binary App App.bin`.

| ELF Header  |                                |
|-------------|--------------------------------|
| Class       | ELF64                          |
| Data        | 2's complement, little endian  |
| OS/ABI      |  UNIX - System V               |
| ABI Version |  0                             |
| Machine     |  Advanced Micro Devices X86-64 |

# Customing F´ symbols only

Initially we measured these artifacts only by customizing some symbols dimensioning the compiled code of the framework. Let's say:
- [FW_OBJECT_NAMES](./fprime/docs/UsersGuide/dev/configuring-fprime.md#object-naming),
- [FW_OBJECT_REGISTRATION](./fprime/docs/UsersGuide/dev/configuring-fprime.md#object-registry),
- [FW_PORT_TRACING](./fprime/docs/UsersGuide/dev/configuring-fprime.md#port-tracing#),
- [FW_ENABLE_TEXT_LOGGING](./fprime/docs/UsersGuide/dev/configuring-fprime.md#text-logging),
- [FW_SERIALIZABLE_TO_STRING](./fprime/docs/UsersGuide/dev/configuring-fprime.md#object-to-string),
- [FW_PORT_SERIALIZATION](./fprime/docs/UsersGuide/dev/configuring-fprime.md#port-serialization).

> So notice that we didn't play with the options passed to the compiler or the linker at all. In fact, no options are passed to both, except for warnings to the compiler.

For more information, see the note on the configuration of F´ available in the project documentation: [fprime/docs/UsersGuide/dev/configuring-fprime.md](./fprime/docs/UsersGuide/dev/configuring-fprime.md)

**All measurements were made with `GNU 10.3.0` at commit [7890e7d](https://github.com/nasa/fprime/tree/7890e7d8f7f5af79dd57c1dbd8235fcb6bb975b3) of the project, which is the 4900th commit 😁.**

We proceeded in 7 steps, the step n repeats the same configurations as the previous step n-1 to which we add a delta by deactivating a previously activated symbol.

| Step | Description                       | Size .text | Size .rodata | Size .data | Size .bss | Size elf     | Size bin    |
|------|-----------------------------------|------------|--------------|------------|-----------|--------------|-------------|
| 1    | Default                           | 26 Kb      | 3.2 Kb       | 24 bits    | 760 bits  | 77'576 bits  | 56'576 bits |
| 2    | FW_OBJECT_NAMES = 0               | 24.5 Kb    | 2.7 Kb       | 24 bits    | 296 bits  | 77'184 bits  | 56'576 bits |
| 3    | FW_OBJECT_REGISTRATION = 0        | 24.3 Kb    | 2.7 Kb       | 24 bits    | 288 bits  | 76'768 bits  | 56'576 bits |
| 4    | FW_PORT_TRACING = 0               | 23.7 Kb    | 2.7 Kb       | 24 bits    | 224 bits  | 71'976 bits  | 52'480 bits |
| 5    | FW_ENABLE_TEXT_LOGGING = 0        | 23.7 Kb    | 2.7 Kb       | 24 bits    | 224 bits  | 71'976 bits  | 52'480 bits |
| 6    | FW_SERIALIZABLE_TO_STRING = 0     | 21.5 Kb    | 2.4 Kb       | 24 bits    | 224 bits  | 66'192 bits  | 48'384 bits |
| 7    | FW_PORT_SERIALIZATION = 0         | 10.2 Kb    | 2.1 Kb       | 24 bits    | 216 bits  | 43'752 bits  | 32'000 bits |



# Customizing the toolchain options

Regarding the options passed to the toolchain, i.e. the compiler and the linker, we did not see any real difference compared to the measurements obtained in step 7.
Only the linker option in step 5 subtly reduces the footprint - insignificant. We marked "x" when the value did not change.

| Step | Description                         | Size .text | Size .rodata | Size .data | Size .bss | Size elf     | Size bin    |
|------|-------------------------------------|------------|--------------|------------|-----------|--------------|-------------|
| 1    | Step 7 configuration                | 10.197 Kb  | 2.178 Kb     | 24 bits    | 216 bits  | 43'752 bits  | 32'000 bits |
| 2    | -fno-exceptions -fno-rtti           | x Kb       | x Kb         | x bits     | x bits    | x Kb         | x Kb        |
| 3    | -ffunction-sections -fdata-sections | x Kb       | x Kb         | x bits     | x bits    | x Kb         | x Kb        |
| 4    | -flto                               | x Kb       | x Kb         | x bits     | x bits    | x Kb         | x Kb        |
| 5    | -Wl,--gc-sections                   | 10.133 Kb  | 2.154 Kb     | 16 bits    | x bits    | x Kb         | 31'992 bits |
| 6    | -fno-unroll-loops                   | x Kb       | x Kb         | x bits     | x bits    | x Kb         | x Kb        |
| 7    | -fno-jump-tables                    | x Kb       | x Kb         | x bits     | x bits    | x Kb         | x Kb        |
