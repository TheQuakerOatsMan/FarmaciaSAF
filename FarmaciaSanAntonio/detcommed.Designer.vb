<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class detcommed
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
        Me.tipoMed = New System.Windows.Forms.ComboBox()
        Me.Label9 = New System.Windows.Forms.Label()
        Me.gananciaMed = New System.Windows.Forms.TextBox()
        Me.Label8 = New System.Windows.Forms.Label()
        Me.lotemed = New System.Windows.Forms.TextBox()
        Me.Label7 = New System.Windows.Forms.Label()
        Me.fechacadMed = New System.Windows.Forms.DateTimePicker()
        Me.Label6 = New System.Windows.Forms.Label()
        Me.precommed = New System.Windows.Forms.TextBox()
        Me.Label5 = New System.Windows.Forms.Label()
        Me.nommed = New System.Windows.Forms.TextBox()
        Me.cvemed = New System.Windows.Forms.TextBox()
        Me.Label4 = New System.Windows.Forms.Label()
        Me.btnre10 = New System.Windows.Forms.Button()
        Me.aniadirm = New System.Windows.Forms.Button()
        Me.Label3 = New System.Windows.Forms.Label()
        Me.Label2 = New System.Windows.Forms.Label()
        Me.cantidadm = New System.Windows.Forms.TextBox()
        Me.Panel1 = New System.Windows.Forms.Panel()
        Me.Label1 = New System.Windows.Forms.Label()
        Me.Panel1.SuspendLayout()
        Me.SuspendLayout()
        '
        'tipoMed
        '
        Me.tipoMed.FormattingEnabled = True
        Me.tipoMed.Items.AddRange(New Object() {"1", "2", "3"})
        Me.tipoMed.Location = New System.Drawing.Point(198, 412)
        Me.tipoMed.Margin = New System.Windows.Forms.Padding(4, 5, 4, 5)
        Me.tipoMed.Name = "tipoMed"
        Me.tipoMed.Size = New System.Drawing.Size(211, 28)
        Me.tipoMed.TabIndex = 89
        '
        'Label9
        '
        Me.Label9.AutoSize = True
        Me.Label9.Location = New System.Drawing.Point(25, 415)
        Me.Label9.Margin = New System.Windows.Forms.Padding(4, 0, 4, 0)
        Me.Label9.Name = "Label9"
        Me.Label9.Size = New System.Drawing.Size(89, 20)
        Me.Label9.TabIndex = 88
        Me.Label9.Text = "TIPO MED:"
        '
        'gananciaMed
        '
        Me.gananciaMed.Location = New System.Drawing.Point(198, 216)
        Me.gananciaMed.Margin = New System.Windows.Forms.Padding(4, 5, 4, 5)
        Me.gananciaMed.Name = "gananciaMed"
        Me.gananciaMed.Size = New System.Drawing.Size(211, 26)
        Me.gananciaMed.TabIndex = 87
        '
        'Label8
        '
        Me.Label8.AutoSize = True
        Me.Label8.Location = New System.Drawing.Point(25, 219)
        Me.Label8.Margin = New System.Windows.Forms.Padding(4, 0, 4, 0)
        Me.Label8.Name = "Label8"
        Me.Label8.Size = New System.Drawing.Size(97, 20)
        Me.Label8.TabIndex = 86
        Me.Label8.Text = "GANANCIA:"
        '
        'lotemed
        '
        Me.lotemed.Location = New System.Drawing.Point(198, 314)
        Me.lotemed.Margin = New System.Windows.Forms.Padding(4, 5, 4, 5)
        Me.lotemed.Name = "lotemed"
        Me.lotemed.Size = New System.Drawing.Size(211, 26)
        Me.lotemed.TabIndex = 85
        '
        'Label7
        '
        Me.Label7.AutoSize = True
        Me.Label7.Location = New System.Drawing.Point(25, 317)
        Me.Label7.Margin = New System.Windows.Forms.Padding(4, 0, 4, 0)
        Me.Label7.Name = "Label7"
        Me.Label7.Size = New System.Drawing.Size(54, 20)
        Me.Label7.TabIndex = 84
        Me.Label7.Text = "LOTE:"
        '
        'fechacadMed
        '
        Me.fechacadMed.Location = New System.Drawing.Point(198, 361)
        Me.fechacadMed.Name = "fechacadMed"
        Me.fechacadMed.Size = New System.Drawing.Size(211, 26)
        Me.fechacadMed.TabIndex = 83
        '
        'Label6
        '
        Me.Label6.AutoSize = True
        Me.Label6.Location = New System.Drawing.Point(25, 366)
        Me.Label6.Margin = New System.Windows.Forms.Padding(4, 0, 4, 0)
        Me.Label6.Name = "Label6"
        Me.Label6.Size = New System.Drawing.Size(102, 20)
        Me.Label6.TabIndex = 82
        Me.Label6.Text = "FECHACAD:"
        '
        'precommed
        '
        Me.precommed.Location = New System.Drawing.Point(198, 170)
        Me.precommed.Margin = New System.Windows.Forms.Padding(4, 5, 4, 5)
        Me.precommed.Name = "precommed"
        Me.precommed.Size = New System.Drawing.Size(211, 26)
        Me.precommed.TabIndex = 81
        '
        'Label5
        '
        Me.Label5.AutoSize = True
        Me.Label5.Location = New System.Drawing.Point(25, 173)
        Me.Label5.Margin = New System.Windows.Forms.Padding(4, 0, 4, 0)
        Me.Label5.Name = "Label5"
        Me.Label5.Size = New System.Drawing.Size(174, 20)
        Me.Label5.TabIndex = 80
        Me.Label5.Text = "PRECIO DE COMPRA:"
        '
        'nommed
        '
        Me.nommed.Enabled = False
        Me.nommed.Location = New System.Drawing.Point(198, 124)
        Me.nommed.Margin = New System.Windows.Forms.Padding(4, 5, 4, 5)
        Me.nommed.Name = "nommed"
        Me.nommed.Size = New System.Drawing.Size(211, 26)
        Me.nommed.TabIndex = 79
        '
        'cvemed
        '
        Me.cvemed.Enabled = False
        Me.cvemed.Location = New System.Drawing.Point(198, 80)
        Me.cvemed.Margin = New System.Windows.Forms.Padding(4, 5, 4, 5)
        Me.cvemed.Name = "cvemed"
        Me.cvemed.Size = New System.Drawing.Size(211, 26)
        Me.cvemed.TabIndex = 78
        '
        'Label4
        '
        Me.Label4.AutoSize = True
        Me.Label4.Location = New System.Drawing.Point(25, 127)
        Me.Label4.Margin = New System.Windows.Forms.Padding(4, 0, 4, 0)
        Me.Label4.Name = "Label4"
        Me.Label4.Size = New System.Drawing.Size(150, 20)
        Me.Label4.TabIndex = 77
        Me.Label4.Text = "NOMBRE DE MED:"
        '
        'btnre10
        '
        Me.btnre10.BackColor = System.Drawing.Color.Navy
        Me.btnre10.Font = New System.Drawing.Font("Microsoft Sans Serif", 14.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.btnre10.ForeColor = System.Drawing.SystemColors.ButtonFace
        Me.btnre10.Location = New System.Drawing.Point(223, 472)
        Me.btnre10.Margin = New System.Windows.Forms.Padding(4, 5, 4, 5)
        Me.btnre10.Name = "btnre10"
        Me.btnre10.Size = New System.Drawing.Size(186, 55)
        Me.btnre10.TabIndex = 76
        Me.btnre10.Text = "REGRESAR"
        Me.btnre10.UseVisualStyleBackColor = False
        '
        'aniadirm
        '
        Me.aniadirm.BackColor = System.Drawing.Color.CornflowerBlue
        Me.aniadirm.Font = New System.Drawing.Font("Microsoft Sans Serif", 14.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.aniadirm.Location = New System.Drawing.Point(29, 472)
        Me.aniadirm.Margin = New System.Windows.Forms.Padding(4, 5, 4, 5)
        Me.aniadirm.Name = "aniadirm"
        Me.aniadirm.Size = New System.Drawing.Size(186, 55)
        Me.aniadirm.TabIndex = 75
        Me.aniadirm.Text = "AÑADIR"
        Me.aniadirm.UseVisualStyleBackColor = False
        '
        'Label3
        '
        Me.Label3.AutoSize = True
        Me.Label3.Location = New System.Drawing.Point(25, 269)
        Me.Label3.Margin = New System.Windows.Forms.Padding(4, 0, 4, 0)
        Me.Label3.Name = "Label3"
        Me.Label3.Size = New System.Drawing.Size(95, 20)
        Me.Label3.TabIndex = 74
        Me.Label3.Text = "CANTIDAD:"
        '
        'Label2
        '
        Me.Label2.AutoSize = True
        Me.Label2.Location = New System.Drawing.Point(25, 83)
        Me.Label2.Margin = New System.Windows.Forms.Padding(4, 0, 4, 0)
        Me.Label2.Name = "Label2"
        Me.Label2.Size = New System.Drawing.Size(82, 20)
        Me.Label2.TabIndex = 73
        Me.Label2.Text = "CVEMED:"
        '
        'cantidadm
        '
        Me.cantidadm.Location = New System.Drawing.Point(198, 266)
        Me.cantidadm.Margin = New System.Windows.Forms.Padding(4, 5, 4, 5)
        Me.cantidadm.MaxLength = 5
        Me.cantidadm.Name = "cantidadm"
        Me.cantidadm.Size = New System.Drawing.Size(211, 26)
        Me.cantidadm.TabIndex = 91
        '
        'Panel1
        '
        Me.Panel1.BackColor = System.Drawing.Color.Navy
        Me.Panel1.BackgroundImageLayout = System.Windows.Forms.ImageLayout.None
        Me.Panel1.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.Panel1.Controls.Add(Me.Label1)
        Me.Panel1.Dock = System.Windows.Forms.DockStyle.Top
        Me.Panel1.Location = New System.Drawing.Point(0, 0)
        Me.Panel1.Name = "Panel1"
        Me.Panel1.Size = New System.Drawing.Size(441, 52)
        Me.Panel1.TabIndex = 92
        '
        'Label1
        '
        Me.Label1.AutoSize = True
        Me.Label1.Font = New System.Drawing.Font("Microsoft Sans Serif", 20.0!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label1.ForeColor = System.Drawing.SystemColors.ButtonFace
        Me.Label1.Location = New System.Drawing.Point(19, 1)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(404, 46)
        Me.Label1.TabIndex = 0
        Me.Label1.Text = "Añadir Medicamento"
        '
        'detcommed
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(9.0!, 20.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(441, 555)
        Me.Controls.Add(Me.Panel1)
        Me.Controls.Add(Me.cantidadm)
        Me.Controls.Add(Me.tipoMed)
        Me.Controls.Add(Me.Label9)
        Me.Controls.Add(Me.gananciaMed)
        Me.Controls.Add(Me.Label8)
        Me.Controls.Add(Me.lotemed)
        Me.Controls.Add(Me.Label7)
        Me.Controls.Add(Me.fechacadMed)
        Me.Controls.Add(Me.Label6)
        Me.Controls.Add(Me.precommed)
        Me.Controls.Add(Me.Label5)
        Me.Controls.Add(Me.nommed)
        Me.Controls.Add(Me.cvemed)
        Me.Controls.Add(Me.Label4)
        Me.Controls.Add(Me.btnre10)
        Me.Controls.Add(Me.aniadirm)
        Me.Controls.Add(Me.Label3)
        Me.Controls.Add(Me.Label2)
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.None
        Me.Margin = New System.Windows.Forms.Padding(4, 5, 4, 5)
        Me.Name = "detcommed"
        Me.Text = "detcommed"
        Me.Panel1.ResumeLayout(False)
        Me.Panel1.PerformLayout()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents tipoMed As ComboBox
    Friend WithEvents Label9 As Label
    Friend WithEvents gananciaMed As TextBox
    Friend WithEvents Label8 As Label
    Friend WithEvents lotemed As TextBox
    Friend WithEvents Label7 As Label
    Friend WithEvents fechacadMed As DateTimePicker
    Friend WithEvents Label6 As Label
    Friend WithEvents precommed As TextBox
    Friend WithEvents Label5 As Label
    Friend WithEvents nommed As TextBox
    Friend WithEvents cvemed As TextBox
    Friend WithEvents Label4 As Label
    Friend WithEvents btnre10 As Button
    Friend WithEvents aniadirm As Button
    Friend WithEvents Label3 As Label
    Friend WithEvents Label2 As Label
    Friend WithEvents cantidadm As TextBox
    Friend WithEvents Panel1 As Panel
    Friend WithEvents Label1 As Label
End Class
