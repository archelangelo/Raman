function [ l ] = lorentz(p, xd)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    l = p(1) ./ ((xd - p(2)).^2 + p(3));
end

