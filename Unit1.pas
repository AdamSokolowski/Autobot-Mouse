unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DateUtils;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    ComboBox1: TComboBox;
    Edit3: TEdit;
    ComboBox2: TComboBox;
    CheckBox1: TCheckBox;
    Timer1: TTimer;
    Button3: TButton;
    Label1: TLabel;
    GroupBox1: TGroupBox;
    Button4: TButton;
    GroupBox2: TGroupBox;
    Button2: TButton;
    CheckBox2: TCheckBox;
    ComboBoxSelector: TComboBox;
    ComboBoxKey: TComboBox;
    Label2: TLabel;
    TimerRepeat: TTimer;
    ListBox1: TListBox;
    Button5: TButton;
    Button6: TButton;
    TimerEndlessRepeater: TTimer;
    CheckBox3: TCheckBox;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure TimerRepeatTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure AppGetFocus(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure TimerEndlessRepeaterTimer(Sender: TObject);
  private
    { Private declarations }
    function ExtractRecordClickPosX:String;
    function ExtractRecordClickPosY:String;
    function ExtractRecordKeyValue:String;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}


//Util Functions----------------------------------------------------------------

procedure EmulateKeyPress(keyIdx:Integer; SelectorIdx: Integer);
var
key: byte;
selector: byte;
begin

if keyIdx<47 then
  begin
  key:=VkKeyScan(Form1.ComboBoxKey.Items.Strings[keyIdx][1]);
  end;

if SelectorIdx = 0 then
  begin
  keybd_event(key, 0, 0, 0);
  keybd_event(key, 0, KEYEVENTF_KEYUP, 0);
  end
else
if SelectorIdx <4 then
  begin
  case SelectorIdx of
    1: selector:= VK_SHIFT;
    2: selector:= VK_CONTROL;
    3: selector:= VK_MENU;
  end;

  keybd_event(selector, MapVirtualKey(selector, 0), 0, 0);
  keybd_event(key, 0, 0, 0);
  keybd_event(key, 0, KEYEVENTF_KEYUP, 0);
  keybd_event(selector, MapVirtualKey(selector, 0), KEYEVENTF_KEYUP, 0);
  end;
end;

procedure MouseLeftClick();
begin
    Mouse_Event(MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0);
    Mouse_Event(MOUSEEVENTF_LEFTUP, 0, 0, 0, 0);
end;

function TForm1.ExtractRecordClickPosX:String;
begin
result:=copy(memo1.Lines.Strings[memo1.tag],pos('(',memo1.Lines.Strings[memo1.tag])+1,pos(',',memo1.Lines.Strings[memo1.tag])-pos('(',memo1.Lines.Strings[memo1.tag])-1);
end;

function TForm1.ExtractRecordClickPosY:String;
begin
result:=copy(memo1.Lines.Strings[memo1.tag],pos(',',memo1.Lines.Strings[memo1.tag])+1,pos(')',memo1.Lines.Strings[memo1.tag])-pos(',',memo1.Lines.Strings[memo1.tag])-1);
end;

function TForm1.ExtractRecordKeyValue:String;
begin
result:=copy(memo1.Lines.Strings[memo1.tag],pos('(',memo1.Lines.Strings[memo1.tag])+1,pos(')',memo1.Lines.Strings[memo1.tag])-pos('(',memo1.Lines.Strings[memo1.tag])-1);
end;


function SetMiliSecMultiplier(multiplier:String):Integer;
var i:Integer;
begin
if multiplier='sec' then i:=1*1000 else
 if multiplier='min' then i:=60*1000 else
  if multiplier='hrs' then i:=3600*1000 else
   if multiplier='mil' then i:=1;
result:=i;
end;

function PreSetCurrentTimerInterval():Integer;
var
i:integer;
time:integer;
begin
  with Form1 do
    begin
    i:= SetMiliSecMultiplier( copy(memo1.Lines.Strings[memo1.tag],pos(']',memo1.Lines.Strings[memo1.tag])+2, 3) );    //s = sec,min,hrs
    time:=strtoint(copy(memo1.Lines.Strings[memo1.tag],pos('[',memo1.Lines.Strings[memo1.tag])+1,pos(']',memo1.Lines.Strings[memo1.tag])-pos('[',memo1.Lines.Strings[memo1.tag])-1));
    result:= i*time;      // 1000*sec1min60hrs3600*val3min //1500;  //as if we picked 1,5 sec
    end;
end;

function NextExecutionTime():String;
begin
result:= TimeToStr(IncMilliSecond(now, Form1.Timer1.Interval));
end;

//Form Controls-----------------------------------------------------------------


procedure TForm1.Button1Click(Sender: TObject);    //Mouse Pos
var p:TPoint;
begin
GetCursorPos(p);
Edit1.Text:=inttostr(p.X);
Edit2.Text:=inttostr(p.Y);
end;

procedure TForm1.Button2Click(Sender: TObject);     //Add Mouse Click
var i:integer;
begin
if Combobox1.ItemIndex=0 then    //every
  begin
  memo1.Lines.Add(Combobox1.Text+' ['+edit3.text+'] '+Combobox2.Text+' -> click('+edit1.Text+','+edit2.Text+')' );
  case combobox2.ItemIndex of
   0: i:=1000*1;
   1: i:=1000*60;
   2: i:=1000*3600;
   3: i:=1;
   end;
  timerRepeat.Interval:=strtoint(Edit3.text)*i;
  end
else if Combobox1.ItemIndex=1 then//interval
  begin
  memo1.Lines.Add(Combobox1.Text+' ['+edit3.text+'] '+Combobox2.Text +' -> click('+edit1.Text+','+edit2.Text+')' );
  timer1.Interval:=1000;
  end
else if Combobox1.ItemIndex=2 then //repeat
  begin
  memo1.Lines.Add('Repeat');
  end
else if Combobox1.ItemIndex=3 then //OnCapsTurnOff
  begin
  memo1.Lines.Add('OnCapsTurnOff');
  end
else if Combobox1.ItemIndex=4 then //capsAuto
  begin
  memo1.Clear;
  memo1.Lines.Add('CapsAuto Mode');
  Edit1.Clear;
  Edit2.Clear;
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);         //Timer On-Off
begin
if Memo1.Lines.Strings[0] = 'Memo1' then
  begin
  if Button3.Caption='Turn Off' then
   begin
   Timer1.Enabled:=false;
   TimerEndlessRepeater.Enabled:=false;
   Button3.Caption:='Turn On';
   end
  else
   begin
   Button3.Caption:='Turn Off';
   memo1.Tag:=0;
   Timer1.Interval:=2000;
   Timer1.Enabled:=True;
   end;
  end
else if Memo1.Lines.Strings[0] = 'CapsAuto Mode' then
  begin
  if Button3.Caption='Turn Off' then
   begin
   Timer1.Enabled:=false;
   TimerEndlessRepeater.Enabled:=false;
   Button3.Caption:='Turn On';
   end
  else
   begin
   Button3.Caption:='Turn Off';
   Memo1.Tag:=1;
   Edit1.Text:=ExtractRecordClickPosX;
   Edit2.Text:=ExtractRecordClickPosY;
   TimerEndlessRepeater.Interval:= PreSetCurrentTimerInterval;
   TimerEndlessRepeater.Enabled:=true;
   Label1.Caption:='Line'+intToStr(Memo1.Tag)+' executed at: '+TimeToStr(now);
   end;
  end;
end;

function CurrentScriptType:String;
begin
if pos('Every',Form1.Memo1.Lines.Strings[Form1.Memo1.Tag])>0 then
  result:= 'Every'
else if pos('Interval',Form1.Memo1.Lines.Strings[Form1.Memo1.Tag])>0 then
  result:= 'Interval'
else if pos('Repeat',Form1.Memo1.Lines.Strings[Form1.Memo1.tag])>0 then
  result:= 'Repeat'
else if pos('OnCapsTurnOff',Form1.Memo1.Lines.Strings[Form1.Memo1.tag])>0 then
  result:='OnCapsTurnOff'
else
  result:= 'Eof';
end;

procedure ExecuteEveryScript();
begin
with Form1 do
begin
 Edit1.Text:=ExtractRecordClickPosX;
 Edit2.Text:=ExtractRecordClickPosY;
 TimerRepeat.Interval:= PreSetCurrentTimerInterval;
 TimerRepeat.Enabled:=true;
 Label1.Caption:='Line'+intToStr(Memo1.Tag)+' executed at: '+TimeToStr(now);
 end;
end;

procedure ExecuteIntervalScript();
var
s:string;
begin
with Form1 do
 begin
 if pos('click',Memo1.Lines.Strings[Memo1.tag])>0 then
   begin
   if checkbox3.Checked then
     begin
     Edit1.Tag:=Mouse.CursorPos.X;
     Edit2.Tag:=Mouse.CursorPos.Y;
     end;
   Edit1.Text:=ExtractRecordClickPosX;
   Edit2.Text:=ExtractRecordClickPosY;
   SetCursorPos(strtoint(Edit1.text), strtoint(edit2.Text));
   MouseLeftClick();
   if checkbox3.Checked then
     begin
     SetCursorPos(Edit1.Tag, Edit2.Tag);
     end;
   end
 else if pos('key',memo1.Lines.Strings[memo1.tag])>0 then
   begin
   s:=copy(memo1.Lines.Strings[memo1.tag],pos('+',memo1.Lines.Strings[memo1.tag])+1,255);
   EmulateKeyPress(ComboboxKey.Items.IndexOf(ExtractRecordKeyValue), ComboboxSelector.Items.IndexOf(s));
   end;
 Label1.Caption:='Line'+intToStr(Memo1.Tag)+' executed at: '+TimeToStr(now);
 end;
end;

procedure RestartMemoRunner();
begin
Form1.Memo1.Tag:=-1;
Form1.Timer1.Interval:= 1000;
end;

procedure StopMemoRunner();
begin
Form1.Timer1.Enabled:=false;
Form1.TimerRepeat.Enabled:=false;
Form1.TimerEndlessRepeater.Enabled:=false;
Form1.Button3.Caption:='Turn On';
end;

procedure ExecuteMemoLine();
begin
 if CurrentScriptType='Every' then
   ExecuteEveryScript()
 else if CurrentScriptType='Interval' then
   ExecuteIntervalScript()
 else if CurrentScriptType='Repeat' then
   RestartMemoRunner()
 else if (CurrentScriptType='OnCapsTurnOff') then
  begin
  if (GetKeyState(VK_CAPITAL)=1) then
   begin
   StopMemoRunner();
   Form1.Label2.Caption:= 'Interrupted by CapsLock on line '+intToStr(Form1.Memo1.Tag)+'!';
   end;
  end 
 else //eof
   begin
   StopMemoRunner();
   Form1.Label2.Caption:= 'All operations finished!';
   end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
TimerRepeat.Enabled:=false;
if Memo1.Tag>0 then
  ExecuteMemoLine();
Memo1.Tag:= Memo1.Tag+1;

if (CurrentScriptType='Interval') then
  Timer1.Interval:= PreSetCurrentTimerInterval
else //every, repeat, eof, OnCapsTurnOff
  Timer1.Interval:= 1000;
end;

procedure TForm1.Button4Click(Sender: TObject);   //Add key Press
var i:integer;
begin
if Combobox1.ItemIndex=0 then    //every
  begin
  memo1.Lines.Add(Combobox1.Text+' '+edit3.text+' '+Combobox2.Text);
  case combobox2.ItemIndex of
   0: i:=1;
   1: i:=60;
   2: i:=3600;
   end;
  timer1.Interval:=1000*strtoint(Edit3.text)*i;
  timer1.Enabled:=true;
  end
else if Combobox1.ItemIndex=1 then//interval
  begin
  memo1.Lines.Add(Combobox1.Text+' ['+edit3.text+'] '+Combobox2.Text +' -> key('+ComboboxKey.Text+')+'+ComboBoxSelector.Text );
  timer1.Interval:=1000;
  end
else if Combobox1.ItemIndex=2 then //repeat
  begin
  memo1.Lines.Add('Repeat');
  end
end;

procedure TForm1.TimerRepeatTimer(Sender: TObject);
begin
  SetCursorPos(strtoint(Edit1.text), strtoint(edit2.Text));
  MouseLeftClick();

  if GetKeyState(VK_ESCAPE)=1 then
   begin
   TimerRepeat.Enabled:=false;
   end;

end;

procedure TForm1.FormCreate(Sender: TObject);
begin
Application.OnActivate := AppGetFocus;
if fileExists('SCRIPTS_LIST') then
  Listbox1.Items.LoadFromFile('SCRIPTS_LIST');
end;

procedure TForm1.AppGetFocus(Sender: TObject);
begin
 TimerRepeat.Enabled:=false;
end;

procedure TForm1.Button5Click(Sender: TObject);       //Add Script
var
s:string;
begin
s:=inputbox( 'Save script', 'Script name', '');
if fileexists(s) then
  ShowMessage('Script name already in list!')
else
  begin
  Memo1.Lines.SaveToFile(s);
  Listbox1.Items.Add(s);
  Listbox1.Items.SaveToFile('SCRIPTS_LIST');
  end;
end;

procedure TForm1.ListBox1Click(Sender: TObject);
var
s:string;
begin
s:=listbox1.Items.Strings[listbox1.itemindex];
Memo1.Lines.loadFromFile(s);
end;

procedure TForm1.Button6Click(Sender: TObject);       //Update Script
var
s:string;
begin
if listbox1.itemindex>-1 then
  begin
  s:=listbox1.Items.Strings[listbox1.itemindex];
  Memo1.Lines.SaveToFile(s);
  end
else
  beep;
end;

procedure TForm1.TimerEndlessRepeaterTimer(Sender: TObject);
begin
if GetKeyState(VK_CAPITAL)=1 then
   begin
   if length(Edit1.Text)>0 then
     SetCursorPos(strtoint(Edit1.text), strtoint(edit2.Text));
   MouseLeftClick();
   end;
end;

end.
