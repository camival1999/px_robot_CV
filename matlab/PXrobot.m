%% TOOLBOX Creación modelo Phantom en Matlab empleando parámetros DHstd
% Cálulo de las longitudes de eslabón
    l1 = 47;
    l2 = sqrt(100^2+32^2);
    l3 = 100;
    l4 = 100;
    l = [l1, l2, l3, l4]; 
% Cálculo de offsets
    off1 = 0;
    off2 = -atand(100/32)*pi/(180);
    off3 = -pi/2-off2;
    off4 = 0; %Cambiar a pi si no se ajusta el marco de base.
% Definicion del robot DH std
    L(1) = Link('revolute','alpha',-pi/2,'a',0,   'd',l(1),'offset',off1, 'qlim',[-3*pi/4 3*pi/4]);
    L(2) = Link('revolute','alpha',0,    'a',l(2),'d',0,   'offset',off2, 'qlim',[-3*pi/4 3*pi/4]);
    L(3) = Link('revolute','alpha',0,    'a',l(3),'d',0,   'offset',off3, 'qlim',[-3*pi/4 3*pi/4]);
    L(4) = Link('revolute','alpha',0,    'a',l(4),'d',0,   'offset',off4, 'qlim',[-3*pi/4 3*pi/4]);
    PhantomX = SerialLink(L,'name','Px');
    base = [-1  0  0  0; 
             0 -1  0  0; 
             0  0  1  0;
             0  0  0  1];

    tool = [ 0  0  1  0; 
             1  0  0  0; 
             0  1  0  0;
             0  0  0  1];
    PhantomX.tool = tool; %Ajuste para emplear notación NOA
    PhantomX.base = base; %Si no se reajusta la base es necesario modificar el offset 1
% Graficar robot
%q1 = [0 0 0 0];
%q1 = [1.5707 -0.7 0.2 0.9];
q1 = [-1.5707 1.2 0.4 -2];
    w1 = figure();
    PhantomX.plot(q1,'notiles');
    hold on
    trplot(base,'rgb','arrow','length',75,'frame','0')
    ws = [-450 450]; %Espacio XY
    axis([repmat(ws,1,2) -100 450])
    view(-30,20)
    hold off

    %PhantomX.teach()
% Revisar marcos coordenados
    % q = zeros(1,4);
    % M = base;
    % for i=1:PhantomX.n
    %     M = M * L(i).A(q(i));
    %     trplot(M,'rgb','arrow','frame',num2str(i),'length',75)
    % end
    % hold off
 % Matriz de transformación Homogénea
    MTHCorke = PhantomX.fkine(q1); %MTH hasta el TCP.
       % De forma manual:
    MTHManual = L(1).A(q1(1))*L(2).A(q1(2))*L(3).A(q1(3))*L(4).A(q1(4))*tool;
  
    for i = 1:length(MTHCorke)
       for j = 1:length(MTHCorke)
            if abs(MTHCorke(i,j))<0.001
                MTHCorke(i,j) = 0;
            end
            if abs(MTHManual(i,j))<0.001
                MTHManual(i,j) = 0;
            end
       end
    end
    disp(MTHCorke);
    disp(MTHManual);
%% CONEXIÓN CON MATLAB Movimiento del robot. Asegurarse que está corriendo px_controllers.launch previamente
% Iniciamos nodo ROS
    rosinit
%%
% Subscripción a tópico de pose
%Definimos el subscriber al topico pose, con el tipo de mensaje obtenido usando en terminal el comando "rostopic info /joint_states"
    poseSub = rossubscriber('/joint_states','sensor_msgs/JointState'); 

%Pausa opara permitir que la subscripción se procese
    pause(0.2); 

%Usamos la función "receive()" para poner al subscriptor en modo "escucha",a la espera de que se transmita un mensaje del tópico
    msgPose = receive(poseSub);
    pause(0.2); 
    disp('Position before Joints 1-4');
    disp(msgPose.Position)

%Definimos el publicador a tópico
    [posPub, posMsg] = rospublisher('/joint_states','sensor_msgs/JointState'); 

%Definimos el mensaje que queremos publicar al tópico
    posMsg.Header.Stamp.Sec = msgPose.Header.Stamp.Sec+10;
    posMsg.Name = {'joint_1' 'joint_2' 'joint_3' 'joint_4'}; 
    posMsg.Position = [0.0 -1.0 1.0 2.0];
    send(posPub,posMsg); %Envio

    msgPose = receive(poseSub);
    disp('Position after Joints 1-4');
    disp(msgPose.Position)