<h1>Kitty: Compiler, Interpreter, Runtime</h1>

<h2>Kitty Modules</h2>

* <b>Kitty Language</b>:
	* Kitty's Language, KittyLang (KL), was designed to be a more perfected version of C including many features from C++.
* <b>Kitty Interpreter</b>:
	* The KL Interpreter's (KLI) sole objective is to convert KL into a byte-code format, KL Byte-Code (KLBC). The KLBC is ran through the KL Virtual Machine (KLVM).
	* The KLVM has a big objective of running software emulation of the KittyArch (KA).
* <b>Kitty Runtime</b>:
	* The Kitty Runtime (KRT) is a CRT developed with the sole purpose of replacing the libc dominance over developing applications for C/++. The KRT was developed with major gains in speed being the purpose.
	* The KRT respects IEEE for certain concepts that are unable to change, such as: universal constants, floating point numbers, and faster CPU calculations.

<i>Now, onto the chapters...</i>🐈‍⬛💨

<h2>KLVM</h2>

<h3>Processor Pipeline</h3>

<p>Every processor that's created with the KLVM has a pipline that goes through the following stages:</p>

* <b>Slice</b>:
  * The processor is given a slice of a program to execute.
* <b>Loading</b>:
  * The processor gets ready to execute the slice by setting the registers and flags.
* <b>Execution</b>:
  * The processor executes the slice.

<h3>Opcode Bit-layout</h3>

<p>Each bit in every byte serves a purpose in the KLVM. A disassembled look at this can be seen below:</p>

|Bit Index|Register Flag |Extended Instruction Flag|Normal                |
|---------|--------------|-------------------------|----------------------|
|8        |Register Flag |Reserved                 |Reserved              |
|7        |32 Bit Mode   |Extended Instruction Flag|Reserved              |
|6        |16 Bit Mode   |Operand 1 Numeric Mode   |Operand 1 Numeric Mode|
|5        |8 Bit Mode    |Operand 2 Numeric Mode   |Operand 2 Numeric Mode|
|4        |Register Index|Instruction Index        |Operand 3 Numeric Mode|
|3        |Register Index|Instruction Index        |Operand 4 Numeric Mode|
|2        |Register Index|Instruction Index        |Operand 5 Numeric Mode|
|1        |Register Index|Instruction Index        |Operand 6 Numeric Mode|

<p>When the Extended Instruction Flag is used, the next byte in its entirety will be used for instruction indices.</p>
