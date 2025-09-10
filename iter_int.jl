t = range(0, stop=1, length=10)
u1 = sin.(t)
u2 = cos.(t)


for i in 1:Ntrunc
    ctrEtemp[] = 


utemp = stack([u1, u2], dims = 1)


for i in 1:Ntrunc
    
    start_prev_block = 
    utemp1 = repeat(utemp, inner=(2,1))

    utemp2 = repeat(utemp, outer=(2,1))

    utemp = utemp1.*utemp2

end




u1.*u1


