unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    ListBox1: TListBox;
    Button3: TButton;
    Button4: TButton;
    Label2: TLabel;
    Button5: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
procedure TForm1.Button1Click (Sender: TObject);    // показує реальний час
Var lt: TSYSTEMTIME;
st: TSYSTEMTIME;
Begin
 Memo1.Visible:=True;
     Label1.Visible:=False;
      Label2.Visible:=False;
       ListBox1.Visible:=False;
 Memo1.Lines.Clear;
GetLocalTime(lt);
GetSystemTime(st);
Memo1.Lines.Add ( 'LocalTime = ' +
IntToStr ( lt.wmonth) + '/' +
IntToStr ( lt.wDay) + '/' +
IntToStr ( lt.wYear) + ' ' +
IntToStr ( lt.wHour) + ':' +
IntToStr ( lt.wMinute) + ': ' +
IntToStr ( lt.wSecond));
Memo1.Lines.Add ('UTCTime = ' + IntToStr (st.wmonth) + '/' + IntToStr (st.wDay) + '/' + IntToStr (st.wYear) + ' ' + IntToStr (st.wHour) + ':' + IntToStr (st.wMinute) + ': ' + IntToStr (st.wSecond));
end;

procedure TForm1.Button2Click(Sender: TObject);   // відображає ім'я власника компютера
var
  StrUserName: PChar;
  Size: DWord;
begin
 Memo1.Visible:=False;
     Label1.Visible:=True;
      Label2.Visible:=False;
       ListBox1.Visible:=False;
  Size:=250;
  GetMem(StrUserName, Size);
  GetUserName(StrUserName, Size);
  Label1.Caption:='Username is '+StrPas(StrUserName);
  FreeMem(StrUserName);
end;

procedure TForm1.Button3Click(Sender: TObject);          //відображає аквтині програми на пристрої
var
  Wnd: hWnd;
  Buff: array [0..127] of Char;
begin
     Memo1.Visible:=False;
     Label1.Visible:=False;
      Label2.Visible:=False;
       ListBox1.Visible:=True;
  ListBox1.Clear;
  Wnd:=GetWindow(Handle, gw_HWndFirst);
  while Wnd<>0 do
  begin
    if (Wnd<>Application.Handle) and
      IsWindowVisible(Wnd) and
      (GetWindow(Wnd, gw_Owner)=0) and
      (GetWindowText(Wnd, Buff, sizeof(buff))<>0) then
    begin
      GetWindowText(Wnd, Buff, SizeOf(Buff));
      ListBox1.Items.Add(StrPas(Buff));
    end;
    Wnd:=GetWindow(Wnd, gw_hWndNext);
  end;
  ListBox1.ItemIndex:=0;
end;

procedure TForm1.Button4Click(Sender: TObject);     //відображає доступні розкладки на клавіатурі
var
  Count, i: Integer;
  MyLang: PChar;
  Layouts: array [0..16] of Integer;
const
  Size: Integer = 250;
begin
 Memo1.Visible:=True;
     Label1.Visible:=False;
      Label2.Visible:=False;
       ListBox1.Visible:=False;
  GetMem(MyLang, Size);
  Count:=GetKeyboardLayoutList(16, Layouts);
  Memo1.Lines.Clear;
  for i:=0 to Count-1 do
  begin
    VerLanguageName(Layouts[i], MyLang, Size);
    Memo1.Lines.Add(StrPas(MyLang));
  end;
  FreeMem(MyLang);
end;

procedure TForm1.Button5Click(Sender: TObject);  //відображає   назву компютера
 var           //імя компа
  CompName: array[0..256] of Char;
  i: DWord;
begin
 Memo1.Visible:=False;
     Label1.Visible:=False;
      Label2.Visible:=True;
       ListBox1.Visible:=False;
  i:=256;
  GetComputerName(CompName, i);
  Label2.Caption:='Name of laptop is '+StrPas(CompName);
end;


end.
