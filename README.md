FlexLib
=======

Build Acorn's FlexLib for use in a cross-compiling environment.


Introduction
------------

FlexLib is a memory heap management tool provided by Acorn Computers for use in RISC OS desktop applications.


Installation
------------

To install and use FlexLib, it will be necessary to have suitable Linux system with a working installation of the [GCCSDK](http://www.riscos.info/index.php/GCCSDK).

To build and install the library, use

	make install

from the root folder of the project, which will compile the code copy the necessary files in to the GCCSDK environment.


Original context
----------------

The FlexLib source can be found as part of the ToolboxLib sources, in the [RISC OS Open Ltd GitLab repository](https://gitlab.riscosopen.org/RiscOS/Sources/Toolbox/ToolboxLib).


Licence
-------

FlexLib is licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License.

You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "**as is**" basis, **without warranties or conditions of any kind**, either express or implied.

See the License for the specific language governing permissions and limitations under the License.
