function [] = plotrec(x,y,w,h,colour)
x1 = x  - w/2;
x2 = x + w/2;
y1 = y - h/2;
y2 = y + h/2;

plot([x1 x2], [y1 y1],colour);
plot([x1 x2], [y2 y2],colour);
plot([x1 x1], [y1 y2],colour);
plot([x2 x2], [y1 y2],colour);



end

