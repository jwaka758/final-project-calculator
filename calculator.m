function [] = calculator(str)

 if nargin==0
    str = []; 
        elseif ~ischar(str)% If you enter invalid character like 0.?6# or &8yh you'll get an error 
        error('Please enter a valid character.')
        elseif ~isvarname(str) % If you enter an invalid variable name like @h^&*g or &(4e>/ you'll get an error 
        error('Please enter a valid variable name.')
 end
 
S.STR = str;  
S.CNT = 0;  % The number of times the pushbutton is pressed.
S.CHC = [];  % Represents the operations performed.
S.fh = figure('units','pixels','position',[400 400 300 130],'menubar','none','name','calculator','numbertitle','off','resize','off','deletefcn',{@fig_del,S});
COL = get(S.fh,'color');          
S.pp = uicontrol('style','pop','unit','pix','position',[10 20 120 30],'string',{'Add';'Multiply';'Subtract';'Divide'});
S.ed(1) = uicontrol('style','edit','unit','pix','position',[10 90 70 30],'string','3');
S.tx(1) = uicontrol('style','text','unit','pix','position',[85 90 20 30],'string','+','fontsize',16,'backgroundcolor',COL);                  
S.ed(2) = uicontrol('style','edit','unit','pix','position',[110 90 70 30],'string','2');  
S.tx(2) = uicontrol('style','text','unit','pix','position',[185 90 20 30],'string','=','fontsize',16,'backgroundcolor',COL);                 
S.ed(3) = uicontrol('style','edit','unit','pix','position',[220 90 70 30],'string','Answer');
S.pb = uicontrol('style','push','unit','pix','position',[160 20 120 30],'string','Equal');
set([S.pp,S.pb],'callback',{@pb_call,S}); 
   

function [] = fig_del(varargin)
S = varargin{3};
if ~isempty(S.STR)
    assignin('base',S.STR,S.CHC) 
end


function [] = pb_call(varargin)% Callback for pushbutton
S = varargin{3}; 
N = str2double(get(S.ed(1:2),'string')); 
VL = get(S.pp,{'str','value'}); 
switch VL{1}{VL{2}}  
        case 'Add'
            A = sum(N);
            str = '+';
        case 'Multiply'
            A = prod(N);
            str = 'x';
        case 'Subtract'
                A = -diff(N);
                str = '-';
        case 'Divide'
                    A = N(1)/N(2);
                    str = '/';
     otherwise
end
set(S.tx(1),'string',str)  

if varargin{1}==S.pb  
    S.CNT = S.CNT + 1;
    set(S.ed(3),'str',A)
    S.CHC{S.CNT,1} = sprintf('%2.2f %s %2.2f %s %2.2f',N(1),str,N(2),'=',A);
    set(S.pb,'callback',{@pb_call,S})
    set(S.fh,'deletefcn',{@fig_del,S})
end 

