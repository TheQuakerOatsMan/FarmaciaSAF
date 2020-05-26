<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()>
Partial Class NewCompra
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
        Me.components = New System.ComponentModel.Container()
        Me.Medicamentos = New System.Windows.Forms.DataGridView()
        Me.MEDICAMENTOSBindingSource = New System.Windows.Forms.BindingSource(Me.components)
        Me.FarmSAntonioDataSet2 = New FarmaciaSanAntonio.FarmSAntonioDataSet2()
        Me.btnRegMed = New System.Windows.Forms.Button()
        Me.btnAgrMed = New System.Windows.Forms.Button()
        Me.btnAgreProd = New System.Windows.Forms.Button()
        Me.btnRegProd = New System.Windows.Forms.Button()
        Me.Productos = New System.Windows.Forms.DataGridView()
        Me.PRODUCTOSBindingSource = New System.Windows.Forms.BindingSource(Me.components)
        Me.FarmSAntonioDataSet3 = New FarmaciaSanAntonio.FarmSAntonioDataSet3()
        Me.Label9 = New System.Windows.Forms.Label()
        Me.Label8 = New System.Windows.Forms.Label()
        Me.data2 = New System.Windows.Forms.DataGridView()
        Me.data1 = New System.Windows.Forms.DataGridView()
        Me.addm = New System.Windows.Forms.Button()
        Me.btnadd = New System.Windows.Forms.Button()
        Me.btnCancel = New System.Windows.Forms.Button()
        Me.panelTotal = New System.Windows.Forms.Panel()
        Me.Label7 = New System.Windows.Forms.Label()
        Me.fechaCom = New System.Windows.Forms.TextBox()
        Me.Label6 = New System.Windows.Forms.Label()
        Me.subt = New System.Windows.Forms.TextBox()
        Me.btnReComp = New System.Windows.Forms.Button()
        Me.ctNEmp = New System.Windows.Forms.TextBox()
        Me.Label2 = New System.Windows.Forms.Label()
        Me.ctemp = New System.Windows.Forms.TextBox()
        Me.Label1 = New System.Windows.Forms.Label()
        Me.cvcomp = New System.Windows.Forms.TextBox()
        Me.Label5 = New System.Windows.Forms.Label()
        Me.MEDICAMENTOSTableAdapter = New FarmaciaSanAntonio.FarmSAntonioDataSet2TableAdapters.MEDICAMENTOSTableAdapter()
        Me.PRODUCTOSTableAdapter = New FarmaciaSanAntonio.FarmSAntonioDataSet3TableAdapters.PRODUCTOSTableAdapter()
        CType(Me.Medicamentos, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.MEDICAMENTOSBindingSource, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.FarmSAntonioDataSet2, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.Productos, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.PRODUCTOSBindingSource, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.FarmSAntonioDataSet3, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.data2, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.data1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.panelTotal.SuspendLayout()
        Me.SuspendLayout()
        '
        'Medicamentos
        '
        Me.Medicamentos.Anchor = CType(((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Bottom) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.Medicamentos.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize
        Me.Medicamentos.Location = New System.Drawing.Point(297, 9)
        Me.Medicamentos.Name = "Medicamentos"
        Me.Medicamentos.RowHeadersWidth = 62
        Me.Medicamentos.Size = New System.Drawing.Size(394, 188)
        Me.Medicamentos.TabIndex = 73
        '
        'MEDICAMENTOSBindingSource
        '
        Me.MEDICAMENTOSBindingSource.DataMember = "MEDICAMENTOS"
        Me.MEDICAMENTOSBindingSource.DataSource = Me.FarmSAntonioDataSet2
        '
        'FarmSAntonioDataSet2
        '
        Me.FarmSAntonioDataSet2.DataSetName = "FarmSAntonioDataSet2"
        Me.FarmSAntonioDataSet2.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema
        '
        'btnRegMed
        '
        Me.btnRegMed.BackColor = System.Drawing.Color.Navy
        Me.btnRegMed.ForeColor = System.Drawing.SystemColors.ButtonFace
        Me.btnRegMed.Location = New System.Drawing.Point(582, 214)
        Me.btnRegMed.Name = "btnRegMed"
        Me.btnRegMed.Size = New System.Drawing.Size(118, 27)
        Me.btnRegMed.TabIndex = 72
        Me.btnRegMed.Text = "REGRESAR"
        Me.btnRegMed.UseVisualStyleBackColor = False
        '
        'btnAgrMed
        '
        Me.btnAgrMed.BackColor = System.Drawing.Color.CornflowerBlue
        Me.btnAgrMed.Location = New System.Drawing.Point(456, 214)
        Me.btnAgrMed.Name = "btnAgrMed"
        Me.btnAgrMed.Size = New System.Drawing.Size(118, 27)
        Me.btnAgrMed.TabIndex = 71
        Me.btnAgrMed.Text = "AGREGAR"
        Me.btnAgrMed.UseVisualStyleBackColor = False
        '
        'btnAgreProd
        '
        Me.btnAgreProd.BackColor = System.Drawing.Color.CornflowerBlue
        Me.btnAgreProd.Location = New System.Drawing.Point(456, 214)
        Me.btnAgreProd.Name = "btnAgreProd"
        Me.btnAgreProd.Size = New System.Drawing.Size(118, 27)
        Me.btnAgreProd.TabIndex = 70
        Me.btnAgreProd.Text = "AGREGAR"
        Me.btnAgreProd.UseVisualStyleBackColor = False
        '
        'btnRegProd
        '
        Me.btnRegProd.BackColor = System.Drawing.Color.Navy
        Me.btnRegProd.ForeColor = System.Drawing.SystemColors.ButtonFace
        Me.btnRegProd.Location = New System.Drawing.Point(580, 214)
        Me.btnRegProd.Name = "btnRegProd"
        Me.btnRegProd.Size = New System.Drawing.Size(118, 27)
        Me.btnRegProd.TabIndex = 69
        Me.btnRegProd.Text = "REGRESAR"
        Me.btnRegProd.UseVisualStyleBackColor = False
        '
        'Productos
        '
        Me.Productos.Anchor = CType(((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Bottom) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.Productos.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize
        Me.Productos.Location = New System.Drawing.Point(297, 9)
        Me.Productos.Name = "Productos"
        Me.Productos.RowHeadersWidth = 62
        Me.Productos.Size = New System.Drawing.Size(394, 188)
        Me.Productos.TabIndex = 68
        '
        'PRODUCTOSBindingSource
        '
        Me.PRODUCTOSBindingSource.DataMember = "PRODUCTOS"
        Me.PRODUCTOSBindingSource.DataSource = Me.FarmSAntonioDataSet3
        '
        'FarmSAntonioDataSet3
        '
        Me.FarmSAntonioDataSet3.DataSetName = "FarmSAntonioDataSet3"
        Me.FarmSAntonioDataSet3.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema
        '
        'Label9
        '
        Me.Label9.AutoSize = True
        Me.Label9.Location = New System.Drawing.Point(508, 253)
        Me.Label9.Name = "Label9"
        Me.Label9.Size = New System.Drawing.Size(132, 13)
        Me.Label9.TabIndex = 67
        Me.Label9.Text = "PANEL MEDICAMENTOS"
        '
        'Label8
        '
        Me.Label8.AutoSize = True
        Me.Label8.Location = New System.Drawing.Point(266, 253)
        Me.Label8.Name = "Label8"
        Me.Label8.Size = New System.Drawing.Size(113, 13)
        Me.Label8.TabIndex = 66
        Me.Label8.Text = "PANEL PRODUCTOS"
        '
        'data2
        '
        Me.data2.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize
        Me.data2.Location = New System.Drawing.Point(208, 270)
        Me.data2.Name = "data2"
        Me.data2.RowHeadersWidth = 62
        Me.data2.Size = New System.Drawing.Size(236, 108)
        Me.data2.TabIndex = 65
        '
        'data1
        '
        Me.data1.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize
        Me.data1.Location = New System.Drawing.Point(462, 270)
        Me.data1.Name = "data1"
        Me.data1.RowHeadersWidth = 62
        Me.data1.Size = New System.Drawing.Size(236, 108)
        Me.data1.TabIndex = 64
        '
        'addm
        '
        Me.addm.BackColor = System.Drawing.Color.CornflowerBlue
        Me.addm.Location = New System.Drawing.Point(17, 307)
        Me.addm.Name = "addm"
        Me.addm.Size = New System.Drawing.Size(151, 33)
        Me.addm.TabIndex = 63
        Me.addm.Text = "AGREGAR MEDICAMENTO"
        Me.addm.UseVisualStyleBackColor = False
        '
        'btnadd
        '
        Me.btnadd.BackColor = System.Drawing.Color.CornflowerBlue
        Me.btnadd.Location = New System.Drawing.Point(17, 268)
        Me.btnadd.Name = "btnadd"
        Me.btnadd.Size = New System.Drawing.Size(151, 33)
        Me.btnadd.TabIndex = 62
        Me.btnadd.Text = "AGREGAR PRODUCTO"
        Me.btnadd.UseVisualStyleBackColor = False
        '
        'btnCancel
        '
        Me.btnCancel.BackColor = System.Drawing.Color.Navy
        Me.btnCancel.ForeColor = System.Drawing.SystemColors.ButtonFace
        Me.btnCancel.Location = New System.Drawing.Point(17, 346)
        Me.btnCancel.Name = "btnCancel"
        Me.btnCancel.Size = New System.Drawing.Size(151, 33)
        Me.btnCancel.TabIndex = 61
        Me.btnCancel.Text = "CANCELAR COMPRA"
        Me.btnCancel.UseVisualStyleBackColor = False
        '
        'panelTotal
        '
        Me.panelTotal.BackColor = System.Drawing.Color.Navy
        Me.panelTotal.Controls.Add(Me.Label7)
        Me.panelTotal.Controls.Add(Me.fechaCom)
        Me.panelTotal.Controls.Add(Me.Label6)
        Me.panelTotal.Controls.Add(Me.subt)
        Me.panelTotal.Controls.Add(Me.btnReComp)
        Me.panelTotal.Location = New System.Drawing.Point(17, 107)
        Me.panelTotal.Name = "panelTotal"
        Me.panelTotal.Size = New System.Drawing.Size(267, 140)
        Me.panelTotal.TabIndex = 60
        '
        'Label7
        '
        Me.Label7.AutoSize = True
        Me.Label7.ForeColor = System.Drawing.SystemColors.ButtonFace
        Me.Label7.Location = New System.Drawing.Point(21, 54)
        Me.Label7.Name = "Label7"
        Me.Label7.Size = New System.Drawing.Size(124, 13)
        Me.Label7.TabIndex = 20
        Me.Label7.Text = "FECHA DE COMPRA ($)"
        '
        'fechaCom
        '
        Me.fechaCom.Location = New System.Drawing.Point(149, 51)
        Me.fechaCom.Name = "fechaCom"
        Me.fechaCom.Size = New System.Drawing.Size(99, 20)
        Me.fechaCom.TabIndex = 21
        '
        'Label6
        '
        Me.Label6.AutoSize = True
        Me.Label6.ForeColor = System.Drawing.SystemColors.ButtonFace
        Me.Label6.Location = New System.Drawing.Point(21, 27)
        Me.Label6.Name = "Label6"
        Me.Label6.Size = New System.Drawing.Size(124, 13)
        Me.Label6.TabIndex = 18
        Me.Label6.Text = "TOTAL DE COMPRA($):"
        '
        'subt
        '
        Me.subt.Location = New System.Drawing.Point(149, 24)
        Me.subt.Name = "subt"
        Me.subt.Size = New System.Drawing.Size(99, 20)
        Me.subt.TabIndex = 19
        '
        'btnReComp
        '
        Me.btnReComp.AutoEllipsis = True
        Me.btnReComp.AutoSizeMode = System.Windows.Forms.AutoSizeMode.GrowAndShrink
        Me.btnReComp.BackColor = System.Drawing.Color.CornflowerBlue
        Me.btnReComp.Location = New System.Drawing.Point(57, 88)
        Me.btnReComp.Name = "btnReComp"
        Me.btnReComp.Size = New System.Drawing.Size(157, 33)
        Me.btnReComp.TabIndex = 17
        Me.btnReComp.Text = "REALIZAR COMPRA"
        Me.btnReComp.UseVisualStyleBackColor = False
        '
        'ctNEmp
        '
        Me.ctNEmp.Enabled = False
        Me.ctNEmp.Location = New System.Drawing.Point(143, 71)
        Me.ctNEmp.Name = "ctNEmp"
        Me.ctNEmp.Size = New System.Drawing.Size(142, 20)
        Me.ctNEmp.TabIndex = 59
        '
        'Label2
        '
        Me.Label2.AutoSize = True
        Me.Label2.Location = New System.Drawing.Point(14, 74)
        Me.Label2.Name = "Label2"
        Me.Label2.Size = New System.Drawing.Size(60, 13)
        Me.Label2.TabIndex = 58
        Me.Label2.Text = "Lo atiende:"
        '
        'ctemp
        '
        Me.ctemp.Enabled = False
        Me.ctemp.Location = New System.Drawing.Point(143, 43)
        Me.ctemp.Name = "ctemp"
        Me.ctemp.Size = New System.Drawing.Size(142, 20)
        Me.ctemp.TabIndex = 57
        '
        'Label1
        '
        Me.Label1.AutoSize = True
        Me.Label1.Location = New System.Drawing.Point(14, 46)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(74, 13)
        Me.Label1.TabIndex = 56
        Me.Label1.Text = "Empleado No:"
        '
        'cvcomp
        '
        Me.cvcomp.Enabled = False
        Me.cvcomp.Location = New System.Drawing.Point(143, 15)
        Me.cvcomp.Name = "cvcomp"
        Me.cvcomp.Size = New System.Drawing.Size(142, 20)
        Me.cvcomp.TabIndex = 55
        '
        'Label5
        '
        Me.Label5.AutoSize = True
        Me.Label5.Location = New System.Drawing.Point(14, 18)
        Me.Label5.Name = "Label5"
        Me.Label5.Size = New System.Drawing.Size(124, 13)
        Me.Label5.TabIndex = 54
        Me.Label5.Text = "No.Compra (CVECOMP):"
        '
        'MEDICAMENTOSTableAdapter
        '
        Me.MEDICAMENTOSTableAdapter.ClearBeforeFill = True
        '
        'PRODUCTOSTableAdapter
        '
        Me.PRODUCTOSTableAdapter.ClearBeforeFill = True
        '
        'NewCompra
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(712, 389)
        Me.Controls.Add(Me.Medicamentos)
        Me.Controls.Add(Me.btnRegMed)
        Me.Controls.Add(Me.btnAgrMed)
        Me.Controls.Add(Me.btnAgreProd)
        Me.Controls.Add(Me.btnRegProd)
        Me.Controls.Add(Me.Productos)
        Me.Controls.Add(Me.Label9)
        Me.Controls.Add(Me.Label8)
        Me.Controls.Add(Me.data2)
        Me.Controls.Add(Me.data1)
        Me.Controls.Add(Me.addm)
        Me.Controls.Add(Me.btnadd)
        Me.Controls.Add(Me.btnCancel)
        Me.Controls.Add(Me.panelTotal)
        Me.Controls.Add(Me.ctNEmp)
        Me.Controls.Add(Me.Label2)
        Me.Controls.Add(Me.ctemp)
        Me.Controls.Add(Me.Label1)
        Me.Controls.Add(Me.cvcomp)
        Me.Controls.Add(Me.Label5)
        Me.Margin = New System.Windows.Forms.Padding(2, 2, 2, 2)
        Me.Name = "NewCompra"
        Me.Text = "AgregarCompras"
        CType(Me.Medicamentos, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.MEDICAMENTOSBindingSource, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.FarmSAntonioDataSet2, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.Productos, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.PRODUCTOSBindingSource, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.FarmSAntonioDataSet3, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.data2, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.data1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.panelTotal.ResumeLayout(False)
        Me.panelTotal.PerformLayout()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub

    Friend WithEvents Medicamentos As DataGridView
    Friend WithEvents btnRegMed As Button
    Friend WithEvents btnAgrMed As Button
    Friend WithEvents btnAgreProd As Button
    Friend WithEvents btnRegProd As Button
    Friend WithEvents Productos As DataGridView
    Friend WithEvents Label9 As Label
    Friend WithEvents Label8 As Label
    Friend WithEvents data2 As DataGridView
    Friend WithEvents data1 As DataGridView
    Friend WithEvents addm As Button
    Friend WithEvents btnadd As Button
    Friend WithEvents btnCancel As Button
    Friend WithEvents panelTotal As Panel
    Friend WithEvents Label7 As Label
    Friend WithEvents fechaCom As TextBox
    Friend WithEvents Label6 As Label
    Friend WithEvents subt As TextBox
    Friend WithEvents btnReComp As Button
    Friend WithEvents ctNEmp As TextBox
    Friend WithEvents Label2 As Label
    Friend WithEvents ctemp As TextBox
    Friend WithEvents Label1 As Label
    Friend WithEvents cvcomp As TextBox
    Friend WithEvents Label5 As Label
    Friend WithEvents FarmSAntonioDataSet2 As FarmSAntonioDataSet2
    Friend WithEvents MEDICAMENTOSBindingSource As BindingSource
    Friend WithEvents MEDICAMENTOSTableAdapter As FarmSAntonioDataSet2TableAdapters.MEDICAMENTOSTableAdapter
    Friend WithEvents FarmSAntonioDataSet3 As FarmSAntonioDataSet3
    Friend WithEvents PRODUCTOSBindingSource As BindingSource
    Friend WithEvents PRODUCTOSTableAdapter As FarmSAntonioDataSet3TableAdapters.PRODUCTOSTableAdapter
End Class
