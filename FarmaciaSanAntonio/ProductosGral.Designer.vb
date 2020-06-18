<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class ProductosGral
    Inherits System.Windows.Forms.Form

    'Form reemplaza a Dispose para limpiar la lista de componentes.
    <System.Diagnostics.DebuggerNonUserCode()> _
    Protected Overrides Sub Dispose(ByVal disposing As Boolean)
        Try
            If disposing AndAlso components IsNot Nothing Then
                components.Dispose()
            End If
        Finally
            MyBase.Dispose(disposing)
        End Try
    End Sub

    'Requerido por el Diseñador de Windows Forms
    Private components As System.ComponentModel.IContainer

    'NOTA: el Diseñador de Windows Forms necesita el siguiente procedimiento
    'Se puede modificar usando el Diseñador de Windows Forms.  
    'No lo modifique con el editor de código.
    <System.Diagnostics.DebuggerStepThrough()> _
    Private Sub InitializeComponent()
        Me.PanelRP = New System.Windows.Forms.Panel()
        Me.Label15 = New System.Windows.Forms.Label()
        Me.btnre4 = New System.Windows.Forms.Button()
        Me.comboreac = New System.Windows.Forms.ComboBox()
        Me.btnReacP = New System.Windows.Forms.Button()
        Me.Label16 = New System.Windows.Forms.Label()
        Me.btnRP = New System.Windows.Forms.Button()
        Me.PanelTP = New System.Windows.Forms.Panel()
        Me.Label14 = New System.Windows.Forms.Label()
        Me.btnre3 = New System.Windows.Forms.Button()
        Me.combotemporal = New System.Windows.Forms.ComboBox()
        Me.btnBajaTempP = New System.Windows.Forms.Button()
        Me.Label11 = New System.Windows.Forms.Label()
        Me.PanelEP = New System.Windows.Forms.Panel()
        Me.Label13 = New System.Windows.Forms.Label()
        Me.btnre2 = New System.Windows.Forms.Button()
        Me.Label10 = New System.Windows.Forms.Label()
        Me.ElimProd = New System.Windows.Forms.Button()
        Me.comboeliminar = New System.Windows.Forms.ComboBox()
        Me.btnInsP = New System.Windows.Forms.Button()
        Me.btnBajaTP = New System.Windows.Forms.Button()
        Me.btnEP = New System.Windows.Forms.Button()
        Me.PRECIOCOMP = New System.Windows.Forms.TextBox()
        Me.Label4 = New System.Windows.Forms.Label()
        Me.btnSalir = New System.Windows.Forms.Button()
        Me.btnModP = New System.Windows.Forms.Button()
        Me.btnConsultaP = New System.Windows.Forms.Button()
        Me.ESTADO = New System.Windows.Forms.TextBox()
        Me.EXISTENCIASP = New System.Windows.Forms.TextBox()
        Me.PRECIOVTAP = New System.Windows.Forms.TextBox()
        Me.DESCRIP = New System.Windows.Forms.TextBox()
        Me.NOMPROD = New System.Windows.Forms.TextBox()
        Me.CVEPROD = New System.Windows.Forms.ComboBox()
        Me.Label7 = New System.Windows.Forms.Label()
        Me.Label6 = New System.Windows.Forms.Label()
        Me.Label5 = New System.Windows.Forms.Label()
        Me.Label3 = New System.Windows.Forms.Label()
        Me.Label2 = New System.Windows.Forms.Label()
        Me.Label1 = New System.Windows.Forms.Label()
        Me.PanelOPP = New System.Windows.Forms.Panel()
        Me.Button1 = New System.Windows.Forms.Button()
        Me.Button2 = New System.Windows.Forms.Button()
        Me.Label12 = New System.Windows.Forms.Label()
        Me.combomod = New System.Windows.Forms.ComboBox()
        Me.Label9 = New System.Windows.Forms.Label()
        Me.btnModDP = New System.Windows.Forms.Button()
        Me.txtnompro = New System.Windows.Forms.TextBox()
        Me.Label8 = New System.Windows.Forms.Label()
        Me.txtdescp = New System.Windows.Forms.TextBox()
        Me.btnModNP = New System.Windows.Forms.Button()
        Me.Label17 = New System.Windows.Forms.Label()
        Me.Panel1 = New System.Windows.Forms.Panel()
        Me.PanelRP.SuspendLayout()
        Me.PanelTP.SuspendLayout()
        Me.PanelEP.SuspendLayout()
        Me.PanelOPP.SuspendLayout()
        Me.Panel1.SuspendLayout()
        Me.SuspendLayout()
        '
        'PanelRP
        '
        Me.PanelRP.Anchor = CType(((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Bottom) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.PanelRP.BackColor = System.Drawing.SystemColors.GradientInactiveCaption
        Me.PanelRP.Controls.Add(Me.Label15)
        Me.PanelRP.Controls.Add(Me.btnre4)
        Me.PanelRP.Controls.Add(Me.comboreac)
        Me.PanelRP.Controls.Add(Me.btnReacP)
        Me.PanelRP.Controls.Add(Me.Label16)
        Me.PanelRP.Location = New System.Drawing.Point(404, 40)
        Me.PanelRP.Name = "PanelRP"
        Me.PanelRP.Size = New System.Drawing.Size(326, 120)
        Me.PanelRP.TabIndex = 69
        Me.PanelRP.Visible = False
        '
        'Label15
        '
        Me.Label15.AutoSize = True
        Me.Label15.Location = New System.Drawing.Point(33, 47)
        Me.Label15.Name = "Label15"
        Me.Label15.Size = New System.Drawing.Size(62, 13)
        Me.Label15.TabIndex = 44
        Me.Label15.Text = "CVEPROD:"
        '
        'btnre4
        '
        Me.btnre4.BackColor = System.Drawing.Color.Navy
        Me.btnre4.ForeColor = System.Drawing.SystemColors.ButtonFace
        Me.btnre4.Location = New System.Drawing.Point(186, 77)
        Me.btnre4.Name = "btnre4"
        Me.btnre4.Size = New System.Drawing.Size(120, 32)
        Me.btnre4.TabIndex = 42
        Me.btnre4.Text = "REGRESAR"
        Me.btnre4.UseVisualStyleBackColor = False
        '
        'comboreac
        '
        Me.comboreac.FormattingEnabled = True
        Me.comboreac.Location = New System.Drawing.Point(94, 44)
        Me.comboreac.Name = "comboreac"
        Me.comboreac.Size = New System.Drawing.Size(70, 21)
        Me.comboreac.TabIndex = 41
        '
        'btnReacP
        '
        Me.btnReacP.BackColor = System.Drawing.Color.CornflowerBlue
        Me.btnReacP.Location = New System.Drawing.Point(16, 77)
        Me.btnReacP.Name = "btnReacP"
        Me.btnReacP.Size = New System.Drawing.Size(164, 32)
        Me.btnReacP.TabIndex = 40
        Me.btnReacP.Text = "REACTIVAR PRODUCTO"
        Me.btnReacP.UseVisualStyleBackColor = False
        '
        'Label16
        '
        Me.Label16.AutoSize = True
        Me.Label16.Location = New System.Drawing.Point(13, 16)
        Me.Label16.Name = "Label16"
        Me.Label16.Size = New System.Drawing.Size(175, 13)
        Me.Label16.TabIndex = 40
        Me.Label16.Text = "REACTIVACION DE PRODUCTOS"
        '
        'btnRP
        '
        Me.btnRP.BackColor = System.Drawing.Color.LightSteelBlue
        Me.btnRP.Location = New System.Drawing.Point(405, 382)
        Me.btnRP.Name = "btnRP"
        Me.btnRP.Size = New System.Drawing.Size(153, 32)
        Me.btnRP.TabIndex = 68
        Me.btnRP.Text = "REAC. PRODUCTO"
        Me.btnRP.UseVisualStyleBackColor = False
        '
        'PanelTP
        '
        Me.PanelTP.Anchor = CType(((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Bottom) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.PanelTP.BackColor = System.Drawing.SystemColors.GradientInactiveCaption
        Me.PanelTP.Controls.Add(Me.Label14)
        Me.PanelTP.Controls.Add(Me.btnre3)
        Me.PanelTP.Controls.Add(Me.combotemporal)
        Me.PanelTP.Controls.Add(Me.btnBajaTempP)
        Me.PanelTP.Controls.Add(Me.Label11)
        Me.PanelTP.Location = New System.Drawing.Point(404, 40)
        Me.PanelTP.Name = "PanelTP"
        Me.PanelTP.Size = New System.Drawing.Size(323, 120)
        Me.PanelTP.TabIndex = 67
        Me.PanelTP.Visible = False
        '
        'Label14
        '
        Me.Label14.AutoSize = True
        Me.Label14.Location = New System.Drawing.Point(33, 47)
        Me.Label14.Name = "Label14"
        Me.Label14.Size = New System.Drawing.Size(62, 13)
        Me.Label14.TabIndex = 44
        Me.Label14.Text = "CVEPROD:"
        '
        'btnre3
        '
        Me.btnre3.BackColor = System.Drawing.Color.Navy
        Me.btnre3.ForeColor = System.Drawing.SystemColors.ButtonFace
        Me.btnre3.Location = New System.Drawing.Point(186, 77)
        Me.btnre3.Name = "btnre3"
        Me.btnre3.Size = New System.Drawing.Size(120, 32)
        Me.btnre3.TabIndex = 42
        Me.btnre3.Text = "REGRESAR"
        Me.btnre3.UseVisualStyleBackColor = False
        '
        'combotemporal
        '
        Me.combotemporal.FormattingEnabled = True
        Me.combotemporal.Location = New System.Drawing.Point(94, 44)
        Me.combotemporal.Name = "combotemporal"
        Me.combotemporal.Size = New System.Drawing.Size(70, 21)
        Me.combotemporal.TabIndex = 41
        '
        'btnBajaTempP
        '
        Me.btnBajaTempP.BackColor = System.Drawing.Color.CornflowerBlue
        Me.btnBajaTempP.Location = New System.Drawing.Point(16, 77)
        Me.btnBajaTempP.Name = "btnBajaTempP"
        Me.btnBajaTempP.Size = New System.Drawing.Size(164, 32)
        Me.btnBajaTempP.TabIndex = 40
        Me.btnBajaTempP.Text = "DAR DE BAJA TEMP"
        Me.btnBajaTempP.UseVisualStyleBackColor = False
        '
        'Label11
        '
        Me.Label11.AutoSize = True
        Me.Label11.Location = New System.Drawing.Point(13, 16)
        Me.Label11.Name = "Label11"
        Me.Label11.Size = New System.Drawing.Size(104, 13)
        Me.Label11.TabIndex = 40
        Me.Label11.Text = "BAJA PRODUCTOS"
        '
        'PanelEP
        '
        Me.PanelEP.Anchor = CType(((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Bottom) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.PanelEP.BackColor = System.Drawing.SystemColors.GradientInactiveCaption
        Me.PanelEP.BackgroundImageLayout = System.Windows.Forms.ImageLayout.None
        Me.PanelEP.Controls.Add(Me.Label13)
        Me.PanelEP.Controls.Add(Me.btnre2)
        Me.PanelEP.Controls.Add(Me.Label10)
        Me.PanelEP.Controls.Add(Me.ElimProd)
        Me.PanelEP.Controls.Add(Me.comboeliminar)
        Me.PanelEP.Location = New System.Drawing.Point(404, 40)
        Me.PanelEP.Name = "PanelEP"
        Me.PanelEP.Size = New System.Drawing.Size(326, 121)
        Me.PanelEP.TabIndex = 66
        Me.PanelEP.Visible = False
        '
        'Label13
        '
        Me.Label13.AutoSize = True
        Me.Label13.Location = New System.Drawing.Point(13, 40)
        Me.Label13.Name = "Label13"
        Me.Label13.Size = New System.Drawing.Size(62, 13)
        Me.Label13.TabIndex = 44
        Me.Label13.Text = "CVEPROD:"
        '
        'btnre2
        '
        Me.btnre2.BackColor = System.Drawing.Color.Navy
        Me.btnre2.ForeColor = System.Drawing.SystemColors.ButtonFace
        Me.btnre2.Location = New System.Drawing.Point(186, 64)
        Me.btnre2.Name = "btnre2"
        Me.btnre2.Size = New System.Drawing.Size(120, 32)
        Me.btnre2.TabIndex = 41
        Me.btnre2.Text = "REGRESAR"
        Me.btnre2.UseVisualStyleBackColor = False
        '
        'Label10
        '
        Me.Label10.AutoSize = True
        Me.Label10.Location = New System.Drawing.Point(13, 16)
        Me.Label10.Name = "Label10"
        Me.Label10.Size = New System.Drawing.Size(158, 13)
        Me.Label10.TabIndex = 40
        Me.Label10.Text = "ELIMINACION DE PRODUCTO"
        '
        'ElimProd
        '
        Me.ElimProd.BackColor = System.Drawing.Color.CornflowerBlue
        Me.ElimProd.Location = New System.Drawing.Point(16, 64)
        Me.ElimProd.Name = "ElimProd"
        Me.ElimProd.Size = New System.Drawing.Size(164, 32)
        Me.ElimProd.TabIndex = 38
        Me.ElimProd.Text = "ELIMINAR PRODUCTO"
        Me.ElimProd.UseVisualStyleBackColor = False
        '
        'comboeliminar
        '
        Me.comboeliminar.DisplayMember = "uno"
        Me.comboeliminar.FormattingEnabled = True
        Me.comboeliminar.Location = New System.Drawing.Point(74, 37)
        Me.comboeliminar.Name = "comboeliminar"
        Me.comboeliminar.Size = New System.Drawing.Size(70, 21)
        Me.comboeliminar.TabIndex = 39
        '
        'btnInsP
        '
        Me.btnInsP.BackColor = System.Drawing.Color.CornflowerBlue
        Me.btnInsP.Font = New System.Drawing.Font("Microsoft Sans Serif", 14.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.btnInsP.Location = New System.Drawing.Point(28, 361)
        Me.btnInsP.Name = "btnInsP"
        Me.btnInsP.Size = New System.Drawing.Size(200, 36)
        Me.btnInsP.TabIndex = 65
        Me.btnInsP.Text = "INSERTAR"
        Me.btnInsP.UseVisualStyleBackColor = False
        '
        'btnBajaTP
        '
        Me.btnBajaTP.BackColor = System.Drawing.Color.LightSteelBlue
        Me.btnBajaTP.Location = New System.Drawing.Point(575, 345)
        Me.btnBajaTP.Name = "btnBajaTP"
        Me.btnBajaTP.Size = New System.Drawing.Size(153, 32)
        Me.btnBajaTP.TabIndex = 64
        Me.btnBajaTP.Text = "BAJA TEMPORAL"
        Me.btnBajaTP.UseVisualStyleBackColor = False
        '
        'btnEP
        '
        Me.btnEP.BackColor = System.Drawing.Color.Navy
        Me.btnEP.Font = New System.Drawing.Font("Microsoft Sans Serif", 14.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.btnEP.ForeColor = System.Drawing.SystemColors.ButtonFace
        Me.btnEP.Location = New System.Drawing.Point(26, 402)
        Me.btnEP.Name = "btnEP"
        Me.btnEP.Size = New System.Drawing.Size(202, 36)
        Me.btnEP.TabIndex = 63
        Me.btnEP.Text = "ELIMINAR"
        Me.btnEP.UseVisualStyleBackColor = False
        '
        'PRECIOCOMP
        '
        Me.PRECIOCOMP.Location = New System.Drawing.Point(140, 175)
        Me.PRECIOCOMP.Name = "PRECIOCOMP"
        Me.PRECIOCOMP.Size = New System.Drawing.Size(128, 20)
        Me.PRECIOCOMP.TabIndex = 62
        '
        'Label4
        '
        Me.Label4.AutoSize = True
        Me.Label4.Location = New System.Drawing.Point(23, 177)
        Me.Label4.Name = "Label4"
        Me.Label4.Size = New System.Drawing.Size(78, 13)
        Me.Label4.TabIndex = 61
        Me.Label4.Text = "PRECIOCOMP"
        '
        'btnSalir
        '
        Me.btnSalir.BackColor = System.Drawing.Color.Navy
        Me.btnSalir.Font = New System.Drawing.Font("Microsoft Sans Serif", 14.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.btnSalir.ForeColor = System.Drawing.SystemColors.ButtonFace
        Me.btnSalir.Location = New System.Drawing.Point(575, 382)
        Me.btnSalir.Name = "btnSalir"
        Me.btnSalir.Size = New System.Drawing.Size(153, 32)
        Me.btnSalir.TabIndex = 60
        Me.btnSalir.Text = "SALIR"
        Me.btnSalir.UseVisualStyleBackColor = False
        '
        'btnModP
        '
        Me.btnModP.BackColor = System.Drawing.Color.LightSteelBlue
        Me.btnModP.Location = New System.Drawing.Point(405, 345)
        Me.btnModP.Name = "btnModP"
        Me.btnModP.Size = New System.Drawing.Size(153, 32)
        Me.btnModP.TabIndex = 59
        Me.btnModP.Text = "MOD. PRODUCTOS"
        Me.btnModP.UseVisualStyleBackColor = False
        '
        'btnConsultaP
        '
        Me.btnConsultaP.BackColor = System.Drawing.Color.CornflowerBlue
        Me.btnConsultaP.Font = New System.Drawing.Font("Microsoft Sans Serif", 14.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.btnConsultaP.Location = New System.Drawing.Point(26, 319)
        Me.btnConsultaP.Name = "btnConsultaP"
        Me.btnConsultaP.Size = New System.Drawing.Size(202, 36)
        Me.btnConsultaP.TabIndex = 58
        Me.btnConsultaP.Text = "CONSULTAR"
        Me.btnConsultaP.UseVisualStyleBackColor = False
        '
        'ESTADO
        '
        Me.ESTADO.Location = New System.Drawing.Point(140, 282)
        Me.ESTADO.Name = "ESTADO"
        Me.ESTADO.Size = New System.Drawing.Size(128, 20)
        Me.ESTADO.TabIndex = 57
        '
        'EXISTENCIASP
        '
        Me.EXISTENCIASP.Location = New System.Drawing.Point(140, 247)
        Me.EXISTENCIASP.Name = "EXISTENCIASP"
        Me.EXISTENCIASP.Size = New System.Drawing.Size(128, 20)
        Me.EXISTENCIASP.TabIndex = 56
        '
        'PRECIOVTAP
        '
        Me.PRECIOVTAP.Location = New System.Drawing.Point(140, 211)
        Me.PRECIOVTAP.Name = "PRECIOVTAP"
        Me.PRECIOVTAP.Size = New System.Drawing.Size(128, 20)
        Me.PRECIOVTAP.TabIndex = 55
        '
        'DESCRIP
        '
        Me.DESCRIP.Location = New System.Drawing.Point(140, 138)
        Me.DESCRIP.MaxLength = 60
        Me.DESCRIP.Name = "DESCRIP"
        Me.DESCRIP.Size = New System.Drawing.Size(248, 20)
        Me.DESCRIP.TabIndex = 54
        '
        'NOMPROD
        '
        Me.NOMPROD.Location = New System.Drawing.Point(140, 101)
        Me.NOMPROD.MaxLength = 30
        Me.NOMPROD.Name = "NOMPROD"
        Me.NOMPROD.Size = New System.Drawing.Size(248, 20)
        Me.NOMPROD.TabIndex = 53
        '
        'CVEPROD
        '
        Me.CVEPROD.FormattingEnabled = True
        Me.CVEPROD.Location = New System.Drawing.Point(140, 64)
        Me.CVEPROD.Name = "CVEPROD"
        Me.CVEPROD.Size = New System.Drawing.Size(70, 21)
        Me.CVEPROD.TabIndex = 52
        '
        'Label7
        '
        Me.Label7.AutoSize = True
        Me.Label7.Location = New System.Drawing.Point(23, 284)
        Me.Label7.Name = "Label7"
        Me.Label7.Size = New System.Drawing.Size(109, 13)
        Me.Label7.TabIndex = 51
        Me.Label7.Text = "(STATUS) ESTADO: "
        '
        'Label6
        '
        Me.Label6.AutoSize = True
        Me.Label6.Location = New System.Drawing.Point(25, 249)
        Me.Label6.Name = "Label6"
        Me.Label6.Size = New System.Drawing.Size(87, 13)
        Me.Label6.TabIndex = 50
        Me.Label6.Text = "EXISTENCIASP:"
        '
        'Label5
        '
        Me.Label5.AutoSize = True
        Me.Label5.Location = New System.Drawing.Point(24, 213)
        Me.Label5.Name = "Label5"
        Me.Label5.Size = New System.Drawing.Size(78, 13)
        Me.Label5.TabIndex = 49
        Me.Label5.Text = "PRECIOVTAP:"
        '
        'Label3
        '
        Me.Label3.AutoSize = True
        Me.Label3.Location = New System.Drawing.Point(23, 140)
        Me.Label3.Name = "Label3"
        Me.Label3.Size = New System.Drawing.Size(54, 13)
        Me.Label3.TabIndex = 48
        Me.Label3.Text = "DESCRIP"
        '
        'Label2
        '
        Me.Label2.AutoSize = True
        Me.Label2.Location = New System.Drawing.Point(23, 103)
        Me.Label2.Name = "Label2"
        Me.Label2.Size = New System.Drawing.Size(42, 13)
        Me.Label2.TabIndex = 47
        Me.Label2.Text = "NOMP:"
        '
        'Label1
        '
        Me.Label1.AutoSize = True
        Me.Label1.Location = New System.Drawing.Point(24, 68)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(62, 13)
        Me.Label1.TabIndex = 46
        Me.Label1.Text = "CVEPROD:"
        '
        'PanelOPP
        '
        Me.PanelOPP.Anchor = CType(((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Bottom) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.PanelOPP.BackColor = System.Drawing.SystemColors.GradientInactiveCaption
        Me.PanelOPP.Controls.Add(Me.Button1)
        Me.PanelOPP.Controls.Add(Me.Button2)
        Me.PanelOPP.Controls.Add(Me.Label12)
        Me.PanelOPP.Controls.Add(Me.combomod)
        Me.PanelOPP.Controls.Add(Me.Label9)
        Me.PanelOPP.Controls.Add(Me.btnModDP)
        Me.PanelOPP.Controls.Add(Me.txtnompro)
        Me.PanelOPP.Controls.Add(Me.Label8)
        Me.PanelOPP.Controls.Add(Me.txtdescp)
        Me.PanelOPP.Controls.Add(Me.btnModNP)
        Me.PanelOPP.Location = New System.Drawing.Point(404, 40)
        Me.PanelOPP.Name = "PanelOPP"
        Me.PanelOPP.Size = New System.Drawing.Size(325, 287)
        Me.PanelOPP.TabIndex = 45
        Me.PanelOPP.Visible = False
        '
        'Button1
        '
        Me.Button1.BackColor = System.Drawing.Color.Navy
        Me.Button1.ForeColor = System.Drawing.SystemColors.ButtonFace
        Me.Button1.Location = New System.Drawing.Point(157, 225)
        Me.Button1.Name = "Button1"
        Me.Button1.Size = New System.Drawing.Size(101, 32)
        Me.Button1.TabIndex = 48
        Me.Button1.Text = "REGRESAR"
        Me.Button1.UseVisualStyleBackColor = False
        '
        'Button2
        '
        Me.Button2.BackColor = System.Drawing.Color.Navy
        Me.Button2.ForeColor = System.Drawing.SystemColors.ButtonFace
        Me.Button2.Location = New System.Drawing.Point(25, 225)
        Me.Button2.Name = "Button2"
        Me.Button2.Size = New System.Drawing.Size(97, 32)
        Me.Button2.TabIndex = 47
        Me.Button2.Text = "CANCELAR"
        Me.Button2.UseVisualStyleBackColor = False
        Me.Button2.Visible = False
        '
        'Label12
        '
        Me.Label12.AutoSize = True
        Me.Label12.Location = New System.Drawing.Point(22, 22)
        Me.Label12.Name = "Label12"
        Me.Label12.Size = New System.Drawing.Size(62, 13)
        Me.Label12.TabIndex = 43
        Me.Label12.Text = "CVEPROD:"
        '
        'combomod
        '
        Me.combomod.DisplayMember = "uno"
        Me.combomod.FormattingEnabled = True
        Me.combomod.Location = New System.Drawing.Point(83, 19)
        Me.combomod.Name = "combomod"
        Me.combomod.Size = New System.Drawing.Size(70, 21)
        Me.combomod.TabIndex = 42
        '
        'Label9
        '
        Me.Label9.AutoSize = True
        Me.Label9.Location = New System.Drawing.Point(22, 47)
        Me.Label9.Name = "Label9"
        Me.Label9.Size = New System.Drawing.Size(121, 13)
        Me.Label9.TabIndex = 22
        Me.Label9.Text = "NOMBRE PRODUCTO:"
        '
        'btnModDP
        '
        Me.btnModDP.BackColor = System.Drawing.Color.CornflowerBlue
        Me.btnModDP.Location = New System.Drawing.Point(25, 169)
        Me.btnModDP.Name = "btnModDP"
        Me.btnModDP.Size = New System.Drawing.Size(233, 32)
        Me.btnModDP.TabIndex = 17
        Me.btnModDP.Text = "MOD. DESCRIPCION"
        Me.btnModDP.UseVisualStyleBackColor = False
        '
        'txtnompro
        '
        Me.txtnompro.Location = New System.Drawing.Point(25, 64)
        Me.txtnompro.Name = "txtnompro"
        Me.txtnompro.Size = New System.Drawing.Size(233, 20)
        Me.txtnompro.TabIndex = 21
        '
        'Label8
        '
        Me.Label8.AutoSize = True
        Me.Label8.Location = New System.Drawing.Point(22, 127)
        Me.Label8.Name = "Label8"
        Me.Label8.Size = New System.Drawing.Size(57, 13)
        Me.Label8.TabIndex = 19
        Me.Label8.Text = "DESCRIP:"
        '
        'txtdescp
        '
        Me.txtdescp.Location = New System.Drawing.Point(25, 143)
        Me.txtdescp.Name = "txtdescp"
        Me.txtdescp.Size = New System.Drawing.Size(233, 20)
        Me.txtdescp.TabIndex = 18
        '
        'btnModNP
        '
        Me.btnModNP.BackColor = System.Drawing.Color.CornflowerBlue
        Me.btnModNP.Location = New System.Drawing.Point(25, 90)
        Me.btnModNP.Name = "btnModNP"
        Me.btnModNP.Size = New System.Drawing.Size(235, 32)
        Me.btnModNP.TabIndex = 17
        Me.btnModNP.Text = "MODIFICAR"
        Me.btnModNP.UseVisualStyleBackColor = False
        '
        'Label17
        '
        Me.Label17.AutoSize = True
        Me.Label17.Font = New System.Drawing.Font("Microsoft Sans Serif", 20.0!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label17.ForeColor = System.Drawing.SystemColors.ButtonFace
        Me.Label17.Location = New System.Drawing.Point(3, 1)
        Me.Label17.Margin = New System.Windows.Forms.Padding(2, 0, 2, 0)
        Me.Label17.Name = "Label17"
        Me.Label17.Size = New System.Drawing.Size(301, 31)
        Me.Label17.TabIndex = 0
        Me.Label17.Text = "Farmacia San Antonio"
        '
        'Panel1
        '
        Me.Panel1.BackColor = System.Drawing.Color.Navy
        Me.Panel1.BackgroundImageLayout = System.Windows.Forms.ImageLayout.None
        Me.Panel1.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.Panel1.Controls.Add(Me.Label17)
        Me.Panel1.Dock = System.Windows.Forms.DockStyle.Top
        Me.Panel1.Location = New System.Drawing.Point(0, 0)
        Me.Panel1.Margin = New System.Windows.Forms.Padding(2)
        Me.Panel1.Name = "Panel1"
        Me.Panel1.Size = New System.Drawing.Size(745, 35)
        Me.Panel1.TabIndex = 84
        '
        'ProductosGral
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.BackgroundImage = Global.FarmaciaSanAntonio.My.Resources.Resources.farmaantonio3
        Me.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Zoom
        Me.ClientSize = New System.Drawing.Size(745, 450)
        Me.Controls.Add(Me.Panel1)
        Me.Controls.Add(Me.PanelRP)
        Me.Controls.Add(Me.btnRP)
        Me.Controls.Add(Me.PanelTP)
        Me.Controls.Add(Me.PanelEP)
        Me.Controls.Add(Me.btnInsP)
        Me.Controls.Add(Me.btnBajaTP)
        Me.Controls.Add(Me.btnEP)
        Me.Controls.Add(Me.PRECIOCOMP)
        Me.Controls.Add(Me.Label4)
        Me.Controls.Add(Me.btnSalir)
        Me.Controls.Add(Me.btnModP)
        Me.Controls.Add(Me.btnConsultaP)
        Me.Controls.Add(Me.ESTADO)
        Me.Controls.Add(Me.EXISTENCIASP)
        Me.Controls.Add(Me.PRECIOVTAP)
        Me.Controls.Add(Me.DESCRIP)
        Me.Controls.Add(Me.NOMPROD)
        Me.Controls.Add(Me.CVEPROD)
        Me.Controls.Add(Me.Label7)
        Me.Controls.Add(Me.Label6)
        Me.Controls.Add(Me.Label5)
        Me.Controls.Add(Me.Label3)
        Me.Controls.Add(Me.Label2)
        Me.Controls.Add(Me.Label1)
        Me.Controls.Add(Me.PanelOPP)
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.None
        Me.Name = "ProductosGral"
        Me.Text = "ProductosGral"
        Me.PanelRP.ResumeLayout(False)
        Me.PanelRP.PerformLayout()
        Me.PanelTP.ResumeLayout(False)
        Me.PanelTP.PerformLayout()
        Me.PanelEP.ResumeLayout(False)
        Me.PanelEP.PerformLayout()
        Me.PanelOPP.ResumeLayout(False)
        Me.PanelOPP.PerformLayout()
        Me.Panel1.ResumeLayout(False)
        Me.Panel1.PerformLayout()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub

    Friend WithEvents PanelRP As Panel
    Friend WithEvents Label15 As Label
    Friend WithEvents btnre4 As Button
    Public WithEvents comboreac As ComboBox
    Friend WithEvents btnReacP As Button
    Friend WithEvents Label16 As Label
    Friend WithEvents btnRP As Button
    Friend WithEvents PanelTP As Panel
    Friend WithEvents Label14 As Label
    Friend WithEvents btnre3 As Button
    Public WithEvents combotemporal As ComboBox
    Friend WithEvents btnBajaTempP As Button
    Friend WithEvents Label11 As Label
    Friend WithEvents PanelEP As Panel
    Friend WithEvents Label13 As Label
    Friend WithEvents btnre2 As Button
    Friend WithEvents Label10 As Label
    Friend WithEvents ElimProd As Button
    Public WithEvents comboeliminar As ComboBox
    Friend WithEvents btnInsP As Button
    Friend WithEvents btnBajaTP As Button
    Friend WithEvents btnEP As Button
    Public WithEvents PRECIOCOMP As TextBox
    Friend WithEvents Label4 As Label
    Friend WithEvents btnSalir As Button
    Friend WithEvents btnModP As Button
    Friend WithEvents btnConsultaP As Button
    Public WithEvents ESTADO As TextBox
    Public WithEvents EXISTENCIASP As TextBox
    Public WithEvents PRECIOVTAP As TextBox
    Public WithEvents DESCRIP As TextBox
    Public WithEvents NOMPROD As TextBox
    Public WithEvents CVEPROD As ComboBox
    Friend WithEvents Label7 As Label
    Friend WithEvents Label6 As Label
    Friend WithEvents Label5 As Label
    Friend WithEvents Label3 As Label
    Friend WithEvents Label2 As Label
    Friend WithEvents Label1 As Label
    Friend WithEvents PanelOPP As Panel
    Friend WithEvents Label12 As Label
    Public WithEvents combomod As ComboBox
    Friend WithEvents Label9 As Label
    Friend WithEvents btnModDP As Button
    Public WithEvents txtnompro As TextBox
    Friend WithEvents Label8 As Label
    Public WithEvents txtdescp As TextBox
    Friend WithEvents btnModNP As Button
    Friend WithEvents Button1 As Button
    Friend WithEvents Button2 As Button
    Friend WithEvents Label17 As Label
    Friend WithEvents Panel1 As Panel
End Class
