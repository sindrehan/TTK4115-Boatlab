%Oppgb)
t = rudder.time;
y1 = compass.data;
y2 = rudder.data;

tx = text(0.5,0.5,'\psi');
s = tx.FontSize;
tx.FontSize = 25;

plot(t, y1, t, y2);

legend('\psi', '\delta');
xlabel('Time [s]')
ylabel('\psi,\delta [deg]')