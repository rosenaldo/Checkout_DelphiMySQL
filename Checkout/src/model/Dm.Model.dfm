object Model: TModel
  OldCreateOrder = False
  Height = 514
  Width = 1264
  object fd: TFDConnection
    Params.Strings = (
      'Database=pdv'
      'User_Name=root'
      'DriverID=MySQL')
    LoginPrompt = False
    Left = 40
    Top = 24
  end
  object query_cargos: TFDQuery
    Connection = fd
    SQL.Strings = (
      'select *'
      'from cargos')
    Left = 39
    Top = 177
    object query_cargosid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object query_cargoscargo: TStringField
      FieldName = 'cargo'
      Origin = 'cargo'
      Required = True
      Size = 25
    end
  end
  object tb_cargos: TFDTable
    IndexFieldNames = 'id'
    Connection = fd
    UpdateOptions.UpdateTableName = 'pdv.cargos'
    TableName = 'pdv.cargos'
    Left = 40
    Top = 112
  end
  object DSCargos: TDataSource
    DataSet = query_cargos
    Left = 40
    Top = 240
  end
  object DSUsuarios: TDataSource
    DataSet = query_usuarios
    Left = 130
    Top = 240
  end
  object query_usuarios: TFDQuery
    DetailFields = 'id'
    Connection = fd
    SQL.Strings = (
      'select * from usuarios')
    Left = 120
    Top = 184
    object query_usuariosid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object query_usuariosnome: TStringField
      FieldName = 'nome'
      Origin = 'nome'
      Required = True
      Size = 30
    end
    object query_usuariosusuario: TStringField
      FieldName = 'usuario'
      Origin = 'usuario'
      Required = True
      Size = 25
    end
    object query_usuariossenha: TStringField
      FieldName = 'senha'
      Origin = 'senha'
      Required = True
      Size = 25
    end
    object query_usuarioscargo: TStringField
      FieldName = 'cargo'
      Origin = 'cargo'
      Required = True
      Size = 25
    end
    object query_usuariosid_funcionario: TIntegerField
      FieldName = 'id_funcionario'
      Origin = 'id_funcionario'
      Required = True
    end
  end
  object tb_usuarios: TFDTable
    IndexFieldNames = 'id'
    Connection = fd
    UpdateOptions.UpdateTableName = 'pdv.usuarios'
    TableName = 'pdv.usuarios'
    Left = 123
    Top = 112
  end
  object tb_func: TFDTable
    IndexFieldNames = 'id'
    Connection = fd
    UpdateOptions.UpdateTableName = 'pdv.funcionarios'
    TableName = 'pdv.funcionarios'
    Left = 215
    Top = 114
  end
  object query_func: TFDQuery
    DetailFields = 'id'
    Connection = fd
    SQL.Strings = (
      'select * from funcionarios')
    Left = 214
    Top = 177
    object query_funcid: TFDAutoIncField
      DisplayLabel = 'ID'
      DisplayWidth = 7
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
      Visible = False
    end
    object query_funcnome: TStringField
      DisplayLabel = 'Nome'
      DisplayWidth = 15
      FieldName = 'nome'
      Origin = 'nome'
      Required = True
      Size = 30
    end
    object query_funccpf: TStringField
      DisplayLabel = 'CPF'
      DisplayWidth = 15
      FieldName = 'cpf'
      Origin = 'cpf'
      Required = True
    end
    object query_functelefone: TStringField
      DisplayLabel = 'Telefone'
      FieldName = 'telefone'
      Origin = 'telefone'
      Size = 15
    end
    object query_funcendereco: TStringField
      DisplayLabel = 'Endere'#231'o'
      DisplayWidth = 20
      FieldName = 'endereco'
      Origin = 'endereco'
      Size = 50
    end
    object query_funccargo: TStringField
      DisplayLabel = 'Cargo'
      DisplayWidth = 15
      FieldName = 'cargo'
      Origin = 'cargo'
      Required = True
      Size = 25
    end
    object query_funcdata: TDateField
      DisplayLabel = 'Data'
      FieldName = 'data'
      Origin = 'data'
      Required = True
    end
  end
  object DSFunc: TDataSource
    DataSet = query_func
    Left = 217
    Top = 239
  end
  object TB_EMPRESA: TFDTable
    IndexFieldNames = 'id'
    Connection = fd
    UpdateOptions.UpdateTableName = 'pdv.empresa'
    TableName = 'pdv.empresa'
    Left = 312
    Top = 116
  end
  object Q_EMPRESA: TFDQuery
    DetailFields = 'id'
    Connection = fd
    SQL.Strings = (
      'SELECT * FROM EMPRESA')
    Left = 312
    Top = 178
    object Q_EMPRESAid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object Q_EMPRESArazao_social: TStringField
      FieldName = 'razao_social'
      Origin = 'razao_social'
      Size = 50
    end
    object Q_EMPRESAnome_fantasia: TStringField
      FieldName = 'nome_fantasia'
      Origin = 'nome_fantasia'
      Size = 50
    end
    object Q_EMPRESAendereco: TStringField
      FieldName = 'endereco'
      Origin = 'endereco'
      Size = 100
    end
    object Q_EMPRESAbairro: TStringField
      FieldName = 'bairro'
      Origin = 'bairro'
      Size = 30
    end
    object Q_EMPRESAcidade: TStringField
      FieldName = 'cidade'
      Origin = 'cidade'
      Size = 50
    end
    object Q_EMPRESAuf: TStringField
      FieldName = 'uf'
      Origin = 'uf'
      FixedChar = True
      Size = 2
    end
    object Q_EMPRESAcnpj: TStringField
      FieldName = 'cnpj'
      Origin = 'cnpj'
    end
    object Q_EMPRESAtelefone: TStringField
      FieldName = 'telefone'
      Origin = 'telefone'
      Size = 15
    end
    object Q_EMPRESAie: TStringField
      FieldName = 'ie'
      Origin = 'ie'
      Size = 12
    end
    object Q_EMPRESAemail: TStringField
      FieldName = 'email'
      Origin = 'email'
      Size = 30
    end
  end
  object DS_EMPRESA: TDataSource
    DataSet = Q_EMPRESA
    Left = 312
    Top = 239
  end
  object tb_forn: TFDTable
    IndexFieldNames = 'id'
    Connection = fd
    UpdateOptions.UpdateTableName = 'pdv.fornecedores'
    TableName = 'pdv.fornecedores'
    Left = 403
    Top = 116
  end
  object query_forn: TFDQuery
    DetailFields = 'id'
    Connection = fd
    SQL.Strings = (
      'select * from fornecedores')
    Left = 403
    Top = 177
    object query_fornid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
      Visible = False
    end
    object query_fornnome: TStringField
      DisplayLabel = 'Nome'
      DisplayWidth = 13
      FieldName = 'nome'
      Origin = 'nome'
      Required = True
      Size = 25
    end
    object query_fornproduto: TStringField
      DisplayLabel = 'Produto'
      DisplayWidth = 15
      FieldName = 'produto'
      Origin = 'produto'
      Required = True
      Size = 25
    end
    object query_fornendereco: TStringField
      DisplayLabel = 'Endere'#231'o'
      DisplayWidth = 17
      FieldName = 'endereco'
      Origin = 'endereco'
      Required = True
      Size = 30
    end
    object query_forntelefone: TStringField
      DisplayLabel = 'Telefone'
      DisplayWidth = 16
      FieldName = 'telefone'
      Origin = 'telefone'
      Required = True
      Size = 15
    end
    object query_forndata: TDateField
      DisplayLabel = 'Data de Cadastro'
      DisplayWidth = 12
      FieldName = 'data'
      Origin = 'data'
      Required = True
    end
  end
  object DSForn: TDataSource
    DataSet = query_forn
    Left = 404
    Top = 238
  end
  object tb_produtos: TFDTable
    IndexFieldNames = 'id'
    Connection = fd
    UpdateOptions.UpdateTableName = 'pdv.produtos'
    TableName = 'pdv.produtos'
    Left = 492
    Top = 117
  end
  object query_produtos: TFDQuery
    DetailFields = 'id'
    Connection = fd
    SQL.Strings = (
      'select * from produtos')
    Left = 494
    Top = 178
    object query_produtosid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object query_produtoscodigo: TStringField
      FieldName = 'codigo'
      Origin = 'codigo'
      Required = True
      EditMask = '0000000000000;1;_'
      Size = 50
    end
    object query_produtosnome: TStringField
      FieldName = 'nome'
      Origin = 'nome'
      Required = True
      Size = 25
    end
    object query_produtosdescricao: TStringField
      FieldName = 'descricao'
      Origin = 'descricao'
      Required = True
      Size = 35
    end
    object query_produtosvalor: TBCDField
      FieldName = 'valor'
      Origin = 'valor'
      Required = True
      Precision = 10
      Size = 2
    end
    object query_produtosestoque: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'estoque'
      Origin = 'estoque'
    end
    object query_produtosdata: TDateField
      FieldName = 'data'
      Origin = 'data'
      Required = True
    end
    object query_produtosimagem: TBlobField
      AutoGenerateValue = arDefault
      FieldName = 'imagem'
      Origin = 'imagem'
    end
    object query_produtosultima_compra: TDateField
      AutoGenerateValue = arDefault
      FieldName = 'ultima_compra'
      Origin = 'ultima_compra'
    end
  end
  object DSProdutos: TDataSource
    DataSet = query_produtos
    Left = 493
    Top = 237
  end
  object query_coringa_vendas: TFDQuery
    Connection = fd
    Left = 184
    Top = 26
    object query_coringa_vendasid: TFDAutoIncField
      DisplayLabel = 'ID'
      DisplayWidth = 7
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object query_coringa_vendasvalor: TBCDField
      DisplayLabel = 'Valor'
      DisplayWidth = 12
      FieldName = 'valor'
      Origin = 'valor'
      Required = True
      currency = True
      Precision = 10
      Size = 2
    end
    object query_coringa_vendasdata: TDateField
      DisplayLabel = 'Data'
      FieldName = 'data'
      Origin = 'data'
      Required = True
    end
    object query_coringa_vendashora: TTimeField
      DisplayLabel = 'Hora'
      FieldName = 'hora'
      Origin = 'hora'
      Required = True
    end
    object query_coringa_vendasfuncionario: TStringField
      DisplayLabel = 'Funcion'#225'rio'
      DisplayWidth = 18
      FieldName = 'funcionario'
      Origin = 'funcionario'
      Required = True
      Size = 25
    end
    object query_coringa_vendasdesconto: TBCDField
      DisplayLabel = 'Desconto'
      FieldName = 'desconto'
      Origin = 'desconto'
      Required = True
      Visible = False
      currency = True
      Precision = 10
      Size = 2
    end
    object query_coringa_vendasvalor_recebido: TBCDField
      DisplayLabel = 'Valor Recebido'
      DisplayWidth = 12
      FieldName = 'valor_recebido'
      Origin = 'valor_recebido'
      Required = True
      Visible = False
      Precision = 10
      Size = 2
    end
    object query_coringa_vendastroco: TBCDField
      FieldName = 'troco'
      Origin = 'troco'
      Required = True
      Visible = False
      Precision = 10
      Size = 2
    end
    object query_coringa_vendasstatus: TStringField
      DisplayLabel = 'Status'
      FieldName = 'status'
      Origin = 'status'
      Required = True
      Size = 12
    end
  end
  object tb_entrada_pro: TFDTable
    IndexFieldNames = 'id'
    Connection = fd
    UpdateOptions.UpdateTableName = 'pdv.entrada_produtos'
    TableName = 'pdv.entrada_produtos'
    Left = 601
    Top = 115
  end
  object query_entrada_pro: TFDQuery
    DetailFields = 'id'
    Connection = fd
    SQL.Strings = (
      'select * from entrada_produtos')
    Left = 601
    Top = 176
    object query_entrada_proid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object query_entrada_proproduto: TStringField
      FieldName = 'produto'
      Origin = 'produto'
      Required = True
      Size = 25
    end
    object query_entrada_proquantidade: TIntegerField
      FieldName = 'quantidade'
      Origin = 'quantidade'
      Required = True
    end
    object query_entrada_profornecedor: TIntegerField
      FieldName = 'fornecedor'
      Origin = 'fornecedor'
      Required = True
    end
    object query_entrada_provalor: TBCDField
      FieldName = 'valor'
      Origin = 'valor'
      Required = True
      Precision = 10
      Size = 2
    end
    object query_entrada_prototal: TBCDField
      FieldName = 'total'
      Origin = 'total'
      Required = True
      Precision = 10
      Size = 2
    end
    object query_entrada_prodata: TDateField
      FieldName = 'data'
      Origin = 'data'
      Required = True
    end
    object query_entrada_proid_produto: TIntegerField
      FieldName = 'id_produto'
      Origin = 'id_produto'
      Required = True
    end
  end
  object DSEntradaProdutos: TDataSource
    DataSet = query_entrada_pro
    Left = 603
    Top = 235
  end
  object tb_saida_pro: TFDTable
    IndexFieldNames = 'id'
    Connection = fd
    UpdateOptions.UpdateTableName = 'pdv.saida_produtos'
    TableName = 'pdv.saida_produtos'
    Left = 712
    Top = 114
  end
  object query_saida_pro: TFDQuery
    DetailFields = 'id'
    Connection = fd
    SQL.Strings = (
      'select * from saida_produtos')
    Left = 717
    Top = 177
    object query_saida_proid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
      Visible = False
    end
    object query_saida_proproduto: TStringField
      DisplayLabel = 'Produto'
      DisplayWidth = 18
      FieldName = 'produto'
      Origin = 'produto'
      Required = True
      Size = 25
    end
    object query_saida_proquantidade: TIntegerField
      DisplayLabel = 'Quantidade'
      DisplayWidth = 12
      FieldName = 'quantidade'
      Origin = 'quantidade'
      Required = True
    end
    object query_saida_promotivo: TStringField
      DisplayLabel = 'Motivo'
      DisplayWidth = 20
      FieldName = 'motivo'
      Origin = 'motivo'
      Required = True
      Size = 25
    end
    object query_saida_prodata: TDateField
      DisplayLabel = 'Data'
      FieldName = 'data'
      Origin = 'data'
      Required = True
    end
    object query_saida_proid_produto: TIntegerField
      FieldName = 'id_produto'
      Origin = 'id_produto'
      Required = True
      Visible = False
    end
  end
  object DSSaidaProdutos: TDataSource
    DataSet = query_saida_pro
    Left = 717
    Top = 238
  end
  object query_coringa: TFDQuery
    Connection = fd
    Left = 289
    Top = 25
  end
  object tb_mov: TFDTable
    IndexFieldNames = 'id'
    Connection = fd
    UpdateOptions.UpdateTableName = 'pdv.movimentacoes'
    TableName = 'pdv.movimentacoes'
    Left = 40
    Top = 304
  end
  object query_mov: TFDQuery
    DetailFields = 'id'
    Connection = fd
    SQL.Strings = (
      'select * from movimentacoes')
    Left = 40
    Top = 368
    object query_movid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object query_movtipo: TStringField
      FieldName = 'tipo'
      Origin = 'tipo'
      Required = True
      Size = 10
    end
    object query_movmovimento: TStringField
      FieldName = 'movimento'
      Origin = 'movimento'
      Required = True
    end
    object query_movvalor: TBCDField
      FieldName = 'valor'
      Origin = 'valor'
      Required = True
      Precision = 10
      Size = 2
    end
    object query_movfuncionario: TStringField
      FieldName = 'funcionario'
      Origin = 'funcionario'
      Required = True
    end
    object query_movdata: TDateField
      FieldName = 'data'
      Origin = 'data'
      Required = True
    end
    object query_movid_movimento: TIntegerField
      FieldName = 'id_movimento'
      Origin = 'id_movimento'
      Required = True
    end
  end
  object DSMovimentacoes: TDataSource
    DataSet = query_mov
    Left = 40
    Top = 432
  end
  object tb_vendas: TFDTable
    IndexFieldNames = 'id'
    Connection = fd
    UpdateOptions.UpdateTableName = 'pdv.vendas'
    TableName = 'pdv.vendas'
    Left = 128
    Top = 304
  end
  object query_vendas: TFDQuery
    DetailFields = 'id'
    Connection = fd
    SQL.Strings = (
      'select * from vendas')
    Left = 128
    Top = 368
    object query_vendasid: TFDAutoIncField
      DisplayLabel = 'ID'
      DisplayWidth = 7
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object query_vendasvalor: TBCDField
      DisplayLabel = 'Valor'
      DisplayWidth = 12
      FieldName = 'valor'
      Origin = 'valor'
      Required = True
      currency = True
      Precision = 10
      Size = 2
    end
    object query_vendasdata: TDateField
      DisplayLabel = 'Data'
      FieldName = 'data'
      Origin = 'data'
      Required = True
    end
    object query_vendashora: TTimeField
      DisplayLabel = 'Hora'
      FieldName = 'hora'
      Origin = 'hora'
      Required = True
    end
    object query_vendasfuncionario: TStringField
      DisplayLabel = 'Funcion'#225'rio'
      DisplayWidth = 18
      FieldName = 'funcionario'
      Origin = 'funcionario'
      Required = True
      Size = 25
    end
    object query_vendasdesconto: TBCDField
      DisplayLabel = 'Desconto'
      FieldName = 'desconto'
      Origin = 'desconto'
      Required = True
      Visible = False
      currency = True
      Precision = 10
      Size = 2
    end
    object query_vendasvalor_recebido: TBCDField
      DisplayLabel = 'Valor Recebido'
      DisplayWidth = 12
      FieldName = 'valor_recebido'
      Origin = 'valor_recebido'
      Required = True
      Visible = False
      Precision = 10
      Size = 2
    end
    object query_vendastroco: TBCDField
      FieldName = 'troco'
      Origin = 'troco'
      Required = True
      Visible = False
      Precision = 10
      Size = 2
    end
    object query_vendasstatus: TStringField
      DisplayLabel = 'Status'
      FieldName = 'status'
      Origin = 'status'
      Required = True
      Size = 12
    end
  end
  object DSVendas: TDataSource
    DataSet = query_vendas
    Left = 128
    Top = 431
  end
  object DSDetVendas: TDataSource
    DataSet = query_det_vendas
    Left = 226
    Top = 430
  end
  object query_det_vendas: TFDQuery
    DetailFields = 'id'
    Connection = fd
    SQL.Strings = (
      'select * from detalhes_vendas')
    Left = 226
    Top = 369
    object query_det_vendasid: TFDAutoIncField
      DisplayLabel = 'C'#243'd Item'
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object query_det_vendasid_venda: TIntegerField
      FieldName = 'id_venda'
      Origin = 'id_venda'
      Required = True
      Visible = False
    end
    object query_det_vendasproduto: TStringField
      DisplayLabel = 'Produto'
      DisplayWidth = 16
      FieldName = 'produto'
      Origin = 'produto'
      Required = True
      Size = 25
    end
    object query_det_vendasvalor: TBCDField
      DisplayLabel = 'Valor Unit'#225'rio'
      DisplayWidth = 12
      FieldName = 'valor'
      Origin = 'valor'
      Required = True
      Visible = False
      currency = True
      Precision = 10
      Size = 2
    end
    object query_det_vendasquantidade: TIntegerField
      DisplayLabel = 'Quantidade'
      FieldName = 'quantidade'
      Origin = 'quantidade'
      Required = True
    end
    object query_det_vendastotal: TBCDField
      DisplayLabel = 'Valor Total'
      DisplayWidth = 13
      FieldName = 'total'
      Origin = 'total'
      Required = True
      currency = True
      Precision = 10
      Size = 2
    end
    object query_det_vendasid_produto: TIntegerField
      FieldName = 'id_produto'
      Origin = 'id_produto'
      Required = True
      Visible = False
    end
    object query_det_vendasfuncionario: TStringField
      FieldName = 'funcionario'
      Origin = 'funcionario'
      Required = True
      Visible = False
      Size = 25
    end
    object query_det_vendasdata: TDateField
      FieldName = 'data'
      Origin = 'data'
      Required = True
      Visible = False
    end
  end
  object tb_detalhes_vendas: TFDTable
    IndexFieldNames = 'id'
    Connection = fd
    UpdateOptions.UpdateTableName = 'pdv.detalhes_vendas'
    TableName = 'pdv.detalhes_vendas'
    Left = 226
    Top = 304
  end
  object tb_caixa: TFDTable
    IndexFieldNames = 'id'
    Connection = fd
    UpdateOptions.UpdateTableName = 'pdv.caixa'
    TableName = 'pdv.caixa'
    Left = 328
    Top = 304
  end
  object query_caixa: TFDQuery
    DetailFields = 'id'
    Connection = fd
    SQL.Strings = (
      'select * from caixa')
    Left = 328
    Top = 368
    object query_caixaid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
      Visible = False
    end
    object query_caixadata_abertura: TDateField
      DisplayLabel = 'Data Abertura'
      FieldName = 'data_abertura'
      Origin = 'data_abertura'
      Required = True
    end
    object query_caixahora_abertura: TTimeField
      DisplayLabel = 'Hora Abertura'
      FieldName = 'hora_abertura'
      Origin = 'hora_abertura'
      Required = True
    end
    object query_caixavalor_abertura: TBCDField
      DisplayLabel = 'Valor Abertura'
      FieldName = 'valor_abertura'
      Origin = 'valor_abertura'
      Required = True
      currency = True
      Precision = 10
      Size = 2
    end
    object query_caixafuncionario_abertura: TStringField
      DisplayLabel = 'Funcion'#225'rio AB'
      DisplayWidth = 15
      FieldName = 'funcionario_abertura'
      Origin = 'funcionario_abertura'
      Required = True
      Size = 25
    end
    object query_caixadata_fechamento: TDateField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Data Fechamento'
      DisplayWidth = 12
      FieldName = 'data_fechamento'
      Origin = 'data_fechamento'
    end
    object query_caixahora_fechamento: TTimeField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Hora Fechamento'
      DisplayWidth = 12
      FieldName = 'hora_fechamento'
      Origin = 'hora_fechamento'
    end
    object query_caixavalor_fechamento: TBCDField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Valor Fechamento'
      DisplayWidth = 12
      FieldName = 'valor_fechamento'
      Origin = 'valor_fechamento'
      currency = True
      Precision = 10
      Size = 2
    end
    object query_caixavalor_vendido: TBCDField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Total Vendido'
      FieldName = 'valor_vendido'
      Origin = 'valor_vendido'
      currency = True
      Precision = 10
      Size = 2
    end
    object query_caixavalor_quebra: TBCDField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Valor da Quebra'
      DisplayWidth = 12
      FieldName = 'valor_quebra'
      Origin = 'valor_quebra'
      currency = True
      Precision = 10
      Size = 2
    end
    object query_caixafuncionario_fechamento: TStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Func Fechamento'
      DisplayWidth = 18
      FieldName = 'funcionario_fechamento'
      Origin = 'funcionario_fechamento'
      Size = 25
    end
    object query_caixanum_caixa: TIntegerField
      DisplayLabel = 'Caixa'
      DisplayWidth = 6
      FieldName = 'num_caixa'
      Origin = 'num_caixa'
      Required = True
    end
    object query_caixaoperador: TStringField
      DisplayLabel = 'Operador'
      DisplayWidth = 15
      FieldName = 'operador'
      Origin = 'operador'
      Required = True
      Size = 25
    end
    object query_caixastatus: TStringField
      DisplayLabel = 'Status'
      FieldName = 'status'
      Origin = 'status'
      Required = True
      Size = 10
    end
  end
  object DSCaixa: TDataSource
    DataSet = query_caixa
    Left = 328
    Top = 426
  end
  object tb_gastos: TFDTable
    IndexFieldNames = 'id'
    Connection = fd
    UpdateOptions.UpdateTableName = 'pdv.gastos'
    TableName = 'pdv.gastos'
    Left = 422
    Top = 305
  end
  object query_gastos: TFDQuery
    DetailFields = 'id'
    Connection = fd
    SQL.Strings = (
      'select * from gastos')
    Left = 423
    Top = 368
    object query_gastosid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
      Visible = False
    end
    object query_gastosmotivo: TStringField
      DisplayLabel = 'Motivo'
      DisplayWidth = 18
      FieldName = 'motivo'
      Origin = 'motivo'
      Required = True
      Size = 25
    end
    object query_gastosvalor: TBCDField
      DisplayLabel = 'Valor'
      DisplayWidth = 10
      FieldName = 'valor'
      Origin = 'valor'
      Required = True
      currency = True
      Precision = 10
      Size = 2
    end
    object query_gastosfuncionario: TStringField
      DisplayLabel = 'Funcion'#225'rio'
      DisplayWidth = 15
      FieldName = 'funcionario'
      Origin = 'funcionario'
      Required = True
    end
    object query_gastosdata: TDateField
      DisplayLabel = 'Data'
      FieldName = 'data'
      Origin = 'data'
      Required = True
    end
  end
  object DSGastos: TDataSource
    DataSet = query_gastos
    Left = 424
    Top = 426
  end
  object FDQ_OS: TFDQuery
    DetailFields = 'id'
    Connection = fd
    SQL.Strings = (
      'SELECT * FROM OS')
    Left = 519
    Top = 365
    object FDQ_OSid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object FDQ_OScliente: TStringField
      FieldName = 'cliente'
      Origin = 'cliente'
      Size = 50
    end
    object FDQ_OStecnico: TStringField
      FieldName = 'tecnico'
      Origin = 'tecnico'
      Size = 50
    end
    object FDQ_OSdtinicial: TDateField
      FieldName = 'dtinicial'
      Origin = 'dtinicial'
    end
    object FDQ_OSdtfinal: TDateField
      FieldName = 'dtfinal'
      Origin = 'dtfinal'
    end
    object FDQ_OSstatus: TStringField
      FieldName = 'status'
      Origin = 'status'
      Size = 45
    end
    object FDQ_OSgarantia: TStringField
      FieldName = 'garantia'
      Origin = 'garantia'
      Size = 45
    end
    object FDQ_OSdescricao_servico: TMemoField
      FieldName = 'descricao_servico'
      Origin = 'descricao_servico'
      BlobType = ftMemo
    end
    object FDQ_OSdefeito: TMemoField
      FieldName = 'defeito'
      Origin = 'defeito'
      BlobType = ftMemo
    end
    object FDQ_OSobservacao: TMemoField
      FieldName = 'observacao'
      Origin = 'observacao'
      BlobType = ftMemo
    end
    object FDQ_OSlaudo_tecnico: TMemoField
      FieldName = 'laudo_tecnico'
      Origin = 'laudo_tecnico'
      BlobType = ftMemo
    end
    object FDQ_OSvalor_total: TStringField
      FieldName = 'valor_total'
      Origin = 'valor_total'
      Size = 10
    end
  end
  object FDT_OS: TFDTable
    IndexFieldNames = 'id'
    Connection = fd
    UpdateOptions.UpdateTableName = 'pdv.os'
    TableName = 'pdv.os'
    Left = 516
    Top = 306
  end
  object DS_OS: TDataSource
    DataSet = FDQ_OS
    Left = 522
    Top = 426
  end
  object query_caixa_Coringa: TFDQuery
    Connection = fd
    SQL.Strings = (
      'select * from caixa')
    Left = 392
    Top = 25
    object query_caixa_Coringaid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
      Visible = False
    end
    object query_caixa_Coringadata_abertura: TDateField
      DisplayLabel = 'Data da Abertura'
      DisplayWidth = 15
      FieldName = 'data_abertura'
      Origin = 'data_abertura'
      Required = True
    end
    object query_caixa_Coringahora_abertura: TTimeField
      DisplayLabel = 'Hora da Abertura'
      DisplayWidth = 15
      FieldName = 'hora_abertura'
      Origin = 'hora_abertura'
      Required = True
    end
    object query_caixa_Coringavalor_abertura: TBCDField
      DisplayLabel = 'Valor da Abertura'
      DisplayWidth = 15
      FieldName = 'valor_abertura'
      Origin = 'valor_abertura'
      Required = True
      currency = True
      Precision = 10
      Size = 2
    end
    object query_caixa_Coringafuncionario_abertura: TStringField
      DisplayLabel = 'Gerente Abertura'
      DisplayWidth = 18
      FieldName = 'funcionario_abertura'
      Origin = 'funcionario_abertura'
      Required = True
      Size = 25
    end
    object query_caixa_Coringadata_fechamento: TDateField
      AutoGenerateValue = arDefault
      FieldName = 'data_fechamento'
      Origin = 'data_fechamento'
      Visible = False
    end
    object query_caixa_Coringahora_fechamento: TTimeField
      AutoGenerateValue = arDefault
      FieldName = 'hora_fechamento'
      Origin = 'hora_fechamento'
      Visible = False
    end
    object query_caixa_Coringavalor_fechamento: TBCDField
      AutoGenerateValue = arDefault
      FieldName = 'valor_fechamento'
      Origin = 'valor_fechamento'
      Visible = False
      Precision = 10
      Size = 2
    end
    object query_caixa_Coringavalor_vendido: TBCDField
      AutoGenerateValue = arDefault
      FieldName = 'valor_vendido'
      Origin = 'valor_vendido'
      Visible = False
      Precision = 10
      Size = 2
    end
    object query_caixa_Coringavalor_quebra: TBCDField
      AutoGenerateValue = arDefault
      FieldName = 'valor_quebra'
      Origin = 'valor_quebra'
      Visible = False
      Precision = 10
      Size = 2
    end
    object query_caixa_Coringafuncionario_fechamento: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'funcionario_fechamento'
      Origin = 'funcionario_fechamento'
      Visible = False
      Size = 25
    end
    object query_caixa_Coringanum_caixa: TIntegerField
      DisplayLabel = 'Caixa'
      FieldName = 'num_caixa'
      Origin = 'num_caixa'
      Required = True
    end
    object query_caixa_Coringaoperador: TStringField
      DisplayLabel = 'Operador'
      DisplayWidth = 18
      FieldName = 'operador'
      Origin = 'operador'
      Required = True
      Size = 25
    end
    object query_caixa_Coringastatus: TStringField
      DisplayLabel = 'Status'
      DisplayWidth = 12
      FieldName = 'status'
      Origin = 'status'
      Required = True
      Size = 10
    end
  end
  object query_coringa_caixa: TFDQuery
    Connection = fd
    Left = 510
    Top = 25
  end
  object DSCaixaCoringa: TDataSource
    DataSet = query_caixa_Coringa
    Left = 752
    Top = 26
  end
  object query_coringa_produtos: TFDQuery
    Connection = fd
    Left = 632
    Top = 34
  end
  object rel_Mov_Entradas: TFDQuery
    Connection = fd
    Left = 616
    Top = 312
  end
  object rel_Mov_Saidas: TFDQuery
    Connection = fd
    Left = 616
    Top = 384
  end
  object query_coringa_mov: TFDQuery
    Connection = fd
    Left = 720
    Top = 314
  end
  object DSCoringaVendas: TDataSource
    DataSet = query_coringa_vendas
    Left = 848
    Top = 26
  end
  object FDMySQLDriver: TFDPhysMySQLDriverLink
    VendorLib = 'C:\Windows\System32\libmySQL.dll'
    Left = 88
    Top = 56
  end
end
