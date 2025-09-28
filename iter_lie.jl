
using Symbolics
using LinearAlgebra
x = Symbolics.variables(:x, 1:2)

Ntrunc = 3 

h = x[1]
g = transpose([[-x[1]*x[2], x[1]*x[2]], [x[1], 0], [0, - x[2]]]) # is this a matrix?

vector_field = g

num_vfield = size(vector_field,1)

total_lderiv = num_vfield*(1-num_vfield^Ntrunc)/(1-num_vfield)
total_lderiv = Int(total_lderiv)

Ltemp = zeros(total_lderiv, 1)
ctrLtemp = zeros(Ntrunc+1)


for i in 0:Ntrunc-1
    ctrLtemp[i+2] =  ctrLtemp[i+1] + num_vfield^(i+1)
end

# broadcast h to match vector field size
#H = repeat(h, outer=(num_vfield,1))
for i in 1:num_vfield
    Ltemp[i,1] = dot([Symbolics.jacobian([h],x)],vector_field[i,:]) # assuming vector_field is a matrix
end
LT = dot([Symbolics.jacobian([h],x)],vector_field)
#T = LT.reshape(LT.shape[0]*LT.shape[1], 1)


for i in 1:Ntrunc-1
    
    start_prev_block = Int(ctrLtemp[i])
    end_prev_block = Int(ctrLtemp[i+1])
    end_current_block = Int(ctrLtemp[i+2])
    num_prev_block = end_prev_block - start_prev_block
    num_current_block = end_current_block - end_prev_block
    #print("i: ", i, " start_prev_block: ", start_prev_block, " end_prev_block: ", end_prev_block, " end_current_block: ", end_current_block, " num_prev_block: ", num_prev_block, " num_current_block: ", num_current_block)
    Vfield_block = repeat(vector_field, inner=(num_prev_block,1)) # inputs for current permutation
    #print("U_block size: ", size(U_block))
    prev_lderiv_block = repeat(Ltemp[start_prev_block+1:end_prev_block,:], outer=(num_vfield,1)) # block of previous permutations
    #print("prev_int_block size: ", size(prev_int_block))
    current_lderiv_block = dot([Symbolics.jacobian(prev_lderiv_block[:,1],x)],Vfield_block)
    #print(size(current_int_block))
    Ltemp[end_prev_block+1:end_current_block,:] = current_lderiv_block

end