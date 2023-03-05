from sympy import *
from sympy.vector import gradient as grad, divergence as div, CoordSys3D as Coord, curl, Point, scalar_potential, scalar_potential_difference, directional_derivative
import re
init_printing()

lap = lambda expr: div(grad(expr))
l,m,n = symbols('l m n', integer=True)
f,g,h = symbols('f g h', cls=Function)
D     = symbols('D', real=True, positive=True)
e = Coord('e')
x,y,z,i,j,k,t = e.x,e.y,e.z,e.i,e.j,e.k,Symbol('t', real=True)
a,b,c = symbols('a b c', real=True)
F = f(x,y,z,t)
