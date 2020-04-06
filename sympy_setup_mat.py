from sympy import *
import re
init_printing()

D = diff
I = integrate

i,j,k,l,m,n = symbols('i j k l m n', integer=True)
f,g,h = symbols('f g h', cls=Function)
x,y,z,t = symbols('x y z t')
