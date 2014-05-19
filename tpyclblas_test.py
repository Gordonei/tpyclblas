import pyopencl as cl
import numpy,time
import numpy.linalg as la

import tpyclblas

A = numpy.array([[11, 12, 13, 14, 15],[21, 22, 23, 24, 25],[31, 32, 33, 34, 35],[41, 42, 43, 44, 45]],dtype=numpy.float32)
B = numpy.array([[11, 12, 13],[21, 22, 23],[31, 32, 33],[41, 42, 43],[51, 52, 53]],dtype=numpy.float32)
C = numpy.zeros((4,3),dtype=numpy.float32)

ctx = cl.create_some_context()
queue = cl.CommandQueue(ctx)

mf = cl.mem_flags
A_buf = cl.Buffer(ctx, mf.READ_ONLY,A.nbytes)
B_buf = cl.Buffer(ctx, mf.READ_ONLY,B.nbytes)
dest_buf = cl.Buffer(ctx, mf.WRITE_ONLY, C.nbytes)

cl.enqueue_copy(queue, A_buf, A).wait()
cl.enqueue_copy(queue, B_buf, B).wait()

tpyclblas.setupwrapper()
print "\n"
print "Output code from Matrix Multiplication: %d" % tpyclblas.sgemmwrapper(None,False,False,4,3,5,1.0,A_buf,0,5,B_buf,0,3,0.0,dest_buf,0,3,1,queue)

cl.enqueue_copy(queue, C, dest_buf).wait()
print C

tpyclblas.teardownwrapper()