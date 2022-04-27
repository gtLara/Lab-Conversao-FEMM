classdef point
  properties
    x = 0;
    y = 0;
  endproperties

  methods
    function p = point (x, y)
        p.x = x;
        p.y = y;
    endfunction

    function disp(p)
        printf ("x: %.2f y: %.2f", p.x, p.y);
    endfunction

  endmethods
endclassdef
