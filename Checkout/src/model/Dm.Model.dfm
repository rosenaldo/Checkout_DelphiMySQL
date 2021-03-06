object MODEL: TMODEL
  OldCreateOrder = False
  Height = 528
  Width = 728
  object FDConnection: TFDConnection
    Params.Strings = (
      'Database=PDV'
      'User_Name=root'
      'DriverID=MySQL')
    Connected = True
    LoginPrompt = False
    Left = 40
    Top = 24
  end
  object FDT_CARGOS: TFDTable
    Active = True
    IndexFieldNames = 'id'
    Connection = FDConnection
    UpdateOptions.UpdateTableName = 'PDV.cargos'
    TableName = 'PDV.cargos'
    Left = 32
    Top = 152
  end
  object FDQ_CARGOS: TFDQuery
    Active = True
    Connection = FDConnection
    SQL.Strings = (
      'SELECT ID,'
      'CARGO'
      'FROM CARGOS')
    Left = 32
    Top = 224
    object FDQ_CARGOSID: TFDAutoIncField
      DisplayLabel = 'Cod.'
      FieldName = 'ID'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object FDQ_CARGOSCARGO: TStringField
      DisplayLabel = 'Cargo'
      FieldName = 'CARGO'
      Origin = 'cargo'
      Required = True
      Size = 25
    end
  end
  object DS_CARGOS: TDataSource
    DataSet = FDQ_CARGOS
    Left = 32
    Top = 304
  end
end
