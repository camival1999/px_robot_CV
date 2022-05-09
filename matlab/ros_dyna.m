%% Iniciamos nodo ROS
rosinit;
%% Definimos el cliente del servicio que vamos a emplear junto a su mensaje
motorSvcClient = rossvcclient('/dynamixel_workbench/dynamixel_command');
motorCommandMsg = rosmessage(motorSvcClient);
%% Generamos el mensaje deseado antes de llamar al servicio con el cliente
motorCommandMsg.AddrName = "Goal_Position";
motorCommandMsg.Id = 1;
motorCommandMsg.Value = 512;
call(motorSvcClient, motorCommandMsg);