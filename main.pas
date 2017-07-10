unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
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
    procedure MenuFileDirClick(Sender: TObject);
    procedure MenuModeClick(Sender: TObject);
    procedure MenuOpenClick(Sender: TObject);
    procedure MenuCloseClick(Sender: TObject);
  private
    { private declarations }
    procedure initBigSmall;
    procedure initDrum;
    procedure initCountDown;
    procedure initKlin;
    procedure initBlackWhite;
    procedure initShulte;
    procedure initElephant;
    procedure initKenga;
    procedure initZaya;
    procedure initScaner;
    procedure initRainbow;

    procedure drowCell(x, y, i: integer);

  public
    { public declarations }
  end;

var
  Form1: TForm1;
  step: integer = 50;
  n: integer = 25;

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

procedure TForm1.MenuCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TForm1.MenuModeClick(Sender: TObject);
begin
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

procedure TForm1.initBigSmall;
begin

end;

procedure TForm1.initBlackWhite;
begin

end;

procedure TForm1.initCountDown;
begin

end;

procedure TForm1.initDrum;
begin

end;

procedure TForm1.initElephant;
begin

end;

procedure TForm1.initKlin;
begin

end;

procedure TForm1.initZaya;
begin

end;

procedure TForm1.initKenga;
begin

end;

procedure TForm1.initRainbow;
begin

end;

procedure TForm1.initScaner;
begin

end;

procedure TForm1.initShulte;

var
  sh, t_sh: array [1..25] of integer;
  i, j, ri, c : integer;
begin
  Randomize;
  for i:=1 to n do
    t_sh[i]:=i;
  c:=n;

  for i:=1 to n do
    begin
      ri:=random(c)+1;
      sh[i]:=t_sh[ri];
      for j:=ri to c-1 do
        t_sh[j]:=t_sh[j+1];
      c:=c-1;
		end;

  ri:=1;
  for i:=1 to 5 do
    for j:=1 to 5 do
      begin
        drowCell(2*step*i, 2*step*j, sh[ri]);
        inc(ri);
		  end;
end;

procedure TForm1.drowCell(x, y, i: integer);
begin
  Form1.Canvas.Pen.Width:=2;
  Form1.Canvas.Pen.Color:=clBlack;
  Form1.Canvas.Pen.Style:=psSolid;

  Form1.Canvas.Font.Name:='Tahoma';
  Form1.Canvas.Font.Size:=14;

  Form1.Canvas.Rectangle(x, y, x + 2*step + Form1.Canvas.Pen.Width, y + 2*step + Form1.Canvas.Pen.Width);
  Form1.Canvas.TextOut(x+step-Form1.Canvas.TextWidth(IntToStr(i)) div 2, y+step-Form1.Canvas.TextHeight(IntToStr(i)) div 2 , IntToStr(i));

end;

end.


