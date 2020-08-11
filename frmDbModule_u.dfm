object dbmodule: Tdbmodule
  OldCreateOrder = False
  Height = 276
  Width = 495
  object mainConnection: TFDConnection
    ConnectionName = 'StudentConnection'
    Params.Strings = (
      'Server='
      'Port='
      'DriverID=MySQL')
    LoginPrompt = False
    Left = 56
    Top = 104
  end
  object qryUsers: TFDQuery
    Connection = mainConnection
    SQL.Strings = (
      'Select * From users;')
    Left = 168
    Top = 56
  end
  object dsUsers: TDataSource
    DataSet = qryUsers
    Left = 232
    Top = 56
  end
  object qryDiary: TFDQuery
    Connection = mainConnection
    SQL.Strings = (
      'Select * from diary;')
    Left = 160
    Top = 160
  end
  object dsDiary: TDataSource
    DataSet = qryDiary
    Left = 232
    Top = 160
  end
end
