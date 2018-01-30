function varargout = SWF(varargin)
% SWF MATLAB code for SWF.fig
%      SWF, by itself, creates a new SWF or raises the existing
%      singleton*.
%
%      H = SWF returns the handle to a new SWF or the handle to
%      the existing singleton*.
%
%      SWF('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SWF.M with the given input arguments.
%
%      SWF('Property','Value',...) creates a new SWF or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SWF_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SWF_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SWF

% Last Modified by GUIDE v2.5 28-Mar-2016 14:19:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SWF_OpeningFcn, ...
                   'gui_OutputFcn',  @SWF_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before SWF is made visible.
function SWF_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SWF (see VARARGIN)

% Choose default command line output for SWF
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SWF wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SWF_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function path_Callback(hObject, eventdata, handles)%SWF�ļ�·��
% hObject    handle to path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of path as text
%        str2double(get(hObject,'String')) returns contents of path as a double


% --- Executes on button press in loadbutton.
function loadbutton_Callback(hObject, eventdata, handles)%����SWF�ļ�
% hObject    handle to loadbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
output=get(handles.path,'String');
fid=fopen('d:\test.bin','wb');
fd=fopen(output,'rb');
A=fread(fd,'double');
fwrite(fid,A,'double');
fclose(fid);
fclose(fd);


% --- Executes on button press in analysinghead.
function analysinghead_Callback(hObject, eventdata, handles)%����SWF�ļ�ͷ
fid=fopen('test.bin','rb');
data1=double(fread(fid,'uint8'))   %��ȡfid��Ϣ
data2=dec2hex(data1);              %ת��16����
%���ѹ�����
if(~strcmp(data2(1:3,1:2),num2str([4,6;5,7;5,3])))
set(handles.compress,'string','false');
else {set(handles.compress,'string','true');}
end

%���汾��                            
versionnum=data2(4,1:2);
set(handles.version,'string',versionnum);

%ȷ���ֽڴ�С
data3(1,1:2)=data2(8,1:2);
data3(1,3:4)=data2(7,1:2);
data3(1,5:6)=data2(6,1:2);
data3(1,7:8)=data2(5,1:2);      %С������
%data4=hex2dec(data3);           %�ֽ�ת��16����
set(handles.filelength,'string',hex2dec(data3));
 
 %֡Ƶ 18,19��λ��,֡Ƶ��
 data4(1,1:2)=data2(18,1:2);
 data4(1,3:4)=data2(19,1:2);
 %data6=hex2dec(data5);
 set(handles.frequency,'string',hex2dec(data4));
 
 %��֡��
 data5(1,1:2)=data2(21,1:2);
 data5(1,3:4)=data2(20,1:2);
 %data8=hex2dec(data7);
 set(handles.framepersecond,'string',hex2dec(data5));
 
 %��̨��С
 data6(1,1:2)=data2(9,1:2);
 data6(1,3:4)=data2(10,1:2);
 data6(1,5:6)=data2(11,1:2);
 data6(1,7:8)=data2(12,1:2);
 data6(1,9:10)=data2(13,1:2);
 data6(1,11:12)=data2(14,1:2);
 data6(1,13:14)=data2(15,1:2);
 data6(1,15:16)=data2(16,1:2);
 data6(1,17:18)=data2(17,1:2);
 
 %ant=1; data5(1,1:2)='78';for 
%switch 
   %case {'0'}
   %data7(1,ant:ant+3)='0000';ant=ant+4;
  %case {'1'}
  %data7(1,ant:ant+3)='0001';ant=ant+4;
   %case {'2'}
   %data7(1,ant:ant+3)='0010';ant=ant+4;
   %case {'3'}
   %data7(1,ant:ant+3)='0011';ant=ant+4;
   %case {'4'}
   %data7(1,ant:ant+3)='0100';ant=ant+4;
   %case {'5'}
   %data7(1,ant:ant+3)='0101';ant=ant+4;
   %case {'6'}
   %data7(1,ant:ant+3)='0110';ant=ant+4;
   %case {'7'}
   %data7(1,ant:ant+3)='0111';ant=ant+4;
   %case {'8'}
   %data7(1,ant:ant+3)='1000';ant=ant+4;
   %case {'9'}
   %data7(1,ant:ant+3)='1001';ant=ant+4;
   %case {'A'} 
   %data7(1,ant:ant+3)='1010';ant=ant+4;
   %case {'B'}
   %data7(1,ant:ant+3)='1011';ant=ant+4;
   %case {'C'}
   %data7(1,ant:ant+3)='1100';ant=ant+4;
   %case {'D'}
   %data7(1,ant:ant+3)='1101';ant=ant+4;
   %case {'E'}
   %data7(1,ant:ant+3)='1110';ant=ant+4;
   %case {'F'}
   %data7(1,ant:ant+3)='1111';ant=ant+4;
   %end
 data7=dec2bin(hex2dec(data6));
 m=72-length(data7);   %����ͷ����0�����ӵ���
 bit=bin2dec((data7(1,1:5-m)));
 xmin=bin2dec((data7(1,6-m:5+bit-m)));
 xmax=bin2dec((data7(1,6+bit-m:5+2*bit-m)));
 ymin=bin2dec((data7(1,6+2*bit-m:5+3*bit-m)));
 ymax=bin2dec((data7(1,6+3*bit-m:5+4*bit-m)));
 xcl=(xmax-xmin)/20;
 ycl=(ymax-ymin)/20;
 data8=[num2str(xcl),'��',num2str(ycl)];
 set(handles.size,'string',data8);
 fclose(fid);


% --- Executes on button press in analysingTag.
function analysingTag_Callback(hObject, eventdata, handles)%����Tag������
fid=fopen('test.bin','rb');
data1=double(fread(fid,'uint8'));   %��ȡfid��Ϣ
data2=dec2hex(data1);
data3(1,1:2)=data2(8,1:2);
data3(1,3:4)=data2(7,1:2);
data3(1,5:6)=data2(6,1:2);
data3(1,7:8)=data2(5,1:2);
data2(hex2dec(data3),1:2)='00';
data2(hex2dec(data3)-1,1:2)='00';
%������ɫ
data9(1,1:2)=data2(30,1:2);
data9(1,3:4)=data2(31,1:2);
data9(1,5:6)=data2(32,1:2);
set(handles.background,'string',data9);
%���������ݽ���ID�����ȷ���
headnum=22;
num=0;
definitionnum=0;
shapenum=0;
morphshapenum=0;
spritsnum=0;
imagenum=0;
wordnum=0;
controlnum=0;
voicenum=0;
videonum=0;
buttonnum=0;
while 1

    data10(1,3:4)=data2(headnum,1:2); %ȡ��data2��ID
    data10(1,1:2)=data2(headnum+1,1:2);
    data11=dec2bin(hex2dec(data10));  %�洢ת�ɵĶ�������
    m=16-length(data11);              %��ͷ����0��ʡ�Ե���
    if(m==15)
    controlnum=controlnum+1;
    break;
    end
    TagID=bin2dec(data11(1,1:10-m));  %������ID��
    stringnum=bin2dec(data11(1,11-m:16-m))+2; %֮������Ե�Ԫ��
    if(stringnum>=63)
    headnum=headnum+6;
    data12(1,1:2)=data2(headnum-1,1:2); %����63�ֽں�Ĵ����취
    data12(1,3:4)=data2(headnum-2,1:2);
    data12(1,5:6)=data2(headnum-3,1:2);
    data12(1,7:8)=data2(headnum-4,1:2); 
    stringnum=hex2dec(data12);
    end
     if(TagID==2||TagID==22||TagID==32||TagID==83||TagID==6||TagID==8||TagID==21||TagID==35||TagID==20||TagID==36||TagID==46||TagID==84||TagID==10||TagID==48||TagID==75||TagID==13||TagID==62||TagID==73||TagID==11||TagID==33||TagID==37||TagID==74||TagID==7||TagID==34||TagID==23||TagID==17||TagID==39||TagID==60)
        definitionnum=definitionnum+1; %�����ͱ�ǩ
     end
        if(TagID==2||TagID==22||TagID==32||TagID==83)
            shapenum=shapenum+1;      %��״
        end
          if(TagID==46||TagID==84)
              morphshapenum=morphshapenum+1;   %�ɱ���״
          end
               if(TagID==7||TagID==34)
              buttonnum=buttonnum+1;          %��ť
               end
              if(TagID==39)
                  spritsnum=spritsnum+1;     %ӰƬ����
              end
              if(TagID==6||TagID==8||TagID==21||TagID==35||TagID==20||TagID==36) 
              imagenum=imagenum+1;          %λͼ
              end
              if(TagID==10||TagID==48||TagID==75||TagID==13||TagID==62||TagID==73||TagID==11||TagID==33||TagID==37||TagID==74) 
                  wordnum=wordnum+1;        %��������
              end
              if(TagID==9||TagID==43||TagID==24||TagID==56||TagID==57||TagID==0||TagID==71||TagID==65||TagID==66||TagID==69||TagID==58||TagID==77||TagID==78||TagID==12||TagID==26||TagID==28||TagID==1)
                  controlnum=controlnum+1;   %�����ͱ�ǩ
              end 
              if(TagID==17)
                  voicenum=voicenum+1;      %����
              end
              if(TagID==39)
                  videonum=videonum+1;      %��Ƶ
              end
    headnum=headnum+stringnum;
end
set(handles.definitionTag,'string',num);
set(handles.definitionTag,'string',definitionnum);
set(handles.controlTag,'string',controlnum);
set(handles.shape,'string',shapenum);
set(handles.morphshape,'string',morphshapenum);
set(handles.button,'string',buttonnum);
set(handles.movieaction,'string',spritsnum);
set(handles.bitmap,'string',spritsnum);
set(handles.movieaction,'string',imagenum);
set(handles.words,'string',wordnum);
set(handles.Voice,'string',voicenum);
set(handles.Video,'string',videonum);
fclose(fid);

% --- Executes during object creation, after setting all properties.
function path_CreateFcn(hObject, eventdata, handles)
% hObject    handle to path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in index.


function compress_Callback(hObject, eventdata, handles)%�Ƿ�ѹ��
% hObject    handle to compress (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of compress as text
%        str2double(get(hObject,'String')) returns contents of compress as a double


% --- Executes during object creation, after setting all properties.
function compress_CreateFcn(hObject, eventdata, handles)
% hObject    handle to compress (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function version_Callback(hObject, eventdata, handles)%�汾��
% hObject    handle to version (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of version as text
%        str2double(get(hObject,'String')) returns contents of version as a double


% --- Executes during object creation, after setting all properties.
function version_CreateFcn(hObject, eventdata, handles)
% hObject    handle to version (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function filelength_Callback(hObject, ~, handles)%�ļ�����
% hObject    handle to filelength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of filelength as text
%        str2double(get(hObject,'String')) returns contents of filelength as a double


% --- Executes during object creation, after setting all properties.
function filelength_CreateFcn(hObject, eventdata, handles)
% hObject    handle to filelength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function definitionTag_Callback(hObject, eventdata, handles)%������Tag
% hObject    handle to definitionTag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of definitionTag as text
%        str2double(get(hObject,'String')) returns contents of definitionTag as a double


% --- Executes during object creation, after setting all properties.
function definitionTag_CreateFcn(hObject, eventdata, handles)
% hObject    handle to definitionTag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function controlTag_Callback(hObject, eventdata, handles)%������Tag
% hObject    handle to controlTag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of controlTag as text
%        str2double(get(hObject,'String')) returns contents of controlTag as a double


% --- Executes during object creation, after setting all properties.
function controlTag_CreateFcn(hObject, eventdata, handles)
% hObject    handle to controlTag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





% --- Executes during object creation, after setting all properties.
function shape_CreateFcn(hObject, eventdata, handles)
% hObject    handle to shape (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





function morphshape_CreateFcn(hObject, eventdata, handles)
% hObject    handle to morphshape (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function button_CreateFcn(hObject, eventdata, handles)
% hObject    handle to button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes during object creation, after setting all properties.
function movieaction_CreateFcn(hObject, eventdata, handles)
% hObject    handle to movieaction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes during object creation, after setting all properties.
function bitmap_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bitmap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function words_Callback(hObject, eventdata, handles)%��������
% hObject    handle to words (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of words as text
%        str2double(get(hObject,'String')) returns contents of words as a double


% --- Executes during object creation, after setting all properties.
function words_CreateFcn(hObject, eventdata, handles)
% hObject    handle to words (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Voice_Callback(hObject, eventdata, handles)%����
% hObject    handle to Voice (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Voice as text
%        str2double(get(hObject,'String')) returns contents of Voice as a double


% --- Executes during object creation, after setting all properties.
function Voice_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Voice (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Video_Callback(hObject, eventdata, handles)%��Ƶ
% hObject    handle to Video (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Video as text
%        str2double(get(hObject,'String')) returns contents of Video as a double


% --- Executes during object creation, after setting all properties.
function Video_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Video (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function size_Callback(hObject, eventdata, handles)%���ȡ��߶�
% hObject    handle to size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of size as text
%        str2double(get(hObject,'String')) returns contents of size as a double


% --- Executes during object creation, after setting all properties.
function size_CreateFcn(hObject, eventdata, handles)
% hObject    handle to size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function frequency_Callback(hObject, eventdata, handles)%֡Ƶ
% hObject    handle to frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of frequency as text
%        str2double(get(hObject,'String')) returns contents of frequency as a double


% --- Executes during object creation, after setting all properties.
function frequency_CreateFcn(hObject, eventdata, handles)
% hObject    handle to frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function framepersecond_Callback(hObject, eventdata, handles)%��֡��
% hObject    handle to framepersecond (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of framepersecond as text
%        str2double(get(hObject,'String')) returns contents of framepersecond as a double


% --- Executes during object creation, after setting all properties.
function framepersecond_CreateFcn(hObject, eventdata, handles)
% hObject    handle to framepersecond (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function background_Callback(hObject, eventdata, handles)
% hObject    handle to background (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of background as text
%        str2double(get(hObject,'String')) returns contents of background as a double


% --- Executes during object creation, after setting all properties.
function background_CreateFcn(hObject, eventdata, handles)
% hObject    handle to background (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in exitbutton.
function exitbutton_Callback(hObject, eventdata, handles)  %�˳�
% hObject    handle to exitbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(handles.figure1)


% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
function figure1_WindowButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit22_Callback(hObject, eventdata, handles)
% hObject    handle to version (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of version as text
%        str2double(get(hObject,'String')) returns contents of version as a double


% --- Executes during object creation, after setting all properties.
function edit22_CreateFcn(hObject, eventdata, handles)
% hObject    handle to version (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end