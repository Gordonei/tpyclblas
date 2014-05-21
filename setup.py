import os
from distutils.core import setup
from distutils.extension import Extension
from Cython.Distutils import build_ext
from Cython.Build import cythonize

"""
This file is part of tpyclblas.

tpyclblas is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

tpyclblas is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with Foobar.  If not, see <http://www.gnu.org/licenses/>.
"""

setup(
    name = "tpyclblas",
    description = "Very thin interface to clBLAS library",
    author = "Gordon Inggs",
    author_email = "gordon.inggs@gmail.com",
    
    cmdclass = {'build_ext': build_ext},
    ext_modules = [Extension("tpyclblas", sources=["tpyclblas.pyx"],libraries=["clBLAS"])]

)
