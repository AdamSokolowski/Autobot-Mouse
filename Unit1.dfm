object Form1: TForm1
  Left = 327
  Top = 195
  Width = 964
  Height = 412
  Caption = 'Autobot Mouse v5'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 448
    Top = 8
    Width = 32
    Height = 13
    Caption = 'Label1'
  end
  object Label2: TLabel
    Left = 448
    Top = 40
    Width = 32
    Height = 13
    Caption = 'Label2'
  end
  object Memo1: TMemo
    Left = 16
    Top = 24
    Width = 201
    Height = 193
    Lines.Strings = (
      'Memo1')
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
  end
  object Button1: TButton
    Left = 248
    Top = 32
    Width = 97
    Height = 25
    Caption = 'Mouse Pos'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 248
    Top = 8
    Width = 41
    Height = 21
    TabOrder = 2
    Text = 'Edit1'
  end
  object Edit2: TEdit
    Left = 296
    Top = 8
    Width = 49
    Height = 21
    TabOrder = 3
    Text = 'Edit2'
  end
  object ComboBox1: TComboBox
    Left = 240
    Top = 96
    Width = 145
    Height = 22
    Style = csOwnerDrawFixed
    ItemHeight = 16
    TabOrder = 4
    Items.Strings = (
      'Every'
      'Interval'
      'Repeat'
      'OnCapsTurnOff'
      'CapsAuto')
  end
  object Edit3: TEdit
    Left = 240
    Top = 128
    Width = 65
    Height = 21
    TabOrder = 5
    Text = '3'
  end
  object ComboBox2: TComboBox
    Left = 312
    Top = 128
    Width = 73
    Height = 22
    Style = csOwnerDrawFixed
    ItemHeight = 16
    TabOrder = 6
    Items.Strings = (
      'sec'
      'min'
      'hrs'
      'milisec')
  end
  object CheckBox1: TCheckBox
    Left = 408
    Top = 104
    Width = 97
    Height = 17
    Caption = 'Randomize time'
    TabOrder = 7
  end
  object Button3: TButton
    Left = 136
    Top = 240
    Width = 75
    Height = 25
    Caption = 'Turn On'
    TabOrder = 8
    OnClick = Button3Click
  end
  object GroupBox1: TGroupBox
    Left = 432
    Top = 168
    Width = 193
    Height = 129
    Caption = 'Keyboard'
    TabOrder = 9
    object Button4: TButton
      Left = 24
      Top = 88
      Width = 121
      Height = 25
      Caption = 'Add Key Press'
      TabOrder = 0
      OnClick = Button4Click
    end
    object ComboBoxSelector: TComboBox
      Left = 24
      Top = 64
      Width = 145
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 1
      Items.Strings = (
        'None'
        'Shift'
        'Ctrl'
        'Alt')
    end
    object ComboBoxKey: TComboBox
      Left = 24
      Top = 32
      Width = 145
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 2
      Items.Strings = (
        '1'
        '2'
        '3'
        '4'
        '5'
        '6'
        '7'
        '8'
        '9'
        '0'
        'q'
        'w'
        'e'
        'r'
        't'
        'y'
        'u'
        'i'
        'o'
        'p'
        'a'
        's'
        'd'
        'f'
        'g'
        'h'
        'j'
        'k'
        'l'
        'z'
        'x'
        'c'
        'v'
        'b'
        'n'
        'm'
        '`'
        '-'
        '='
        '['
        ']'
        '\'
        ';'
        #39
        ','
        '.'
        '/'
        'Space'
        'Enter'
        'Caps'
        'Tab'
        'Backspace'
        'Insert'
        'Delete'
        'Home'
        'End'
        'PgUp'
        'PgDown'
        'ScrollLock'
        'PrntScr'
        'Pause'
        'UP'
        'DOWN'
        'LEFT'
        'RIGHT')
    end
  end
  object GroupBox2: TGroupBox
    Left = 240
    Top = 168
    Width = 185
    Height = 129
    Caption = 'Mouse'
    TabOrder = 10
    object Button2: TButton
      Left = 24
      Top = 72
      Width = 105
      Height = 25
      Caption = 'Add Mouse Click'
      TabOrder = 0
      OnClick = Button2Click
    end
    object CheckBox2: TCheckBox
      Left = 32
      Top = 40
      Width = 97
      Height = 17
      Caption = 'Right Button'
      Enabled = False
      TabOrder = 1
    end
  end
  object ListBox1: TListBox
    Left = 640
    Top = 56
    Width = 305
    Height = 241
    ItemHeight = 13
    TabOrder = 11
    OnClick = ListBox1Click
  end
  object Button5: TButton
    Left = 640
    Top = 304
    Width = 57
    Height = 25
    Caption = 'Add'
    TabOrder = 12
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 704
    Top = 304
    Width = 57
    Height = 25
    Caption = 'Update'
    TabOrder = 13
    OnClick = Button6Click
  end
  object CheckBox3: TCheckBox
    Left = 240
    Top = 304
    Width = 217
    Height = 17
    Caption = 'Return To Mouse Origin after Interval'
    TabOrder = 14
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 592
    Top = 8
  end
  object TimerRepeat: TTimer
    Enabled = False
    OnTimer = TimerRepeatTimer
    Left = 632
    Top = 8
  end
  object TimerEndlessRepeater: TTimer
    OnTimer = TimerEndlessRepeaterTimer
    Left = 672
    Top = 8
  end
end
