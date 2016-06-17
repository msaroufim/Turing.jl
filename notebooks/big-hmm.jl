using Turing

K = 10
N = 51

T =  Array{Array{Float64}}(
  {{  2.72545164e-01,   6.56376310e-37,   7.93970182e-06,
          8.61092244e-05,   1.65656847e-01,   2.87081146e-01,
          2.18659173e-04,   4.06806091e-13,   2.74399041e-01,
          5.09466694e-06},
       {  8.35696383e-02,   7.05396766e-06,   2.06100213e-01,
          1.52600546e-11,   1.53908757e-08,   6.52698080e-11,
          6.73013596e-01,   1.93819808e-02,   1.79275025e-02,
          3.22727890e-18},
       {  8.86728867e-01,   8.63212428e-07,   3.94046562e-11,
          1.10467781e-01,   1.11735715e-06,   2.12946427e-18,
          5.16880247e-08,   2.36340361e-04,   1.11600188e-03,
          1.44897701e-03},
       {  8.16557898e-11,   1.68992485e-02,   6.27227283e-14,
          1.07672980e-02,   4.26756301e-01,   1.78050405e-09,
          6.41316248e-05,   3.21159984e-01,   3.69047216e-02,
          1.87448314e-01},
       {  1.30652141e-01,   4.70465408e-06,   4.73601393e-04,
          3.78509164e-02,   9.06618543e-10,   7.78622816e-04,
          2.93837790e-04,   8.29914494e-01,   8.69688804e-26,
          3.16817317e-05},
       {  2.23054659e-01,   2.88152163e-01,   7.35806925e-19,
          1.85562602e-02,   1.73073908e-08,   4.00936069e-01,
          1.17437994e-12,   4.43974641e-02,   2.49033671e-02,
          7.22022850e-18},
       {  4.78064507e-16,   3.20444079e-01,   3.85904296e-03,
          1.26156421e-09,   6.88364264e-03,   4.47186979e-03,
          1.56660567e-01,   1.69796226e-01,   3.33780163e-01,
          4.10440864e-03},
       {  4.84470444e-13,   2.50251630e-14,   2.78748146e-07,
          2.45132866e-03,   3.03033036e-12,   2.84425237e-03,
          8.49830551e-07,   6.60111797e-08,   9.94702713e-01,
          5.11768273e-07},
       {  1.68396450e-01,   1.80280379e-07,   5.68958062e-11,
          1.34838199e-01,   2.08104310e-04,   8.61188042e-02,
          5.17409105e-02,   3.61825373e-01,   3.31239961e-11,
          1.96871978e-01},
       {  4.74764005e-02,   1.16126593e-06,   5.96036112e-08,
          1.28470373e-03,   1.30134792e-06,   3.74283978e-02,
          3.10068428e-01,   2.27075277e-19,   6.47484474e-03,
          5.97264703e-01}})

obs = Array{Float64}(
  {         0.0,   7.72711051,   2.76189162,   8.8216901 ,
        10.80174329,   8.87655587,   0.47685358,   9.51892527,
         7.82538035,   5.52629325,  10.75167786,   5.94925434,
        -0.96912603,   1.65160838,   1.65005965,  -0.99642713,
         7.37803004,   5.40821392,   9.44046498,   8.51761132,
         9.76981763,   5.980154  ,   9.19558142,   5.33965621,
         6.2388448 ,   2.77755879,   6.67731151,   8.52411613,
        11.31057577,   8.11554144,   6.64705471,   8.02025435,
         9.84003587,   3.03943679,  -2.93966727,   2.04372567,
        -0.93734763,   3.66943525,   6.12876571,  -2.07758649,
         1.10420963,  -0.23197037,   3.64908206,  14.14671815,
         6.96651114,   7.28554932,   9.06049355,   6.54246834,
        11.22672275,   7.41962631,   8.45635411})

means = zeros(Float64,K)
initial = fill(1.0 / K, K)
for i = 1:K
  means[i] = i
end

@model big_hmm begin
  states = tzeros(Int,N)
  @assume states[1] ~ Categorical(initial)
  for i = 2:N
    @assume states[i] ~ Categorical(T[states[i-1]])
    @observe obs[i] ~ Normal(means[states[i]], 4)
  end
  @predict states
end



