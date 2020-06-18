<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()>
Partial Class proveedores
    Inherits System.Windows.Forms.Form

    'Form reemplaza a Dispose para limpiar la lista de componentes.
    <System.Diagnostics.DebuggerNonUserCode()>
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
    <System.Diagnostics.DebuggerStepThrough()>
    Private Sub InitializeComponent()
        Me.btnEP = New System.Windows.Forms.Button()
        Me.PanelEE = New System.Windows.Forms.Panel()
        Me.Label13 = New System.Windows.Forms.Label()
        Me.btnre2 = New System.Windows.Forms.Button()
        Me.Label10 = New System.Windows.Forms.Label()
        Me.ElimMed = New System.Windows.Forms.Button()
        Me.comboeliminar = New System.Windows.Forms.ComboBox()
        Me.PanelRE = New System.Windows.Forms.Panel()
        Me.Label15 = New System.Windows.Forms.Label()
        Me.btnre4 = New System.Windows.Forms.Button()
        Me.comboreac = New System.Windows.Forms.ComboBox()
        Me.btnReac = New System.Windows.Forms.Button()
        Me.Label16 = New System.Windows.Forms.Label()
        Me.PanelEmp = New System.Windows.Forms.Panel()
        Me.CP = New System.Windows.Forms.TextBox()
        Me.ESTADO = New System.Windows.Forms.TextBox()
        Me.TELEFONO = New System.Windows.Forms.TextBox()
        Me.Label17 = New System.Windows.Forms.Label()
        Me.CORREO = New System.Windows.Forms.TextBox()
        Me.Label12 = New System.Windows.Forms.Label()
        Me.LOCALIDAD = New System.Windows.Forms.TextBox()
        Me.Label9 = New System.Windows.Forms.Label()
        Me.Label8 = New System.Windows.Forms.Label()
        Me.DIREMP = New System.Windows.Forms.TextBox()
        Me.DIRPROV = New System.Windows.Forms.TextBox()
        Me.EMPRESA = New System.Windows.Forms.TextBox()
        Me.NOMPROV = New System.Windows.Forms.TextBox()
        Me.Label7 = New System.Windows.Forms.Label()
        Me.Label6 = New System.Windows.Forms.Label()
        Me.Label5 = New System.Windows.Forms.Label()
        Me.Label4 = New System.Windows.Forms.Label()
        Me.Label3 = New System.Windows.Forms.Label()
        Me.Label2 = New System.Windows.Forms.Label()
        Me.CVPROV = New System.Windows.Forms.ComboBox()
        Me.Label1 = New System.Windows.Forms.Label()
        Me.PanelTE = New System.Windows.Forms.Panel()
        Me.Label14 = New System.Windows.Forms.Label()
        Me.btnre3 = New System.Windows.Forms.Button()
        Me.combotemporal = New System.Windows.Forms.ComboBox()
        Me.btnBajaTemp = New System.Windows.Forms.Button()
        Me.Label11 = New System.Windows.Forms.Label()
        Me.btnRP = New System.Windows.Forms.Button()
        Me.btnBajaTP = New System.Windows.Forms.Button()
        Me.btnModP = New System.Windows.Forms.Button()
        Me.salire = New System.Windows.Forms.Button()
        Me.consultae = New System.Windows.Forms.Button()
        Me.btninsertar = New System.Windows.Forms.Button()
        Me.Label18 = New System.Windows.Forms.Label()
        Me.Panel1 = New System.Windows.Forms.Panel()
        Me.PanelEE.SuspendLayout()
        Me.PanelRE.SuspendLayout()
        Me.PanelEmp.SuspendLayout()
        Me.PanelTE.SuspendLayout()
        Me.Panel1.SuspendLayout()
        Me.SuspendLayout()
        '
        'btnEP
        '
        Me.btnEP.BackColor = System.Drawing.Color.LightSteelBlue
        Me.btnEP.Location = New System.Drawing.Point(538, 248)
        Me.btnEP.Name = "btnEP"
        Me.btnEP.Size = New System.Drawing.Size(184, 32)
        Me.btnEP.TabIndex = 66
        Me.btnEP.Text = "ELIM. PROVEEDOR"
        Me.btnEP.UseVisualStyleBackColor = False
        '
        'PanelEE
        '
        Me.PanelEE.Anchor = CType(((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Bottom) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.PanelEE.BackColor = System.Drawing.SystemColors.GradientInactiveCaption
        Me.PanelEE.BackgroundImageLayout = System.Windows.Forms.ImageLayout.None
        Me.PanelEE.Controls.Add(Me.Label13)
        Me.PanelEE.Controls.Add(Me.btnre2)
        Me.PanelEE.Controls.Add(Me.Label10)
        Me.PanelEE.Controls.Add(Me.ElimMed)
        Me.PanelEE.Controls.Add(Me.comboeliminar)
        Me.PanelEE.Location = New System.Drawing.Point(469, 38)
        Me.PanelEE.Name = "PanelEE"
        Me.PanelEE.Size = New System.Drawing.Size(326, 123)
        Me.PanelEE.TabIndex = 65
        Me.PanelEE.Visible = False
        '
        'Label13
        '
        Me.Label13.AutoSize = True
        Me.Label13.Location = New System.Drawing.Point(13, 45)
        Me.Label13.Name = "Label13"
        Me.Label13.Size = New System.Drawing.Size(102, 13)
        Me.Label13.TabIndex = 44
        Me.Label13.Text = "CVE PROVEEDOR:"
        '
        'btnre2
        '
        Me.btnre2.BackColor = System.Drawing.Color.Navy
        Me.btnre2.ForeColor = System.Drawing.SystemColors.ButtonFace
        Me.btnre2.Location = New System.Drawing.Point(186, 73)
        Me.btnre2.Name = "btnre2"
        Me.btnre2.Size = New System.Drawing.Size(120, 32)
        Me.btnre2.TabIndex = 41
        Me.btnre2.Text = "REGRESAR"
        Me.btnre2.UseVisualStyleBackColor = False
        '
        'Label10
        '
        Me.Label10.AutoSize = True
        Me.Label10.Location = New System.Drawing.Point(71, 18)
        Me.Label10.Name = "Label10"
        Me.Label10.Size = New System.Drawing.Size(179, 13)
        Me.Label10.TabIndex = 40
        Me.Label10.Text = "ELIMINACIÓN DE PROVEEDORES"
        '
        'ElimMed
        '
        Me.ElimMed.BackColor = System.Drawing.Color.CornflowerBlue
        Me.ElimMed.Location = New System.Drawing.Point(16, 73)
        Me.ElimMed.Name = "ElimMed"
        Me.ElimMed.Size = New System.Drawing.Size(164, 32)
        Me.ElimMed.TabIndex = 38
        Me.ElimMed.Text = "ELIMINAR PROVEEDOR"
        Me.ElimMed.UseVisualStyleBackColor = False
        '
        'comboeliminar
        '
        Me.comboeliminar.DisplayMember = "uno"
        Me.comboeliminar.FormattingEnabled = True
        Me.comboeliminar.Location = New System.Drawing.Point(119, 43)
        Me.comboeliminar.Name = "comboeliminar"
        Me.comboeliminar.Size = New System.Drawing.Size(188, 21)
        Me.comboeliminar.TabIndex = 39
        '
        'PanelRE
        '
        Me.PanelRE.Anchor = CType(((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Bottom) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.PanelRE.BackColor = System.Drawing.SystemColors.GradientInactiveCaption
        Me.PanelRE.Controls.Add(Me.Label15)
        Me.PanelRE.Controls.Add(Me.btnre4)
        Me.PanelRE.Controls.Add(Me.comboreac)
        Me.PanelRE.Controls.Add(Me.btnReac)
        Me.PanelRE.Controls.Add(Me.Label16)
        Me.PanelRE.Location = New System.Drawing.Point(469, 38)
        Me.PanelRE.Name = "PanelRE"
        Me.PanelRE.Size = New System.Drawing.Size(326, 123)
        Me.PanelRE.TabIndex = 64
        Me.PanelRE.Visible = False
        '
        'Label15
        '
        Me.Label15.AutoSize = True
        Me.Label15.Location = New System.Drawing.Point(13, 46)
        Me.Label15.Name = "Label15"
        Me.Label15.Size = New System.Drawing.Size(102, 13)
        Me.Label15.TabIndex = 44
        Me.Label15.Text = "CVE PROVEEDOR:"
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
        Me.comboreac.Location = New System.Drawing.Point(119, 44)
        Me.comboreac.Name = "comboreac"
        Me.comboreac.Size = New System.Drawing.Size(188, 21)
        Me.comboreac.TabIndex = 41
        '
        'btnReac
        '
        Me.btnReac.BackColor = System.Drawing.Color.CornflowerBlue
        Me.btnReac.Location = New System.Drawing.Point(16, 77)
        Me.btnReac.Name = "btnReac"
        Me.btnReac.Size = New System.Drawing.Size(164, 32)
        Me.btnReac.TabIndex = 40
        Me.btnReac.Text = "REACTIVAR "
        Me.btnReac.UseVisualStyleBackColor = False
        '
        'Label16
        '
        Me.Label16.AutoSize = True
        Me.Label16.Location = New System.Drawing.Point(60, 16)
        Me.Label16.Name = "Label16"
        Me.Label16.Size = New System.Drawing.Size(189, 13)
        Me.Label16.TabIndex = 40
        Me.Label16.Text = "REACTIVACION DE PROVEEDORES"
        '
        'PanelEmp
        '
        Me.PanelEmp.BackColor = System.Drawing.Color.Lavender
        Me.PanelEmp.Controls.Add(Me.CP)
        Me.PanelEmp.Controls.Add(Me.ESTADO)
        Me.PanelEmp.Controls.Add(Me.TELEFONO)
        Me.PanelEmp.Controls.Add(Me.Label17)
        Me.PanelEmp.Controls.Add(Me.CORREO)
        Me.PanelEmp.Controls.Add(Me.Label12)
        Me.PanelEmp.Controls.Add(Me.LOCALIDAD)
        Me.PanelEmp.Controls.Add(Me.Label9)
        Me.PanelEmp.Controls.Add(Me.Label8)
        Me.PanelEmp.Controls.Add(Me.DIREMP)
        Me.PanelEmp.Controls.Add(Me.DIRPROV)
        Me.PanelEmp.Controls.Add(Me.EMPRESA)
        Me.PanelEmp.Controls.Add(Me.NOMPROV)
        Me.PanelEmp.Controls.Add(Me.Label7)
        Me.PanelEmp.Controls.Add(Me.Label6)
        Me.PanelEmp.Controls.Add(Me.Label5)
        Me.PanelEmp.Controls.Add(Me.Label4)
        Me.PanelEmp.Controls.Add(Me.Label3)
        Me.PanelEmp.Controls.Add(Me.Label2)
        Me.PanelEmp.Controls.Add(Me.CVPROV)
        Me.PanelEmp.Controls.Add(Me.Label1)
        Me.PanelEmp.Location = New System.Drawing.Point(6, 39)
        Me.PanelEmp.Name = "PanelEmp"
        Me.PanelEmp.Size = New System.Drawing.Size(457, 372)
        Me.PanelEmp.TabIndex = 62
        '
        'CP
        '
        Me.CP.Location = New System.Drawing.Point(142, 259)
        Me.CP.MaxLength = 8
        Me.CP.Name = "CP"
        Me.CP.Size = New System.Drawing.Size(307, 20)
        Me.CP.TabIndex = 56
        '
        'ESTADO
        '
        Me.ESTADO.Location = New System.Drawing.Point(142, 231)
        Me.ESTADO.MaxLength = 20
        Me.ESTADO.Name = "ESTADO"
        Me.ESTADO.Size = New System.Drawing.Size(307, 20)
        Me.ESTADO.TabIndex = 55
        '
        'TELEFONO
        '
        Me.TELEFONO.Location = New System.Drawing.Point(142, 203)
        Me.TELEFONO.MaxLength = 15
        Me.TELEFONO.Name = "TELEFONO"
        Me.TELEFONO.Size = New System.Drawing.Size(307, 20)
        Me.TELEFONO.TabIndex = 54
        '
        'Label17
        '
        Me.Label17.AutoSize = True
        Me.Label17.Location = New System.Drawing.Point(7, 318)
        Me.Label17.Name = "Label17"
        Me.Label17.Size = New System.Drawing.Size(135, 13)
        Me.Label17.TabIndex = 53
        Me.Label17.Text = "CORREO ELECTRÓNICO:"
        '
        'CORREO
        '
        Me.CORREO.Location = New System.Drawing.Point(142, 316)
        Me.CORREO.MaxLength = 30
        Me.CORREO.Name = "CORREO"
        Me.CORREO.Size = New System.Drawing.Size(307, 20)
        Me.CORREO.TabIndex = 51
        '
        'Label12
        '
        Me.Label12.AutoSize = True
        Me.Label12.Location = New System.Drawing.Point(7, 261)
        Me.Label12.Name = "Label12"
        Me.Label12.Size = New System.Drawing.Size(97, 13)
        Me.Label12.TabIndex = 49
        Me.Label12.Text = "CÓDIGO POSTAL:"
        '
        'LOCALIDAD
        '
        Me.LOCALIDAD.Location = New System.Drawing.Point(142, 289)
        Me.LOCALIDAD.MaxLength = 30
        Me.LOCALIDAD.Name = "LOCALIDAD"
        Me.LOCALIDAD.Size = New System.Drawing.Size(307, 20)
        Me.LOCALIDAD.TabIndex = 48
        '
        'Label9
        '
        Me.Label9.AutoSize = True
        Me.Label9.Location = New System.Drawing.Point(7, 291)
        Me.Label9.Name = "Label9"
        Me.Label9.Size = New System.Drawing.Size(70, 13)
        Me.Label9.TabIndex = 47
        Me.Label9.Text = "LOCALIDAD:"
        '
        'Label8
        '
        Me.Label8.AutoSize = True
        Me.Label8.Font = New System.Drawing.Font("Microsoft Sans Serif", 11.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label8.Location = New System.Drawing.Point(161, 24)
        Me.Label8.Name = "Label8"
        Me.Label8.Size = New System.Drawing.Size(124, 18)
        Me.Label8.TabIndex = 46
        Me.Label8.Text = "PROVEEDORES"
        '
        'DIREMP
        '
        Me.DIREMP.Location = New System.Drawing.Point(142, 176)
        Me.DIREMP.MaxLength = 50
        Me.DIREMP.Name = "DIREMP"
        Me.DIREMP.Size = New System.Drawing.Size(307, 20)
        Me.DIREMP.TabIndex = 44
        '
        'DIRPROV
        '
        Me.DIRPROV.Location = New System.Drawing.Point(142, 150)
        Me.DIRPROV.MaxLength = 50
        Me.DIRPROV.Name = "DIRPROV"
        Me.DIRPROV.Size = New System.Drawing.Size(307, 20)
        Me.DIRPROV.TabIndex = 43
        '
        'EMPRESA
        '
        Me.EMPRESA.Location = New System.Drawing.Point(142, 125)
        Me.EMPRESA.MaxLength = 30
        Me.EMPRESA.Name = "EMPRESA"
        Me.EMPRESA.Size = New System.Drawing.Size(307, 20)
        Me.EMPRESA.TabIndex = 42
        '
        'NOMPROV
        '
        Me.NOMPROV.Location = New System.Drawing.Point(142, 99)
        Me.NOMPROV.MaxLength = 50
        Me.NOMPROV.Name = "NOMPROV"
        Me.NOMPROV.Size = New System.Drawing.Size(307, 20)
        Me.NOMPROV.TabIndex = 41
        '
        'Label7
        '
        Me.Label7.AutoSize = True
        Me.Label7.Location = New System.Drawing.Point(7, 233)
        Me.Label7.Name = "Label7"
        Me.Label7.Size = New System.Drawing.Size(54, 13)
        Me.Label7.TabIndex = 39
        Me.Label7.Text = "ESTADO:"
        '
        'Label6
        '
        Me.Label6.AutoSize = True
        Me.Label6.Location = New System.Drawing.Point(7, 205)
        Me.Label6.Name = "Label6"
        Me.Label6.Size = New System.Drawing.Size(67, 13)
        Me.Label6.TabIndex = 38
        Me.Label6.Text = "TELÉFONO:"
        '
        'Label5
        '
        Me.Label5.AutoSize = True
        Me.Label5.Location = New System.Drawing.Point(7, 178)
        Me.Label5.Name = "Label5"
        Me.Label5.Size = New System.Drawing.Size(124, 13)
        Me.Label5.TabIndex = 37
        Me.Label5.Text = "DIRECCIÓN EMPRESA:"
        '
        'Label4
        '
        Me.Label4.AutoSize = True
        Me.Label4.Location = New System.Drawing.Point(7, 152)
        Me.Label4.Name = "Label4"
        Me.Label4.Size = New System.Drawing.Size(102, 13)
        Me.Label4.TabIndex = 36
        Me.Label4.Text = "DIRECCIÓN PROV:"
        '
        'Label3
        '
        Me.Label3.AutoSize = True
        Me.Label3.Location = New System.Drawing.Point(7, 127)
        Me.Label3.Name = "Label3"
        Me.Label3.Size = New System.Drawing.Size(62, 13)
        Me.Label3.TabIndex = 35
        Me.Label3.Text = "EMPRESA:"
        '
        'Label2
        '
        Me.Label2.AutoSize = True
        Me.Label2.Location = New System.Drawing.Point(7, 101)
        Me.Label2.Name = "Label2"
        Me.Label2.Size = New System.Drawing.Size(128, 13)
        Me.Label2.TabIndex = 34
        Me.Label2.Text = "NOMBRE PROVEEDOR:"
        '
        'CVPROV
        '
        Me.CVPROV.FormattingEnabled = True
        Me.CVPROV.Location = New System.Drawing.Point(142, 73)
        Me.CVPROV.Name = "CVPROV"
        Me.CVPROV.Size = New System.Drawing.Size(161, 21)
        Me.CVPROV.TabIndex = 33
        '
        'Label1
        '
        Me.Label1.AutoSize = True
        Me.Label1.Location = New System.Drawing.Point(7, 75)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(54, 13)
        Me.Label1.TabIndex = 32
        Me.Label1.Text = "CVPROV:"
        '
        'PanelTE
        '
        Me.PanelTE.Anchor = CType(((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Bottom) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.PanelTE.BackColor = System.Drawing.SystemColors.GradientInactiveCaption
        Me.PanelTE.Controls.Add(Me.Label14)
        Me.PanelTE.Controls.Add(Me.btnre3)
        Me.PanelTE.Controls.Add(Me.combotemporal)
        Me.PanelTE.Controls.Add(Me.btnBajaTemp)
        Me.PanelTE.Controls.Add(Me.Label11)
        Me.PanelTE.Location = New System.Drawing.Point(469, 38)
        Me.PanelTE.Name = "PanelTE"
        Me.PanelTE.Size = New System.Drawing.Size(323, 123)
        Me.PanelTE.TabIndex = 63
        Me.PanelTE.Visible = False
        '
        'Label14
        '
        Me.Label14.AutoSize = True
        Me.Label14.Location = New System.Drawing.Point(13, 46)
        Me.Label14.Name = "Label14"
        Me.Label14.Size = New System.Drawing.Size(102, 13)
        Me.Label14.TabIndex = 44
        Me.Label14.Text = "CVE PROVEEDOR:"
        '
        'btnre3
        '
        Me.btnre3.Location = New System.Drawing.Point(186, 77)
        Me.btnre3.Name = "btnre3"
        Me.btnre3.Size = New System.Drawing.Size(120, 32)
        Me.btnre3.TabIndex = 42
        Me.btnre3.Text = "REGRESAR"
        Me.btnre3.UseVisualStyleBackColor = True
        '
        'combotemporal
        '
        Me.combotemporal.FormattingEnabled = True
        Me.combotemporal.Location = New System.Drawing.Point(132, 44)
        Me.combotemporal.Name = "combotemporal"
        Me.combotemporal.Size = New System.Drawing.Size(175, 21)
        Me.combotemporal.TabIndex = 41
        '
        'btnBajaTemp
        '
        Me.btnBajaTemp.Location = New System.Drawing.Point(16, 77)
        Me.btnBajaTemp.Name = "btnBajaTemp"
        Me.btnBajaTemp.Size = New System.Drawing.Size(164, 32)
        Me.btnBajaTemp.TabIndex = 40
        Me.btnBajaTemp.Text = "DAR DE BAJA TEMP"
        Me.btnBajaTemp.UseVisualStyleBackColor = True
        '
        'Label11
        '
        Me.Label11.AutoSize = True
        Me.Label11.Location = New System.Drawing.Point(58, 16)
        Me.Label11.Name = "Label11"
        Me.Label11.Size = New System.Drawing.Size(198, 13)
        Me.Label11.TabIndex = 40
        Me.Label11.Text = "BAJA TEMPORAL DE PROVEEDORES"
        '
        'btnRP
        '
        Me.btnRP.BackColor = System.Drawing.Color.LightSteelBlue
        Me.btnRP.Location = New System.Drawing.Point(538, 208)
        Me.btnRP.Name = "btnRP"
        Me.btnRP.Size = New System.Drawing.Size(184, 32)
        Me.btnRP.TabIndex = 61
        Me.btnRP.Text = "REAC. PROVEEDOR"
        Me.btnRP.UseVisualStyleBackColor = False
        '
        'btnBajaTP
        '
        Me.btnBajaTP.BackColor = System.Drawing.Color.LightSteelBlue
        Me.btnBajaTP.Location = New System.Drawing.Point(538, 168)
        Me.btnBajaTP.Name = "btnBajaTP"
        Me.btnBajaTP.Size = New System.Drawing.Size(184, 32)
        Me.btnBajaTP.TabIndex = 60
        Me.btnBajaTP.Text = "BAJA TEMP PROVEEDORES"
        Me.btnBajaTP.UseVisualStyleBackColor = False
        '
        'btnModP
        '
        Me.btnModP.BackColor = System.Drawing.Color.LightSteelBlue
        Me.btnModP.Location = New System.Drawing.Point(538, 290)
        Me.btnModP.Name = "btnModP"
        Me.btnModP.Size = New System.Drawing.Size(184, 32)
        Me.btnModP.TabIndex = 59
        Me.btnModP.Text = "MOD. PROVEEDOR"
        Me.btnModP.UseVisualStyleBackColor = False
        '
        'salire
        '
        Me.salire.BackColor = System.Drawing.Color.Navy
        Me.salire.Font = New System.Drawing.Font("Microsoft Sans Serif", 14.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.salire.ForeColor = System.Drawing.Color.White
        Me.salire.Location = New System.Drawing.Point(656, 369)
        Me.salire.Name = "salire"
        Me.salire.Size = New System.Drawing.Size(119, 36)
        Me.salire.TabIndex = 58
        Me.salire.Text = "SALIR"
        Me.salire.UseVisualStyleBackColor = False
        '
        'consultae
        '
        Me.consultae.BackColor = System.Drawing.Color.CornflowerBlue
        Me.consultae.Font = New System.Drawing.Font("Microsoft Sans Serif", 14.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.consultae.ForeColor = System.Drawing.Color.Black
        Me.consultae.Location = New System.Drawing.Point(469, 375)
        Me.consultae.Name = "consultae"
        Me.consultae.Size = New System.Drawing.Size(145, 36)
        Me.consultae.TabIndex = 57
        Me.consultae.Text = "CONSULTAR"
        Me.consultae.UseVisualStyleBackColor = False
        '
        'btninsertar
        '
        Me.btninsertar.BackColor = System.Drawing.Color.CornflowerBlue
        Me.btninsertar.Font = New System.Drawing.Font("Microsoft Sans Serif", 14.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.btninsertar.ForeColor = System.Drawing.Color.Black
        Me.btninsertar.Location = New System.Drawing.Point(469, 333)
        Me.btninsertar.Name = "btninsertar"
        Me.btninsertar.Size = New System.Drawing.Size(145, 36)
        Me.btninsertar.TabIndex = 56
        Me.btninsertar.Text = "INSERTAR"
        Me.btninsertar.UseVisualStyleBackColor = False
        '
        'Label18
        '
        Me.Label18.AutoSize = True
        Me.Label18.Font = New System.Drawing.Font("Microsoft Sans Serif", 20.0!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label18.ForeColor = System.Drawing.SystemColors.ButtonFace
        Me.Label18.Location = New System.Drawing.Point(3, 1)
        Me.Label18.Margin = New System.Windows.Forms.Padding(2, 0, 2, 0)
        Me.Label18.Name = "Label18"
        Me.Label18.Size = New System.Drawing.Size(301, 31)
        Me.Label18.TabIndex = 0
        Me.Label18.Text = "Farmacia San Antonio"
        '
        'Panel1
        '
        Me.Panel1.BackColor = System.Drawing.Color.Navy
        Me.Panel1.BackgroundImageLayout = System.Windows.Forms.ImageLayout.None
        Me.Panel1.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.Panel1.Controls.Add(Me.Label18)
        Me.Panel1.Dock = System.Windows.Forms.DockStyle.Top
        Me.Panel1.Location = New System.Drawing.Point(0, 0)
        Me.Panel1.Margin = New System.Windows.Forms.Padding(2, 2, 2, 2)
        Me.Panel1.Name = "Panel1"
        Me.Panel1.Size = New System.Drawing.Size(809, 35)
        Me.Panel1.TabIndex = 84
        '
        'proveedores
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.BackgroundImage = Global.FarmaciaSanAntonio.My.Resources.Resources.farmaantonioi2
        Me.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Stretch
        Me.ClientSize = New System.Drawing.Size(809, 417)
        Me.Controls.Add(Me.Panel1)
        Me.Controls.Add(Me.btnEP)
        Me.Controls.Add(Me.PanelEE)
        Me.Controls.Add(Me.PanelRE)
        Me.Controls.Add(Me.PanelEmp)
        Me.Controls.Add(Me.PanelTE)
        Me.Controls.Add(Me.btnRP)
        Me.Controls.Add(Me.btnBajaTP)
        Me.Controls.Add(Me.btnModP)
        Me.Controls.Add(Me.salire)
        Me.Controls.Add(Me.consultae)
        Me.Controls.Add(Me.btninsertar)
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.None
        Me.Name = "proveedores"
        Me.Text = "Proveedores"
        Me.PanelEE.ResumeLayout(False)
        Me.PanelEE.PerformLayout()
        Me.PanelRE.ResumeLayout(False)
        Me.PanelRE.PerformLayout()
        Me.PanelEmp.ResumeLayout(False)
        Me.PanelEmp.PerformLayout()
        Me.PanelTE.ResumeLayout(False)
        Me.PanelTE.PerformLayout()
        Me.Panel1.ResumeLayout(False)
        Me.Panel1.PerformLayout()
        Me.ResumeLayout(False)

    End Sub

    Friend WithEvents btnEP As Button
    Friend WithEvents PanelEE As Panel
    Friend WithEvents Label13 As Label
    Friend WithEvents btnre2 As Button
    Friend WithEvents Label10 As Label
    Friend WithEvents ElimMed As Button
    Public WithEvents comboeliminar As ComboBox
    Friend WithEvents PanelRE As Panel
    Friend WithEvents Label15 As Label
    Friend WithEvents btnre4 As Button
    Public WithEvents comboreac As ComboBox
    Friend WithEvents btnReac As Button
    Friend WithEvents Label16 As Label
    Friend WithEvents PanelEmp As Panel
    Friend WithEvents Label17 As Label
    Friend WithEvents CORREO As TextBox
    Friend WithEvents Label12 As Label
    Friend WithEvents LOCALIDAD As TextBox
    Friend WithEvents Label9 As Label
    Friend WithEvents Label8 As Label
    Friend WithEvents DIREMP As TextBox
    Friend WithEvents DIRPROV As TextBox
    Friend WithEvents EMPRESA As TextBox
    Friend WithEvents NOMPROV As TextBox
    Friend WithEvents Label7 As Label
    Friend WithEvents Label6 As Label
    Friend WithEvents Label5 As Label
    Friend WithEvents Label4 As Label
    Friend WithEvents Label3 As Label
    Friend WithEvents Label2 As Label
    Friend WithEvents CVPROV As ComboBox
    Friend WithEvents Label1 As Label
    Friend WithEvents PanelTE As Panel
    Friend WithEvents Label14 As Label
    Friend WithEvents btnre3 As Button
    Public WithEvents combotemporal As ComboBox
    Friend WithEvents btnBajaTemp As Button
    Friend WithEvents Label11 As Label
    Friend WithEvents btnRP As Button
    Friend WithEvents btnBajaTP As Button
    Friend WithEvents btnModP As Button
    Friend WithEvents salire As Button
    Friend WithEvents consultae As Button
    Friend WithEvents btninsertar As Button
    Friend WithEvents CP As TextBox
    Friend WithEvents ESTADO As TextBox
    Friend WithEvents TELEFONO As TextBox
    Friend WithEvents Label18 As Label
    Friend WithEvents Panel1 As Panel
End Class
