object frmDiary: TfrmDiary
  Left = 0
  Top = 0
  Caption = 'Diary'
  ClientHeight = 477
  ClientWidth = 708
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = tabDiaryChange
  PixelsPerInch = 96
  TextHeight = 13
  object tabDiary: TPageControl
    Left = 32
    Top = 24
    Width = 585
    Height = 401
    ActivePage = tabAddEdit
    TabOrder = 0
    OnChange = tabDiaryChange
    object tabAddEdit: TTabSheet
      Caption = 'Add/Edit'
      ExplicitLeft = 0
      ExplicitTop = 31
      object lblDate: TLabel
        Left = 32
        Top = 64
        Width = 23
        Height = 13
        Caption = 'Date'
      end
      object lblHour: TLabel
        Left = 32
        Top = 241
        Width = 23
        Height = 13
        Caption = 'Hour'
      end
      object btnAdd: TButton
        Left = 119
        Top = 284
        Width = 185
        Height = 25
        Caption = 'ADD'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Impact'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        OnClick = btnAddClick
      end
      object edtHour: TEdit
        Left = 119
        Top = 241
        Width = 185
        Height = 21
        Hint = 'hh:mm'
        TabOrder = 1
      end
      object memLog: TMemo
        Left = 120
        Top = 96
        Width = 185
        Height = 129
        TabOrder = 0
      end
      object dtLog: TDateTimePicker
        Left = 120
        Top = 56
        Width = 186
        Height = 21
        Date = 44055.000000000000000000
        Time = 0.713046990742441300
        TabOrder = 3
      end
    end
    object tabView: TTabSheet
      Caption = 'View'
      ImageIndex = 1
      object DBGrid1: TDBGrid
        Left = 0
        Top = 0
        Width = 581
        Height = 120
        DataSource = dbmodule.dsDiary
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'logdate'
            Title.Caption = 'Date'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'log'
            Title.Caption = 'Log'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'logtime'
            Title.Caption = 'Time'
            Visible = True
          end>
      end
      object Button1: TButton
        Left = 360
        Top = 296
        Width = 75
        Height = 25
        Caption = 'Edit'
        TabOrder = 1
        OnClick = Button1Click
      end
    end
  end
  object btnLogout: TButton
    Left = 538
    Top = 24
    Width = 75
    Height = 25
    Caption = 'Logout'
    TabOrder = 1
    OnClick = btnLogoutClick
  end
end
