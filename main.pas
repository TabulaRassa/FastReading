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
    procedure MenuCountdownClick(Sender: TObject);
    procedure MenuElephantClick(Sender: TObject);
    procedure MenuFileDirClick(Sender: TObject);
    procedure MenuHorizDrumClick(Sender: TObject);
    procedure MenuKengaClick(Sender: TObject);
    procedure MenuOpenClick(Sender: TObject);
    procedure MenuCloseClick(Sender: TObject);
    procedure MenuRainbowClick(Sender: TObject);
    procedure MenuScanerClick(Sender: TObject);
    procedure MenuShulteClick(Sender: TObject);
    procedure MenuZayaClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;

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

procedure TForm1.MenuHorizDrumClick(Sender: TObject);
begin
  Self.MenuHorizDrum.Checked:=not Self.MenuHorizDrum.Checked;
end;

procedure TForm1.MenuCountdownClick(Sender: TObject);
begin
  MenuCountdown.Checked:=not MenuCountdown.Checked;
end;

procedure TForm1.MenuElephantClick(Sender: TObject);
begin
  MenuElephant.Checked:=not MenuElephant.Checked;
end;

procedure TForm1.MenuFileDirClick(Sender: TObject);
begin
  if SelectDirectoryDialog1.Execute then
  begin
     OpenDialog1.InitialDir:=SelectDirectoryDialog1.FileName;
  end;
end;

procedure TForm1.MenuKengaClick(Sender: TObject);
begin
  MenuKenga.Checked:=not MenuKenga.Checked;
end;

procedure TForm1.MenuCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TForm1.MenuRainbowClick(Sender: TObject);
begin
  MenuRainbow.Checked:=not MenuRainbow.Checked;
end;

procedure TForm1.MenuScanerClick(Sender: TObject);
begin
  MenuScaner.Checked:=not MenuScaner.Checked;
end;

procedure TForm1.MenuShulteClick(Sender: TObject);
begin
  Self.MenuShulte.Checked:=not Self.MenuShulte.Checked;
end;

procedure TForm1.MenuZayaClick(Sender: TObject);
begin
  MenuZaya.Checked:=not MenuZaya.Checked;
end;



end.

