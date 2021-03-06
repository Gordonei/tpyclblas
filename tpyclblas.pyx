"""
tpyclblas.pyx
Extremely thin wrapper around clBLAS for PyOpenCL
Gordon Inggs (gordon <dot> inggs <at> gmail <dot> com)
May 2014

This is the primary library that exposes various clblas functions to Python. It expects the parameters to largely follow the types specified in clBLAS, however using pyopencl objects for the OpenCL constructs (e.g. cl_mem).

Each function has a Python wrapper definition (def <function name>wrapper) as well as cython one (cdef <function name>cwrapper). The Python definition passes through the arguments to the cython definition, which casts them as required by clBLAS. Each function returns a pyopencl Event object, which can then be used in conjunction with various other pyopencl methods. If a non-zero clblas return code is encountered, an exception is raised with a value equal to the value of the clblas status code.

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
#import Exception
import cython,pyopencl
#tpyclblas.pxd contains all of the key defintions from "clblas.h"

ctypedef long int voidptr_t

class clblasException(Exception):
	def __init__(self,value): self.value = value
	def __str__(self): return repr(self.value)

def setupwrapper():
	return setupcwrapper()

cdef setupcwrapper():
	return clblasSetup()

def teardownwrapper():
	teardowncwrapper()

cdef teardowncwrapper():
	clblasTeardown()

def sgemmwrapper(order,transA,transB,M,N,K,alpha,A,offA,lda,B,offB,ldb,beta,C,offC,ldc,numCommandQueues,commandQueues):
	return sgemmcwrapper(order,transA,transB,M,N,K,alpha,A,offA,lda,B,offB,ldb,beta,C,offC,ldc,numCommandQueues,commandQueues)

cdef sgemmcwrapper(order,transA,transB,size_t M,size_t N,size_t K,cl_float alpha,A,size_t offA,size_t lda,B,size_t offB,size_t ldb,cl_float beta,C,size_t offC,size_t ldc,cl_uint numCommandQueues,commandQueues):
	cdef clblasOrder blasorder = clblasRowMajor

	cdef clblasTranspose transposeA = clblasNoTrans
	if(transA): transposeA = clblasTrans

	cdef clblasTranspose transposeB = clblasNoTrans
	if(transB): transposeB = clblasTrans

	cdef cl_mem memA = <cl_mem><voidptr_t>A.int_ptr
	cdef cl_mem memB = <cl_mem><voidptr_t>B.int_ptr
	cdef cl_mem memC = <cl_mem><voidptr_t>C.int_ptr

	cdef cl_command_queue queue = <cl_command_queue><voidptr_t>commandQueues.int_ptr

	cdef cl_event kernel_event

	cdef clblasStatus result = clblasSgemm(blasorder,transposeA,transposeB,M,N,K,alpha,memA,offA,lda,memB,offB,ldb,beta,memC,offC,ldc,numCommandQueues,&queue,0,NULL,&kernel_event)
	if(result): raise clblasException(result)		

	return pyopencl.Event.from_int_ptr(<long>kernel_event)

def sgemvwrapper(order,transA,M,N,alpha,A,offA,lda,x,offx,incx,beta,y,offy,incy,numCommandQueues,commandQueues):
	return sgemvcwrapper(order,transA,M,N,alpha,A,offA,lda,x,offx,incx,beta,y,offy,incy,numCommandQueues,commandQueues)

cdef sgemvcwrapper(order,transA,size_t M,size_t N,cl_float alpha,A,size_t offA,size_t lda,x,size_t offx,int incx,cl_float beta,y,size_t offy,int incy,cl_uint numCommandQueues,commandQueues):
	cdef clblasOrder blasorder = clblasRowMajor
	
	cdef clblasTranspose transposeA = clblasNoTrans
	if(transA): transposeA = clblasTrans

	cdef cl_mem memA = <cl_mem><voidptr_t>A.int_ptr
	cdef cl_mem memx = <cl_mem><voidptr_t>x.int_ptr
	cdef cl_mem memy = <cl_mem><voidptr_t>y.int_ptr

	cdef cl_command_queue queue = <cl_command_queue><voidptr_t>commandQueues.int_ptr
	
	cdef cl_event kernel_event
	cdef clblasStatus result = clblasSgemv(blasorder,transposeA,M,N,alpha,memA,offA,lda,memx,offx,incx,beta,memy,offy,incy,numCommandQueues,&queue,0,NULL,&kernel_event)

	if(result): raise clblasException(result)

	return pyopencl.Event.from_int_ptr(<long>kernel_event)

def dgemmwrapper(order,transA,transB,M,N,K,alpha,A,offA,lda,B,offB,ldb,beta,C,offC,ldc,numCommandQueues,commandQueues):
	return dgemmcwrapper(order,transA,transB,M,N,K,alpha,A,offA,lda,B,offB,ldb,beta,C,offC,ldc,numCommandQueues,commandQueues)

cdef dgemmcwrapper(order,transA,transB,size_t M,size_t N,size_t K,cl_double alpha,A,size_t offA,size_t lda,B,size_t offB,size_t ldb,cl_double beta,C,size_t offC,size_t ldc,cl_uint numCommandQueues,commandQueues):
	cdef clblasOrder blasorder = clblasRowMajor

	cdef clblasTranspose transposeA = clblasNoTrans
	if(transA): transposeA = clblasTrans

	cdef clblasTranspose transposeB = clblasNoTrans
	if(transB): transposeB = clblasTrans

	cdef cl_mem memA = <cl_mem><voidptr_t>A.int_ptr
	cdef cl_mem memB = <cl_mem><voidptr_t>B.int_ptr
	cdef cl_mem memC = <cl_mem><voidptr_t>C.int_ptr

	cdef cl_command_queue queue = <cl_command_queue><voidptr_t>commandQueues.int_ptr

	cdef cl_event kernel_event
	cdef clblasStatus result  = clblasDgemm(blasorder,transposeA,transposeB,M,N,K,alpha,memA,offA,lda,memB,offB,ldb,beta,memC,offC,ldc,numCommandQueues,&queue,0,NULL,&kernel_event)

	if(result): raise clblasException(result)

	return pyopencl.Event.from_int_ptr(<long>kernel_event)

def dgemvwrapper(order,transA,M,N,alpha,A,offA,lda,x,offx,incx,beta,y,offy,incy,numCommandQueues,commandQueues):
	return dgemvcwrapper(order,transA,M,N,alpha,A,offA,lda,x,offx,incx,beta,y,offy,incy,numCommandQueues,commandQueues)

cdef dgemvcwrapper(order,transA,size_t M,size_t N,cl_double alpha,A,size_t offA,size_t lda,x,size_t offx,int incx,cl_double beta,y,size_t offy,int incy,cl_uint numCommandQueues,commandQueues):
	cdef clblasOrder blasorder = clblasRowMajor
	
	cdef clblasTranspose transposeA = clblasNoTrans
	if(transA): transposeA = clblasTrans

	cdef cl_mem memA = <cl_mem><voidptr_t>A.int_ptr
	cdef cl_mem memx = <cl_mem><voidptr_t>x.int_ptr
	cdef cl_mem memy = <cl_mem><voidptr_t>y.int_ptr

	cdef cl_command_queue queue = <cl_command_queue><voidptr_t>commandQueues.int_ptr
	
	cdef cl_event kernel_event
	cdef clblasStatus result = clblasDgemv(blasorder,transposeA,M,N,alpha,memA,offA,lda,memx,offx,incx,beta,memy,offy,incy,numCommandQueues,&queue,0,NULL,&kernel_event)
	
	if(result): raise clblasException(result)

	return pyopencl.Event.from_int_ptr(<long>kernel_event)

def waitrelease(kernelEvent):
	return waitreleasecwrapper(kernelEvent)

cdef waitreleasecwrapper(kernelEvent):
	cdef cl_event kernel_event = <cl_event><voidptr_t>kernelEvent.int_ptr
	clWaitForEvents(1,&kernel_event)
	clReleaseEvent(kernel_event)
