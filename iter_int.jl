
Ntrunc = 3
dt = 0.01
ctrEtemp = Ref(0.0)
t = range(0, stop=1, length=10)
u1 = sin.(t)
u2 = cos.(t)

utemp = stack([u1, u2], dims = 1)

num_input = size(utemp, 1)


total_iterint = num_input*(1-num_input^Ntrunc)/(1-num_input)

total_iterint = Int(total_iterint)

Etemp = zeros(total_iterint, size(utemp, 2))

ctrEtemp = zeros(Ntrunc+1)

for i in 1:Ntrunc
    ctrEtemp[i+1] =  ctrEtemp[i] + num_input^(i+1)
end

sum_acc = cumsum(utemp, dims=2)*dt

Etemp[1:num_input,begin:end] = hcat(zeros(num_input, 1), sum_acc[:,begin:end-1])

for i in 1:Ntrunc
    
    start_prev_block = 
    utemp1 = repeat(utemp, inner=(2,1))

    utemp2 = repeat(utemp, outer=(2,1))

    utemp = utemp1.*utemp2

end




u1.*u1


