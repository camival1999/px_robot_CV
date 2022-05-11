%% Iniciamos nodo ROS
rosinit;
%% Definimos el cliente del servicio que vamos a emplear junto a su mensaje
motorSvcClient = rossvcclient('/dynamixel_workbench/dynamixel_command');
motorCommandMsg = rosmessage(motorSvcClient);
%% Vector de posición para el robot
format long G
valores=[0 0 0 0 0];
valores=[-20 20 -20 20 0];
valores=[30 -30 20 -30 0];%modificado por colisiones el max es 23 id 3
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
%%id    rango                       nuehome    Destino  rango
%%1     0       -   4095            2048       3073     0-360
%%2     1100    -   3300            2048       2477     
%%3     1000    -   3333            3073       1925
%%4     600     -   3333            2048       835
%%5     1550    -   3110 -  3600    3110       2180
% %%Grafica de la posición del robot 
% % Subscripción a tópico de pose
% %Definimos el subscriber al topico pose, con el tipo de mensaje obtenido usando en terminal el comando "rostopic info /joint_states"
%     poseSub = rossubscriber('/joint_states','sensor_msgs/JointState'); 
% 
% %Pausa opara permitir que la subscripción se procese
%     pause(0.2); 
% 
% %Usamos la función "receive()" para poner al subscriptor en modo "escucha",a la espera de que se transmita un mensaje del tópico
%     msgPose = receive(poseSub);
%     pause(0.2); 
%     disp('Position before Joints 1-4');
%     disp(msgPose.Position)
% 
% %Definimos el publicador a tópico
%     [posPub, posMsg] = rospublisher('/joint_states','sensor_msgs/JointState'); 
% 
% %Definimos el mensaje que queremos publicar al tópico
%     posMsg.Header.Stamp.Sec = msgPose.Header.Stamp.Sec+10;
%     posMsg.Name = {'joint_1' 'joint_2' 'joint_3' 'joint_4'}; 
%     posMsg.Position = [0.0 -1.0 1.0 2.0];
%     send(posPub,posMsg); %Envio
% 
%     msgPose = receive(poseSub);
%     disp('Position after Joints 1-4');
%     disp(msgPose.Position)