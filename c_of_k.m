function [ output_args ] = c_of_k( k )
%c_of_k Summary of this function goes here
%   Detailed explanation goes here

if k == 0,
    c = 1/sqrt(2);
else
    c = 1;
    
end

output_args = c;

end

