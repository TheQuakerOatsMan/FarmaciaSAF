<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class proveedores_gral
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
        Me.components = New System.ComponentModel.Container()
        Me.DataGridView11 = New System.Windows.Forms.DataGridView()
        Me.ACTIVO = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.salirprovt = New System.Windows.Forms.Button()
        Me.Label9 = New System.Windows.Forms.Label()
        Me.Panel1 = New System.Windows.Forms.Panel()
        CType(Me.DataGridView11, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.Panel1.SuspendLayout()
        Me.SuspendLayout()
        '
        'DataGridView11
        '
        Me.DataGridView11.Anchor = CType(((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.DataGridView11.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize
        Me.DataGridView11.Columns.AddRange(New System.Windows.Forms.DataGridViewColumn() {Me.ACTIVO})
        Me.DataGridView11.Location = New System.Drawing.Point(13, 62)
        Me.DataGridView11.Margin = New System.Windows.Forms.Padding(4, 5, 4, 5)
        Me.DataGridView11.Name = "DataGridView11"
        Me.DataGridView11.RowHeadersWidth = 62
        Me.DataGridView11.Size = New System.Drawing.Size(1176, 552)
        Me.DataGridView11.TabIndex = 0
        '
        'ACTIVO
        '
        Me.ACTIVO.DataPropertyName = "ACTIVO"
        Me.ACTIVO.HeaderText = "ACTIVO"
        Me.ACTIVO.MinimumWidth = 8
        Me.ACTIVO.Name = "ACTIVO"
        Me.ACTIVO.Width = 150
        '
        'PROVEEDORESBindingSource2
        '
        '
        'salirprovt
        '
        Me.salirprovt.BackColor = System.Drawing.Color.Navy
        Me.salirprovt.Font = New System.Drawing.Font("Microsoft Sans Serif", 14.25!)
        Me.salirprovt.ForeColor = System.Drawing.Color.White
        Me.salirprovt.Location = New System.Drawing.Point(1042, 622)
        Me.salirprovt.Margin = New System.Windows.Forms.Padding(4, 5, 4, 5)
        Me.salirprovt.Name = "salirprovt"
        Me.salirprovt.Size = New System.Drawing.Size(147, 58)
        Me.salirprovt.TabIndex = 1
        Me.salirprovt.Text = "SALIR"
        Me.salirprovt.UseVisualStyleBackColor = False
        '
        'PROVEEDORESBindingSource1
        '
        '
        'Label9
        '
        Me.Label9.AutoSize = True
        Me.Label9.Font = New System.Drawing.Font("Microsoft Sans Serif", 20.0!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label9.ForeColor = System.Drawing.SystemColors.ButtonFace
        Me.Label9.Location = New System.Drawing.Point(5, 1)
        Me.Label9.Name = "Label9"
        Me.Label9.Size = New System.Drawing.Size(436, 46)
        Me.Label9.TabIndex = 0
        Me.Label9.Text = "Farmacia San Antonio"
        '
        'Panel1
        '
        Me.Panel1.BackColor = System.Drawing.Color.Navy
        Me.Panel1.BackgroundImageLayout = System.Windows.Forms.ImageLayout.None
        Me.Panel1.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.Panel1.Controls.Add(Me.Label9)
        Me.Panel1.Dock = System.Windows.Forms.DockStyle.Top
        Me.Panel1.Location = New System.Drawing.Point(0, 0)
        Me.Panel1.Name = "Panel1"
        Me.Panel1.Size = New System.Drawing.Size(1200, 52)
        Me.Panel1.TabIndex = 84
        '
        'proveedores_gral
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(9.0!, 20.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(1200, 692)
        Me.Controls.Add(Me.Panel1)
        Me.Controls.Add(Me.salirprovt)
        Me.Controls.Add(Me.DataGridView11)
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.None
        Me.Margin = New System.Windows.Forms.Padding(4, 5, 4, 5)
        Me.Name = "proveedores_gral"
        Me.Text = "proveedores_gral"
        CType(Me.DataGridView11, System.ComponentModel.ISupportInitialize).EndInit()
        Me.Panel1.ResumeLayout(False)
        Me.Panel1.PerformLayout()
        Me.ResumeLayout(False)

    End Sub

    Friend WithEvents DataGridView11 As DataGridView
    Friend WithEvents salirprovt As Button
    Friend WithEvents ACTIVO As DataGridViewTextBoxColumn
    Friend WithEvents Label9 As Label
    Friend WithEvents Panel1 As Panel
End Class
