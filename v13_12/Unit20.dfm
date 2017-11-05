object Form20: TForm20
  Left = 1237
  Top = 0
  Width = 662
  Height = 259
  Caption = 'Form20: Distributed model'
  Color = 13430493
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Visible = True
  PixelsPerInch = 120
  TextHeight = 16
  object GroupBox1: TGroupBox
    Left = 8
    Top = 0
    Width = 209
    Height = 121
    Caption = 'Stimulation:'
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 44
      Width = 72
      Height = 16
      Caption = 'Iind_Left, pA'
    end
    object Label2: TLabel
      Left = 8
      Top = 68
      Width = 82
      Height = 16
      Caption = 'Iind_Right, pA'
    end
    object Label6: TLabel
      Left = 8
      Top = 92
      Width = 57
      Height = 16
      Caption = 'alpha_Hz'
    end
    object DDSpinEdit1: TDDSpinEdit
      Left = 144
      Top = 39
      Width = 57
      Height = 26
      StrWidth = 2
      StrDecimals = 0
      Increment = 50.000000000000000000
      TabOrder = 0
    end
    object DDSpinEdit2: TDDSpinEdit
      Left = 144
      Top = 63
      Width = 57
      Height = 26
      StrWidth = 2
      StrDecimals = 0
      Increment = 50.000000000000000000
      TabOrder = 1
    end
    object DDSpinEdit6: TDDSpinEdit
      Left = 144
      Top = 87
      Width = 57
      Height = 26
      StrWidth = 2
      StrDecimals = 0
      Increment = 25.000000000000000000
      TabOrder = 2
      Value = 100.000000000000000000
    end
    object ComboBox2: TComboBox
      Left = 8
      Top = 16
      Width = 193
      Height = 24
      ItemHeight = 16
      ItemIndex = 0
      TabOrder = 3
      Text = 'stimulation at soma from 1-comp. model'
      Items.Strings = (
        'stimulation at soma from 1-comp. model'
        'steps at both ends'
        'alpha-functions at both ends'
        'noise for gE, gI at soma')
    end
  end
  object GroupBox2: TGroupBox
    Left = 224
    Top = 0
    Width = 225
    Height = 177
    Caption = 'Channel distribution:'
    TabOrder = 1
    object Label3: TLabel
      Left = 8
      Top = 44
      Width = 132
      Height = 16
      Caption = 'disbalance of gNa, w='
    end
    object Label7: TLabel
      Left = 8
      Top = 68
      Width = 131
      Height = 16
      Caption = 'disbalance of gK,    w='
    end
    object CheckBox1: TCheckBox
      Left = 8
      Top = 16
      Width = 193
      Height = 17
      Caption = 'No adaptation on the fiber'
      Checked = True
      State = cbChecked
      TabOrder = 0
    end
    object DDSpinEdit3: TDDSpinEdit
      Left = 160
      Top = 39
      Width = 57
      Height = 26
      Hint = 'if 0 then gNa in axon is 0.'
      StrWidth = 2
      StrDecimals = 2
      Increment = 49.000000000000000000
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      Value = 1.000000000000000000
      OnDblClick = DDSpinEdit3DblClick
    end
    object DDSpinEdit7: TDDSpinEdit
      Left = 160
      Top = 63
      Width = 57
      Height = 26
      Hint = 'if 0 then gK in axon is 0.'
      StrWidth = 2
      StrDecimals = 2
      Increment = 1.000000000000000000
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      Value = 1.000000000000000000
      OnDblClick = DDSpinEdit7DblClick
    end
    object CheckBox2: TCheckBox
      Left = 8
      Top = 91
      Width = 209
      Height = 17
      Caption = 'Homogeneous gNa, gK in axon'
      Checked = True
      State = cbChecked
      TabOrder = 3
    end
    object CheckBox5: TCheckBox
      Left = 8
      Top = 115
      Width = 209
      Height = 17
      Caption = 'Right half of axon is passive'
      TabOrder = 4
    end
    object ComboBox1: TComboBox
      Left = 8
      Top = 146
      Width = 209
      Height = 24
      ItemHeight = 16
      ItemIndex = 0
      TabOrder = 5
      Text = 'linear: gNa-decrease; gNaR-increase'
      Items.Strings = (
        'linear: gNa-decrease; gNaR-increase'
        'NaThreshShift is linear'
        'homogeneous'
        'Na-soma, NaR- right half of axon'
        'fiber is passive'
        'AHP and KM grows up to z=L')
    end
  end
  object GroupBox3: TGroupBox
    Left = 8
    Top = 123
    Width = 209
    Height = 97
    Caption = 'Axon'
    TabOrder = 2
    object Label4: TLabel
      Left = 8
      Top = 20
      Width = 65
      Height = 16
      Caption = 'diam, mum'
    end
    object Label5: TLabel
      Left = 8
      Top = 44
      Width = 42
      Height = 16
      Caption = 'L, mum'
    end
    object Label13: TLabel
      Left = 8
      Top = 68
      Width = 77
      Height = 16
      Hint = '"Size" of soma'
      Caption = 'RL, Ohm*cm:'
      ParentShowHint = False
      ShowHint = True
    end
    object DDSpinEdit4: TDDSpinEdit
      Left = 144
      Top = 15
      Width = 57
      Height = 26
      StrWidth = 2
      StrDecimals = 1
      Increment = 0.100000000000000000
      TabOrder = 0
      Value = 1.000000000000000000
    end
    object DDSpinEdit5: TDDSpinEdit
      Left = 144
      Top = 39
      Width = 57
      Height = 26
      StrWidth = 2
      StrDecimals = 0
      Increment = 50.000000000000000000
      TabOrder = 1
      Value = 50.000000000000000000
    end
    object DDSpinEdit17: TDDSpinEdit
      Left = 144
      Top = 64
      Width = 57
      Height = 26
      StrWidth = 2
      StrDecimals = 0
      Increment = 10.000000000000000000
      TabOrder = 2
      Value = 150.000000000000000000
      OnChange = DDSpinEdit17Change
    end
  end
  object GroupBox4: TGroupBox
    Left = 456
    Top = 0
    Width = 193
    Height = 145
    Caption = 'Noise'
    TabOrder = 3
    object Label8: TLabel
      Left = 8
      Top = 20
      Width = 82
      Height = 16
      Caption = 'tau_noise, ms'
    end
    object Label9: TLabel
      Left = 8
      Top = 44
      Width = 117
      Height = 16
      Caption = 'Ampl_gE, mS/cm^2'
    end
    object Label10: TLabel
      Left = 8
      Top = 68
      Width = 111
      Height = 16
      Caption = 'Ampl_gl, mS/cm^2'
    end
    object Label11: TLabel
      Left = 8
      Top = 92
      Width = 120
      Height = 16
      Caption = 'mean_gE, mS/cm^2'
    end
    object Label12: TLabel
      Left = 8
      Top = 116
      Width = 114
      Height = 16
      Caption = 'mean_gI, mS/cm^2'
    end
    object DDSpinEdit8: TDDSpinEdit
      Left = 136
      Top = 16
      Width = 49
      Height = 26
      StrWidth = 2
      StrDecimals = 2
      Increment = 1.000000000000000000
      TabOrder = 0
      Value = 3.000000000000000000
    end
    object DDSpinEdit9: TDDSpinEdit
      Left = 136
      Top = 40
      Width = 49
      Height = 26
      StrWidth = 2
      StrDecimals = 2
      Increment = 1.000000000000000000
      TabOrder = 1
    end
    object DDSpinEdit10: TDDSpinEdit
      Left = 136
      Top = 64
      Width = 49
      Height = 26
      StrWidth = 2
      StrDecimals = 2
      Increment = 1.000000000000000000
      TabOrder = 2
    end
    object DDSpinEdit11: TDDSpinEdit
      Left = 136
      Top = 88
      Width = 49
      Height = 26
      StrWidth = 2
      StrDecimals = 2
      Increment = 1.000000000000000000
      TabOrder = 3
    end
    object DDSpinEdit12: TDDSpinEdit
      Left = 136
      Top = 112
      Width = 49
      Height = 26
      StrWidth = 2
      StrDecimals = 2
      Increment = 1.000000000000000000
      TabOrder = 4
    end
  end
  object GroupBox7: TGroupBox
    Left = 224
    Top = 176
    Width = 225
    Height = 44
    Caption = 'Space'
    TabOrder = 4
    object Label19: TLabel
      Left = 7
      Top = 18
      Width = 10
      Height = 16
      Hint = '"Size" of soma'
      Caption = 'N'
      ParentShowHint = False
      ShowHint = True
    end
    object DDSpinEdit19: TDDSpinEdit
      Left = 160
      Top = 13
      Width = 57
      Height = 26
      StrWidth = 2
      StrDecimals = 0
      Increment = 25.000000000000000000
      TabOrder = 0
      Value = 50.000000000000000000
      OnChange = DDSpinEdit19Change
    end
  end
  object GroupBox8: TGroupBox
    Left = 456
    Top = 147
    Width = 193
    Height = 73
    Caption = 'Drawing'
    TabOrder = 5
    object Label18: TLabel
      Left = 7
      Top = 18
      Width = 38
      Height = 16
      Hint = '"Size" of soma'
      Caption = 'nDraw'
      ParentShowHint = False
      ShowHint = True
    end
    object Label14: TLabel
      Left = 7
      Top = 42
      Width = 48
      Height = 16
      Hint = '"Size" of soma'
      Caption = 'zDraw/L'
      ParentShowHint = False
      ShowHint = True
    end
    object DDSpinEdit18: TDDSpinEdit
      Left = 136
      Top = 14
      Width = 49
      Height = 26
      Hint = 'DblClick for increment=1'
      StrWidth = 2
      StrDecimals = 0
      Increment = 10.000000000000000000
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      Value = 50.000000000000000000
      OnChange = DDSpinEdit18Change
      OnDblClick = DDSpinEdit18DblClick
    end
    object DDSpinEdit13: TDDSpinEdit
      Left = 136
      Top = 38
      Width = 49
      Height = 26
      Hint = 'DblClick for increment=1'
      StrWidth = 2
      StrDecimals = 2
      Increment = 0.250000000000000000
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnDblClick = DDSpinEdit13DblClick
    end
  end
end
