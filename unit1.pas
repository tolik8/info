unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ComCtrls,
  ExtCtrls, functions, fphttpclient, fpjson, jsonparser, UxTheme;

const url = 'http://10.19.19.121/';

type

  { TForm1 }

  TForm1 = class(TForm)
    ButtonGetData: TButton;
    EditCabinet: TEdit;
    EditComputerName: TEdit;
    EditCPU: TEdit;
    EditDescription: TEdit;
    EditFIO: TEdit;
    EditInvNumbers: TEdit;
    EditIpAddress: TEdit;
    EditIpPhone: TEdit;
    EditMemory: TEdit;
    EditResolution: TEdit;
    EditOS: TEdit;
    EditTaxBlockLogin: TEdit;
    EditUserName: TEdit;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    PageControl1: TPageControl;
    Panel1: TPanel;
    StatusBar: TStatusBar;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Timer1: TTimer;
    procedure ButtonGetDataClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure FixPageControl(ACtrl: TObject);
begin
  if ACtrl is TPageControl then
    UxTheme.SetWindowTheme(TPageControl(ACtrl).Handle, NIL, '');
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Form1.Caption := 'Info v1.0';
  StatusBar.SimpleText := 'Build 2020-10-05 Development by Turkevych Anatoliy';

  FixPageControl(PageControl1);
  TabSheet1.Color:= TColor($000BD7D1);
  TabSheet2.Color:= TColor($000BD7D1);

  EditComputerName.Caption := GetEnvironmentVariable('COMPUTERNAME');
  EditDescription.Caption := GetComputerNetDescription;
  EditUserName.Caption := GetEnvironmentVariable('USERNAME');
  EditIpAddress.Caption := GetIpAddress;
  EditMemory.Caption := FloatToStr(GetMemory);
  EditOS.Caption := GetOS + 'x' + GetBit + GetOSVersion;
  EditCPU.Caption := GetProcessorInfo;
  EditResolution.Caption := IntToStr(Screen.Width) + 'x' + IntToStr(Screen.Height);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  ButtonGetData.Enabled := true;
  Timer1.Enabled := false;
end;

procedure TForm1.ButtonGetDataClick(Sender: TObject);
var rawJson: AnsiString;
  link: String;
  user: TJSONObject;
begin
  ButtonGetData.Enabled := false;
  Timer1.Enabled := true;
  Application.ProcessMessages;

  link := url + 'json/?pc=' + EditComputerName.Caption;
  rawJson := '';

  // Get the JSON data
  try
    rawJson := TFPHTTPClient.SimpleGet(link);
  except
    ShowMessage('Не вдалося отримати дані з ' + url);
  end;

  if rawJson <> '' then begin
    // Convert to TJSONData and cast as TJSONObject
    user := TJSONObject(GetJSON(rawJson));
    EditTaxBlockLogin.Text := user.FindPath('LOGIN').AsString;
    EditFIO.Text := user.FindPath('FIO').AsString;
    EditCabinet.Text := user.FindPath('KAB').AsString;
    EditIpPhone.Text := user.FindPath('PHONE_IP').AsString;
  end;
end;

end.

