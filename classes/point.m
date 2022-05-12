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

    function s = plus(p1,p2)
        s = point(0, 0);
        s.x = p1.x + p2.x;
        s.y = p1.y + p2.y;
    endfunction

    function m = minus(p1,p2)
        m = point(0, 0);
        m.x = p1.x - p2.x;
        m.y = p1.y - p2.y;
    endfunction

    function q = mrdivide(p1, k)
        q = point(0, 0);
        q.x = p1.x/k;
        q.y = p1.y/k;
    endfunction

    function mod = size(this)
        mod = (this.x^2 + this.y^2)^(1/2);
    endfunction
  endmethods
endclassdef
