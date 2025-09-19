
using Symbolics
@variables z

Ntrunc = 3 


num_vfield = size(vector_field,1)

total_lderiv = num_vfield*(1-num_vfield^Ntrunc)/(1-num_vfield)
total_lderiv = Int(total_lderiv)

#Ltemp = sp.Matrix(np.zeros((total_lderiv, 1), dtype='object'))
#ctrLtemp = np.zeros((Ntrunc+1,1), dtype = 'int')