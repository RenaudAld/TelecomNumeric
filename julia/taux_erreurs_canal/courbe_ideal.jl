using SpecialFunctions
using PyPlot
function TEB(x)
    return(1/2 * erfc(sqrt(x)));
end
x = collect(0:0.1:8);
x_log = 10 .^ (x ./ 10);
fx = TEB.(x_log);
plot(x,fx, color="red");
