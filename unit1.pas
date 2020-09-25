unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  USock, functions, ZConnection;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    Label10: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    LabelIpPhone: TLabel;
    LabelInvNumbers: TLabel;
    LabelComputerName: TLabel;
    LabelDescription: TLabel;
    LabelCPU: TLabel;
    LabelCab: TLabel;
    LabelUserName: TLabel;
    LabelIpAddress: TLabel;
    LabelMemory: TLabel;
    LabelOS: TLabel;
    ZConnection: TZConnection;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
var
  ipAddress: String;
begin
  ipAddress := '';
  EnumInterfaces(ipAddress);
  LabelComputerName.Caption := GetEnvironmentVariable('COMPUTERNAME');
  LabelDescription.Caption := GetComputerNetDescription;
  LabelUserName.Caption := GetEnvironmentVariable('USERNAME');
  LabelIpAddress.Caption := ipAddress;
  LabelMemory.Caption := IntToStr(GetRAM div 1024 div 1024);
  LabelOS.Caption := GetOS;
  LabelCPU.Caption := GetProcessorInfo;
  LabelCab.Caption := GetEnvironment('CABINET');
  LabelIpPhone.Caption := GetEnvironment('IP_PHONE');
  LabelInvNumbers.Caption := GetEnvironment('INV_NUMBERS');
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  ZConnection.Connect;
  if ZConnection.Connected = true then ShowMessage('Connected');
end;

end.

