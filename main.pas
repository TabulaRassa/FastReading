unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Menus;

type

  { TForm1 }

  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuFileDir: TMenuItem;
    MenuKlin: TMenuItem;
    MenuBigSmall: TMenuItem;
    MenuBlackWhite: TMenuItem;
    MenuKenga: TMenuItem;
    MenuCountdown: TMenuItem;
    MenuElephant: TMenuItem;
    MenuShulte: TMenuItem;
    MenuRainbow: TMenuItem;
    MenuScaner: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuOpen: TMenuItem;
    MenuItem5: TMenuItem;
    MenuClose: TMenuItem;
    MenuItem7: TMenuItem;
    MenuHorizDrum: TMenuItem;
    MenuZaya: TMenuItem;
    OpenDialog1: TOpenDialog;
		Panel1: TPanel;
    SelectDirectoryDialog1: TSelectDirectoryDialog;
		Timer1: TTimer;
		procedure FormCreate(Sender: TObject);
		procedure FormPaint(Sender: TObject);
    procedure MenuFileDirClick(Sender: TObject);
    procedure MenuModeClick(Sender: TObject);
    procedure MenuOpenClick(Sender: TObject);
    procedure MenuCloseClick(Sender: TObject);
		procedure Timer1Timer(Sender: TObject);

  private
    { private declarations }

    procedure Shuffle(Sender: TObject);
    procedure initShulte;
    procedure createShulte(need_recalc: boolean);
    procedure initBlackWhite;
    procedure createBlackAndWhite(need_recalc: boolean);
    procedure initKlin;
    procedure createKlin(need_recalc: boolean);
    procedure initBigSmall;
    procedure initDrum;
    procedure initCountDown;
    procedure initElephant;
    procedure initKenga;
    procedure initZaya;
    procedure initScaner;
    procedure initRainbow;
    procedure drowCell(x, y, i: integer);
    procedure clearPanel;

    procedure TimerClick(Sender: TObject);

  public
    { public declarations }

  end;

var
  Form1: TForm1;
  step: integer;
  n: integer;
  sec, milisec: integer;

  sh, t_sh: array [1..64] of integer;
  mode : string;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.MenuOpenClick(Sender: TObject);
begin
  if Form1.OpenDialog1.Execute then
  begin
     Form1.Caption:=Form1.Caption + ': ' + OpenDialog1.FileName;
  end;
  OpenDialog1.Free;
end;

procedure TForm1.MenuFileDirClick(Sender: TObject);
begin
  if SelectDirectoryDialog1.Execute then
  begin
     OpenDialog1.InitialDir:=SelectDirectoryDialog1.FileName;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  n := 5;
  step := 40;
end;

procedure TForm1.FormPaint(Sender: TObject);
var
  i : byte;
  ch_name : string;
begin
  for i := 0 to MainMenu1.Items[1].Count - 1 do
    if MainMenu1.Items[1].Items[i].Checked then
      begin
         ch_name := MainMenu1.Items[1].Items[i].Name;
         break;
			end;
  case ch_name of
    'MenuHorizDrum': initDrum;
    'MenuCountdown': initCountdown;
    'MenuBigSmall': initBigSmall;
    'MenuBlackWhite': createBlackAndWhite(false);
    'MenuElephant': initElephant;
    'MenuKenga': initKenga;
    'MenuKlin': initKlin;
    'MenuRainbow': initRainbow;
    'MenuScaner': initScaner;
    'MenuShulte': createShulte(false);
    'MenuZaya': initZaya;
	end;
end;

procedure TForm1.MenuCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TForm1.Timer1Timer(Sender: TObject);

begin
  inc(sec);
  case mode of
    'shulte' : Panel1.Controls[3].Caption:=IntToStr(sec); // + ':' + IntToStr(milisec);
    'black&white' : Panel1.Controls[2].Caption:=IntToStr(sec); // + ':' + IntToStr(milisec);
	end;
end;

procedure TForm1.TimerClick(Sender: TObject);
begin
  if Timer1.Enabled then
    begin
       Timer1.Enabled:=false;
       sec:=0;
       milisec:=0;
		end
  else
  begin
    case mode of
      'shulte' : Form1.Panel1.Controls[3].Caption:='0';
      'black&white' : Form1.Panel1.Controls[2].Caption:='0';
  	end;
    Timer1.Enabled:=true;
	end;

end;

procedure TForm1.MenuModeClick(Sender: TObject);
begin
  if Timer1.Enabled then
    begin
      Timer1.Enabled:=false;
      SEC := 0;
		end;

  TMenuItem (Sender).Checked:=true;
  case TMenuItem (Sender).Name of
    'MenuHorizDrum': initDrum;
    'MenuCountdown': initCountdown;
    'MenuBigSmall': initBigSmall;
    'MenuBlackWhite': initBlackWhite;
    'MenuElephant': initElephant;
    'MenuKenga': initKenga;
    'MenuKlin': initKlin;
    'MenuRainbow': initRainbow;
    'MenuScaner': initScaner;
    'MenuShulte': initShulte;
    'MenuZaya': initZaya;
  end;

end;

procedure TForm1.clearPanel;
var
  i : byte;
  cont :TControl;
begin
  Canvas.Clear;
  if Panel1.ControlCount > 0 then
  for i:=(Panel1.ControlCount - 1) downto 0 do
    begin
      cont:=Panel1.Controls[i];
      cont.Parent:=nil;
      cont.free;
		end;
end;

procedure TForm1.Shuffle(Sender: TObject);
begin
  Form1.Canvas.Clear;
  case mode of
  'black&white' : createBlackAndWhite(true);
  'shulte' : createShulte(true);
  end;
  if Form1.Timer1.Enabled then
    begin
       Form1.Timer1.Enabled:=false;
       sec:=0;
       milisec:=0;
       case mode of
        'shulte' : Form1.Panel1.Controls[3].Caption:='0';
        'black&white' : Form1.Panel1.Controls[2].Caption:='0';
			 end;
		end
end;

procedure TForm1.initShulte;

var
  Radio:TRadioGroup;
  ButtonSH, ButtonST :TButton;
  TimeStr: TLabel;
begin
  clearPanel;

  with Panel1 do
  begin
    Left := 0;
    Height := 80;
    Top := 573;
    Width := 1055;
    Align := alBottom;
    BevelInner := bvRaised;
    Color := clSilver;
    ParentColor := False;
    TabOrder := 0;
	end;
  Radio:=TRadioGroup.Create(Panel1);

  with Radio do
  begin
    Parent:=Panel1;
    Items.Add('3');
    Items.Add('5');
    Items.Add('7');
    AutoSize:=true;
    ItemIndex:=1;
    Columns:=3;
    Caption:='Размер';
    Left:=20;
    Top:=15;
	end;
  Radio.OnClick:=@Shuffle;

  ButtonSH:=Tbutton.Create(Panel1);
  with ButtonSH do
  begin
    Parent:=Panel1;
    Caption:='Перемешать';
    left:=150;
    top:=25;
    Color := clSilver;
    ParentColor := False;
    OnClick:=@Shuffle;
	end;

  ButtonST:=Tbutton.Create(Panel1);
  with ButtonST do
  begin
    Parent:=Panel1;
    Caption:='Время';
    left:=250;
    top:=25;
    Color := clSilver;
    ParentColor := False;
    OnClick:=@Form1.TimerClick;
	end;

  TimeStr:=TLabel.Create(Panel1);
  with TimeStr do
  begin
    Parent:=Panel1;
    Left:=350;
    top:=25;
    Width:=30;
    Font.Size:=14;
    Caption:='0';
	end;

  createShulte(true);
end;

procedure TForm1.createShulte(need_recalc: boolean);
var
  i, j, ri, c,
    sh_x, sh_y, screen_w, screen_h : integer;
begin
  Canvas.Clear;
  mode := 'shulte';
  if need_recalc  then
  begin
    n:=StrToInt((Form1.Panel1.Controls[0] as TRadioGroup).Items[(Panel1.Controls[0] as TRadioGroup).ItemIndex]);
    Randomize;
    c:=n*n;
    for i:=1 to c do
      t_sh[i]:=i;

    for i:=1 to c do
    begin
      ri:=random(c)+1;
      sh[i]:=t_sh[ri];
      for j:=ri to c-1 do
        t_sh[j]:=t_sh[j+1];
      c:=c-1;
    end;
  end;

  ri:=1;
  screen_w := Canvas.Width div (n);
  screen_h := (Canvas.Height - Panel1.Height) div (n);
  if screen_w > screen_h then
    step := screen_h
  else
    step := screen_w;

  sh_x := (Canvas.Width div 2) - step * (n div 2) - step div 2;

  for i:=1 to n do
  begin
    sh_y := ((Canvas.Height - Panel1.Height) div 2) - step * (n div 2) - step div 2;
    for j:=1 to n do
      begin
        drowCell(sh_x, sh_y, sh[ri]);
        inc(ri);
        sh_y := sh_y + step;
		  end;
      sh_x := sh_x + step;
	end;
end;

procedure TForm1.drowCell(x, y, i: integer);
begin

  Form1.Canvas.Pen.Width:=2;
  Form1.Canvas.Pen.Color:=clBlack;
  Form1.Canvas.Pen.Style:=psSolid;
  Form1.Canvas.Font.Name:='Tahoma';
  Form1.Canvas.Font.Size:=14;

  Form1.Canvas.Rectangle(x, y, x + step + Canvas.Pen.Width, y + step + Canvas.Pen.Width);
  if mode = 'shulte' then
  begin
    Form1.Canvas.Font.Color:=clBlack;
    Form1.Canvas.TextOut(x + step div 2 - Canvas.TextWidth(IntToStr(i)) div 2,
                         y + step div 2 - Canvas.TextHeight(IntToStr(i)) div 2 , IntToStr(i));
  end
  else
  begin
    if i <> 0 then
    begin
      if i > 25 then
      begin
        Form1.Canvas.Font.Color:=clBlack;
        Form1.Canvas.TextOut(x + step div 2 - Canvas.TextWidth(IntToStr(i)) div 2,
                             y + step div 2 - Canvas.TextHeight(IntToStr(i)) div 2 , IntToStr(i - 25))
      end
      else
      begin
        Form1.Canvas.Font.Color:=clGray;
        Form1.Canvas.TextOut(x + step div 2 - Canvas.TextWidth(IntToStr(i)) div 2,
                             y + step div 2 - Canvas.TextHeight(IntToStr(i)) div 2 , IntToStr(i))
      end;
    end;
  end;

end;

procedure TForm1.initBlackWhite;
var
  ButtonBW, ButtonST :TButton;
  TimeStr: TLabel;
begin
  clearPanel;

  ButtonBW:=Tbutton.Create(Panel1);
  with ButtonBW do
  begin
    Parent:=Panel1;
    Caption:='Перемешать';
    left:=150;
    top:=25;
    Color := clSilver;
    ParentColor := False;
    OnClick:=@Shuffle;
	end;

  ButtonST:=Tbutton.Create(Panel1);
  with ButtonST do
  begin
    Parent:=Panel1;
    Caption:='Время';
    left:=250;
    top:=25;
    Color := clSilver;
    ParentColor := False;
    OnClick:=@Form1.TimerClick;
	end;

  TimeStr:=TLabel.Create(Panel1);
  with TimeStr do
  begin
    Parent:=Panel1;
    Left:=350;
    top:=25;
    Width:=30;
    Font.Size:=14;
    Caption:='0';
	end;

  createBlackAndWhite(true);
end;

procedure Tform1.createBlackAndWhite(need_recalc: boolean);
var
  i, j, ri, c,
    sh_x, sh_y, screen_w, screen_h : integer;
begin
  Canvas.Clear;
  mode := 'black&white';
  if need_recalc  then
  begin
    n:=8;
    Randomize;
    c:=n*n;
    for i:=1 to 50 do
      t_sh[i]:=i;

    for i:=1 to c do
    begin
      ri:=random(c)+1;
      sh[i]:=t_sh[ri];
      for j:=ri to c-1 do
        t_sh[j]:=t_sh[j+1];
      c:=c-1;
    end;
  end;

  ri:=1;
  screen_w := Canvas.Width div (n);
  screen_h := (Canvas.Height - Panel1.Height) div (n);
  if screen_w > screen_h then
    step := screen_h
  else
    step := screen_w;

  sh_x := (Canvas.Width div 2) - step * (n div 2);

  for i:=1 to n do
  begin
    sh_y := ((Canvas.Height - Panel1.Height) div 2) - step * (n div 2);
    for j:=1 to n do
      begin
        drowCell(sh_x, sh_y, sh[ri]);
        inc(ri);
        sh_y := sh_y + step;
      end;
      sh_x := sh_x + step;
  end;

end;

procedure TForm1.initKlin;
var
  Radio, Radio2 :TRadioGroup;
  ButtonSH, ButtonST :TButton;
  TempStr: TLabeledEdit;
begin
  clearPanel;

  with Panel1 do
  begin
    Left := 0;
    Height := 80;
    Top := 573;
    Width := 1055;
    Align := alBottom;
    BevelInner := bvRaised;
    Color := clSilver;
    ParentColor := False;
    TabOrder := 0;
	end;

  Radio:=TRadioGroup.Create(Panel1);
  with Radio do
  begin
    Parent:=Panel1;
    Items.Add('Горизонтальные');
    Items.Add('Вертикальные');
    AutoSize:=true;
    ItemIndex:=1;
    Columns:=1;
    Caption:='Режим';
    Left:=20;
    Top:=8;
	end;
  Radio.OnClick:=@Shuffle;

  Radio2:=TRadioGroup.Create(Panel1);
  with Radio2 do
  begin
    Parent:=Panel1;
    Items.Add('1');
    Items.Add('2');
    Items.Add('3');
    Items.Add('4');
    Items.Add('5');
    Items.Add('6');
    AutoSize:=true;
    ItemIndex:=1;
    Columns:=3;
    Caption:='Строк';
    Left:=170;
    Top:=8;
	end;
  Radio.OnClick:=@Shuffle;

  ButtonSH:=Tbutton.Create(Panel1);
  with ButtonSH do
  begin
    Parent:=Panel1;
    Caption:='Перемешать';
    left:=300;
    top:=25;
    Color := clSilver;
    ParentColor := False;
    OnClick:=@Shuffle;
	end;

  ButtonST:=Tbutton.Create(Panel1);
  with ButtonST do
  begin
    Parent:=Panel1;
    Caption:='Старт';
    left:=400;
    top:=25;
    Color := clSilver;
    ParentColor := False;
    OnClick:=@Form1.TimerClick;
	end;

  TempStr :=TLabeledEdit.Create(Panel1);
  with TempStr do
  begin
    Parent:=Panel1;
    Left:=530;
    top:=25;
    Width:=30;
    LabelPosition:=lpLeft;
    Font.Size:=10;
    EditLabel.Caption:='Темп  ';
	end;

  createKlin(true);
end;

procedure TForm1.createKlin(need_recalc: boolean);
begin

end;

procedure TForm1.initBigSmall;
begin
  clearPanel;
end;

procedure TForm1.initCountDown;
begin
  clearPanel;
end;

procedure TForm1.initDrum;
begin
  clearPanel;
end;

procedure TForm1.initElephant;
begin
  clearPanel;
end;
procedure TForm1.initZaya;
begin
  clearPanel;
end;

procedure TForm1.initKenga;
begin
  clearPanel;
end;

procedure TForm1.initRainbow;
begin
  clearPanel;
end;

procedure TForm1.initScaner;
begin
  clearPanel;
end;

end.


