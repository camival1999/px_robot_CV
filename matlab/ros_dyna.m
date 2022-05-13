%% Iniciamos nodo ROS
rosinit;
%% Definimos el cliente del servicio que vamos a emplear junto a su mensaje
motorSvcClient = rossvcclient('/dynamixel_workbench/dynamixel_command');
motorCommandMsg = rosmessage(motorSvcClient);
%% Vector de posición para el robot
format long G
valores=[0 0 0 0 0];
valores=[-20 20 -20 20 0];
valores=[30 -30 20 -30 0];%Ángulo 3 modificado por colisiones el max es 23° id 3
valores=[-90 15 -55 17 0];
valores=[-90 45 -55 45 10];
angulos=valores+[180 180 270 180 273];
posicion=(4096/360)*angulos; 
q=[0 0 0 0 0];
qRobot=q*13.65+2048;
%%Generamos el mensaje deseado antes de llamar al servicio con el cliente
motorCommandMsg.AddrName = "Goal_Position";
motorCommandMsg.Id = 1;
motorCommandMsg.Value = posicion(1);%%rango 0-4096
call(motorSvcClient, motorCommandMsg);
pause(0.5);

motorCommandMsg.AddrName = "Goal_Position";
motorCommandMsg.Id = 2;
motorCommandMsg.Value = posicion(2);%%rango 0-4096
call(motorSvcClient, motorCommandMsg);
pause(0.5);

motorCommandMsg.AddrName = "Goal_Position";
motorCommandMsg.Id = 3;
motorCommandMsg.Value = posicion(3);%%rango 0-4096
call(motorSvcClient, motorCommandMsg);
pause(0.5);

motorCommandMsg.AddrName = "Goal_Position";
motorCommandMsg.Id = 4;
motorCommandMsg.Value = posicion(4);%%rango 0-4096
call(motorSvcClient, motorCommandMsg);
pause(0.5);

motorCommandMsg.AddrName = "Goal_Position";
motorCommandMsg.Id = 5;
motorCommandMsg.Value = posicion(5);%%rango 0-4096
call(motorSvcClient, motorCommandMsg);
pause(0.5);

%%Limites de los motores 
%%id    rango                  nuestro home    Destino  rango
%%1     0       -   4095            2048       3073     0-360
%%2     1100    -   3300            2048       2477     
%%3     1000    -   3333            3073       1925
%%4     600     -   3333            2048       835
%%5     1550    -   3110 -  3600    3110       2180