%% Iniciamos nodo ROS
rosinit;
%% Definimos el cliente del servicio que vamos a emplear junto a su mensaje
motorSvcClient = rossvcclient('/dynamixel_workbench/dynamixel_command');
motorCommandMsg = rosmessage(motorSvcClient);
%% Generamos el mensaje deseado antes de llamar al servicio con el cliente
motorCommandMsg.AddrName = "Goal_Position";
motorCommandMsg.Id = 4;
motorCommandMsg.Value = 2000;%%rango 0-4096
call(motorSvcClient, motorCommandMsg);

%%Limites de los motores 
%%id    rango                                   nuestro home    Destino
%%1     0       -   4095                        2048            3073
%%2     1100    -   3300                        2048            2477
%%3     1000    -   3333                        3073            1925
%%4     600     -   3333                        2048            835
%%5     1550    -   max abierto 3110 -  3600    3110            2180
