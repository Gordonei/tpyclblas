=========
tpyclblas
=========
The Thin Python clBLAS wrapper library is an extremely thin and incomplete wrapper around the clBLAS library (https://github.com/clMathLibraries/clBLAS) using cython and pyopencl.

tpyclblas has been tested on AMD CPUs, Nvidia GPUs and Intel CPUs using the respective platforms' SDKs.

I found the excellent gpyfftlib code really helpful (https://github.com/geggo/gpyfft). Look at that if you want to see how to wrap clBLAS properly.

Please feel free to contact me, Gordon Inggs at gordon <dot> inggs <at> gmail <dot> com, if you have any questions or even better, pull requests!
May, 2014

License
-------
tpyclblas is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

tpyclblas is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

Dependencies
------------
* Python 2.7 or greater
* clBLAS (https://github.com/clMathLibraries/clBLAS)
* pyopencl (http://mathema.tician.de/software/pyopencl)
* cython (http://www.cython.org)

Installation
------------
* Clone/Download the repository
* Run "sudo CFLAGS="-I<clBLAS package Installation location>/include -L<clBLAS package Installation location>/lib<64>" python setup.py install" in the directory.
    ** You can omit the sudo part of the command if you have write access to your python libraries directory.
    ** You can also omit the 64 in the library path if you wish to build for 32 bit libraries
* Run "python tpyclblas_test.py" to make sure that the installation has been successful.

Directory Contents
------------------
* README.txt - this file
* setup.py - the necessary build and installation file for making and installing the library.
* tpyclblas.pyx - the primary library. The idea is that this exposes various clBLAS functions to python.
* tpyclblas.pxd - the clBLAS c definitions that are used by the primary library.
* tpyclblas_test.py - test script that runs the equivilent example code to that given in the clBLAS readme (real value, general matrix multiplication)