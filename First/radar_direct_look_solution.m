hr=100;
ht=[0:1:1e4];
Rs=4.1*(sqrt(hr)+sqrt(ht));
plot(ht,Rs);
xlabel('Target_Altitude/m');
ylabel('Radar_Direct_Look_Distance/km');