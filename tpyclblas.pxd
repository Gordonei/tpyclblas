"""
tpyclblas.pyx
Extremely thin wrapper around clBLAS for PyOpenCL
Gordon Inggs (gordon <dot> inggs <at> gmail <dot> com)
May 2014

This is the definition file for the primary library file (tpyclblas.pyx). It basically exposes the requiste functions and types from clBLAS to be used by tpyclblas.

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

cdef extern from "clBLAS.h":
    ctypedef int cl_int
    ctypedef unsigned int cl_uint
    ctypedef unsigned long int cl_ulong
    ctypedef float cl_float
    ctypedef double cl_double

    ctypedef void* cl_context
    ctypedef void* cl_command_queue
    ctypedef void* cl_event
    ctypedef void* cl_mem

    ctypedef enum clblasStatus_:
        clblasSuccess 
        clblasInvalidValue
        clblasInvalidCommandQueue 
        clblasInvalidContext
        clblasInvalidMemObject
        clblasInvalidDevice
        clblasInvalidEventWaitList
        clblasOutOfResources
        clblasOutOfHostMemory
        clblasInvalidOperation
        clblasCompilerNotAvailable
        clblasBuildProgramFailure
        clblasNotImplemented
        clblasNotInitialized
        clblasInvalidMatA
        clblasInvalidMatB
        clblasInvalidMatC
        clblasInvalidVecX
        clblasInvalidVecY
        clblasInvalidDim
        clblasInvalidLeadDimA
        clblasInvalidLeadDimB
        clblasInvalidLeadDimC
        clblasInvalidIncX
        clblasInvalidIncY
        clblasInsufficientMemMatA
        clblasInsufficientMemMatB
        clblasInsufficientMemMatC
        clblasInsufficientMemVecX
        clblasInsufficientMemVecY

    ctypedef clblasStatus_ clblasStatus
    
    ctypedef enum clblasOrder_:
        clblasRowMajor
        clblasColumnMajor

    ctypedef clblasOrder_ clblasOrder

    ctypedef enum clblasTranspose_:
        clblasNoTrans
        clblasTrans
        clblasConjTrans
    
    ctypedef clblasTranspose_ clblasTranspose
    
    clblasStatus clblasSgemm(
	clblasOrder order,
        clblasTranspose transA,
        clblasTranspose transB,
        size_t M,
        size_t N,
        size_t K,
        cl_float alpha,
        const cl_mem A,
        size_t offA,
        size_t lda,
        const cl_mem B,
        size_t offB,
        size_t ldb,
        cl_float beta,
        cl_mem C,
        size_t offC,
        size_t ldc,
        cl_uint numCommandQueues,
        cl_command_queue *commandQueues,
        cl_uint numEventsInWaitList,
        const cl_event *eventWaitList,
        cl_event *events)

    clblasStatus clblasSgemv(
    	clblasOrder order,
    	clblasTranspose transA,
    	size_t M,
    	size_t N,
    	cl_float alpha,
    	const cl_mem A,
    	size_t offA,
    	size_t lda,
    	const cl_mem x,
    	size_t offx,
    	int incx,
    	cl_float beta,
    	cl_mem y,
    	size_t offy,
    	int incy,
    	cl_uint numCommandQueues,
    	cl_command_queue *commandQueues,
    	cl_uint numEventsInWaitList,
    	const cl_event *eventWaitList,
    	cl_event *events)
    
    clblasStatus clblasDgemm(
	clblasOrder order,
        clblasTranspose transA,
        clblasTranspose transB,
        size_t M,
        size_t N,
        size_t K,
        cl_double alpha,
        const cl_mem A,
        size_t offA,
        size_t lda,
        const cl_mem B,
        size_t offB,
        size_t ldb,
        cl_double beta,
        cl_mem C,
        size_t offC,
        size_t ldc,
        cl_uint numCommandQueues,
        cl_command_queue *commandQueues,
        cl_uint numEventsInWaitList,
        const cl_event *eventWaitList,
        cl_event *events)

    clblasStatus clblasDgemv(
    	clblasOrder order,
    	clblasTranspose transA,
    	size_t M,
    	size_t N,
    	cl_double alpha,
    	const cl_mem A,
    	size_t offA,
    	size_t lda,
    	const cl_mem x,
    	size_t offx,
    	int incx,
    	cl_double beta,
    	cl_mem y,
    	size_t offy,
    	int incy,
    	cl_uint numCommandQueues,
    	cl_command_queue *commandQueues,
    	cl_uint numEventsInWaitList,
    	const cl_event *eventWaitList,
    	cl_event *events) 

    clblasStatus clblasSetup()
    
    void clblasTeardown()

    cl_int clWaitForEvents(cl_uint numEvents,const cl_event* event_list)

    cl_int clReleaseEvent(cl_event event)
