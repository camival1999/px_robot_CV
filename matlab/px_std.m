%% Cálulo de las longitudes de eslabón
l1 = 47;
l2 = sqrt(100^2+32^2);
l3 = 100;
l4 = 100;
l = [l1, l2, l3, l4]; 
%% Cálculo de offsets
off1 = 0;
off2 = -atand(100/32)*pi/(180);
off3 = -pi/2-off2;
off4 = 0; %Cambiar a pi si no se ajusta el marco de base.
%% Definicion del robot DH std
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
%% Graficar robot
figure()
PhantomX.plot([0 0 0 0],'tilesize',50);
hold on
trplot(base,'rgb','arrow','length',75,'frame','0')
ws = [-450 450]; %Espacio XY
axis([repmat(ws,1,2) -100 450])
view(-30,20)
hold off
%PhantomX.teach()
%% Revisar marcos coordenados
% q = zeros(1,4);
% M = base;
% for i=1:PhantomX.n
%     M = M * L(i).A(q(i));
%     trplot(M,'rgb','arrow','frame',num2str(i),'length',75)
% end
% hold off
%%
%Seccion para sacar la matriz de transformación TCP
q1=[0 0 0 0];
q2=[0 0 0 1];
q3=[0 0 1 0];
q4=[0 1 1 1];

figure(); %%toca uno por uno
PhantomX.fkine(q1);
title('posición 0 0 0 0');
PhantomX.plot(q1,'notiles');
