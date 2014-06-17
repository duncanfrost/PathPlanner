function [ output_args ] = drawcube( position, size,color)

r = size;

x1 = position(1) - r;
x2 = position(1) + r;

z1 = position(2) - r;
z2 = position(2) + r;

y1 = position(3) - r;
y2 = position(3) + r;

options = [color '-'];


hold on;
plot3([x1 x1],[y1 y2], [z1 z1],options);
plot3([x2 x2],[y1 y2], [z1 z1],options);

plot3([x1 x1],[y1 y2], [z2 z2],options);
plot3([x2 x2],[y1 y2], [z2 z2],options);

plot3([x1 x1],[y1 y1], [z1 z2],options);
plot3([x1 x1],[y2 y2], [z1 z2],options);

plot3([x2 x2],[y1 y1], [z1 z2],options);
plot3([x2 x2],[y2 y2], [z1 z2],options);

plot3([x1 x2],[y1 y1], [z1 z1],options);
plot3([x1 x2],[y1 y1], [z2 z2],options);

plot3([x1 x2],[y2 y2], [z1 z1],options);
plot3([x1 x2],[y2 y2], [z2 z2],options);




end

