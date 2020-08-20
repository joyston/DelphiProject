object dbmodule: Tdbmodule
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 331
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
    Left = 152
    Top = 88
  end
  object dsUsers: TDataSource
    DataSet = tblUsers
    Left = 232
    Top = 40
  end
  object qryDiary: TFDQuery
    Connection = mainConnection
    Left = 144
    Top = 200
  end
  object dsDiary: TDataSource
    DataSet = tblDiary
    Left = 224
    Top = 232
  end
  object tblDiary: TFDTable
    IndexFieldNames = '_id'
    Connection = mainConnection
    UpdateOptions.UpdateTableName = 'diarydb.diary'
    TableName = 'diarydb.diary'
    Left = 144
    Top = 264
    object tblDiary_id: TFDAutoIncField
      FieldName = '_id'
      Origin = '_id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object tblDiaryuser_fkid: TIntegerField
      FieldName = 'user_fkid'
      Origin = 'user_fkid'
      Required = True
    end
    object tblDiarylogdate: TDateField
      AutoGenerateValue = arDefault
      FieldName = 'logdate'
      Origin = 'logdate'
    end
    object tblDiarylog: TStringField
      FieldName = 'log'
      Origin = 'log'
      Required = True
      Size = 500
    end
    object tblDiarylogtime: TTimeField
      FieldName = 'logtime'
      Origin = 'logtime'
      Required = True
      DisplayFormat = 'hh:mm'
    end
  end
  object tblUsers: TFDTable
    Connection = mainConnection
    Left = 152
    Top = 16
  end
end
