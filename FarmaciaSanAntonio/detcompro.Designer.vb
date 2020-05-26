<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class detcompro
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
        Me.gananciaProd = New System.Windows.Forms.TextBox()
        Me.Label8 = New System.Windows.Forms.Label()
        Me.loteprod = New System.Windows.Forms.TextBox()
        Me.Label7 = New System.Windows.Forms.Label()
        Me.fechacadProd = New System.Windows.Forms.DateTimePicker()
        Me.Label6 = New System.Windows.Forms.Label()
        Me.precomprod = New System.Windows.Forms.TextBox()
        Me.Label5 = New System.Windows.Forms.Label()
        Me.nomprod = New System.Windows.Forms.TextBox()
        Me.cveprod = New System.Windows.Forms.TextBox()
        Me.Label4 = New System.Windows.Forms.Label()
        Me.btnre10 = New System.Windows.Forms.Button()
        Me.aniadirm = New System.Windows.Forms.Button()
        Me.Label3 = New System.Windows.Forms.Label()
        Me.Label2 = New System.Windows.Forms.Label()
        Me.cantP = New System.Windows.Forms.TextBox()
        Me.Panel1 = New System.Windows.Forms.Panel()
        Me.Label9 = New System.Windows.Forms.Label()
        Me.Panel1.SuspendLayout()
        Me.SuspendLayout()
        '
        'gananciaProd
        '
        Me.gananciaProd.Location = New System.Drawing.Point(200, 233)
        Me.gananciaProd.Margin = New System.Windows.Forms.Padding(4, 5, 4, 5)
        Me.gananciaProd.MaxLength = 3
        Me.gananciaProd.Name = "gananciaProd"
        Me.gananciaProd.Size = New System.Drawing.Size(211, 26)
        Me.gananciaProd.TabIndex = 69
        '
        'Label8
        '
        Me.Label8.AutoSize = True
        Me.Label8.Location = New System.Drawing.Point(25, 236)
        Me.Label8.Margin = New System.Windows.Forms.Padding(4, 0, 4, 0)
        Me.Label8.Name = "Label8"
        Me.Label8.Size = New System.Drawing.Size(97, 20)
        Me.Label8.TabIndex = 68
        Me.Label8.Text = "GANANCIA:"
        '
        'loteprod
        '
        Me.loteprod.Location = New System.Drawing.Point(200, 336)
        Me.loteprod.Margin = New System.Windows.Forms.Padding(4, 5, 4, 5)
        Me.loteprod.Name = "loteprod"
        Me.loteprod.Size = New System.Drawing.Size(211, 26)
        Me.loteprod.TabIndex = 67
        '
        'Label7
        '
        Me.Label7.AutoSize = True
        Me.Label7.Location = New System.Drawing.Point(25, 339)
        Me.Label7.Margin = New System.Windows.Forms.Padding(4, 0, 4, 0)
        Me.Label7.Name = "Label7"
        Me.Label7.Size = New System.Drawing.Size(54, 20)
        Me.Label7.TabIndex = 66
        Me.Label7.Text = "LOTE:"
        '
        'fechacadProd
        '
        Me.fechacadProd.Location = New System.Drawing.Point(200, 389)
        Me.fechacadProd.Name = "fechacadProd"
        Me.fechacadProd.Size = New System.Drawing.Size(211, 26)
        Me.fechacadProd.TabIndex = 65
        '
        'Label6
        '
        Me.Label6.AutoSize = True
        Me.Label6.Location = New System.Drawing.Point(25, 394)
        Me.Label6.Margin = New System.Windows.Forms.Padding(4, 0, 4, 0)
        Me.Label6.Name = "Label6"
        Me.Label6.Size = New System.Drawing.Size(102, 20)
        Me.Label6.TabIndex = 64
        Me.Label6.Text = "FECHACAD:"
        '
        'precomprod
        '
        Me.precomprod.Location = New System.Drawing.Point(200, 182)
        Me.precomprod.Margin = New System.Windows.Forms.Padding(4, 5, 4, 5)
        Me.precomprod.MaxLength = 10
        Me.precomprod.Name = "precomprod"
        Me.precomprod.Size = New System.Drawing.Size(211, 26)
        Me.precomprod.TabIndex = 63
        '
        'Label5
        '
        Me.Label5.AutoSize = True
        Me.Label5.Location = New System.Drawing.Point(25, 185)
        Me.Label5.Margin = New System.Windows.Forms.Padding(4, 0, 4, 0)
        Me.Label5.Name = "Label5"
        Me.Label5.Size = New System.Drawing.Size(174, 20)
        Me.Label5.TabIndex = 62
        Me.Label5.Text = "PRECIO DE COMPRA:"
        '
        'nomprod
        '
        Me.nomprod.Enabled = False
        Me.nomprod.Location = New System.Drawing.Point(200, 131)
        Me.nomprod.Margin = New System.Windows.Forms.Padding(4, 5, 4, 5)
        Me.nomprod.Name = "nomprod"
        Me.nomprod.Size = New System.Drawing.Size(211, 26)
        Me.nomprod.TabIndex = 61
        '
        'cveprod
        '
        Me.cveprod.Enabled = False
        Me.cveprod.Location = New System.Drawing.Point(200, 79)
        Me.cveprod.Margin = New System.Windows.Forms.Padding(4, 5, 4, 5)
        Me.cveprod.Name = "cveprod"
        Me.cveprod.Size = New System.Drawing.Size(211, 26)
        Me.cveprod.TabIndex = 60
        '
        'Label4
        '
        Me.Label4.AutoSize = True
        Me.Label4.Location = New System.Drawing.Point(25, 134)
        Me.Label4.Margin = New System.Windows.Forms.Padding(4, 0, 4, 0)
        Me.Label4.Name = "Label4"
        Me.Label4.Size = New System.Drawing.Size(160, 20)
        Me.Label4.TabIndex = 59
        Me.Label4.Text = "NOMBRE DE PROD:"
        '
        'btnre10
        '
        Me.btnre10.BackColor = System.Drawing.Color.Navy
        Me.btnre10.Font = New System.Drawing.Font("Microsoft Sans Serif", 14.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.btnre10.ForeColor = System.Drawing.SystemColors.ButtonFace
        Me.btnre10.Location = New System.Drawing.Point(225, 466)
        Me.btnre10.Margin = New System.Windows.Forms.Padding(4, 5, 4, 5)
        Me.btnre10.Name = "btnre10"
        Me.btnre10.Size = New System.Drawing.Size(186, 55)
        Me.btnre10.TabIndex = 58
        Me.btnre10.Text = "REGRESAR"
        Me.btnre10.UseVisualStyleBackColor = False
        '
        'aniadirm
        '
        Me.aniadirm.BackColor = System.Drawing.Color.CornflowerBlue
        Me.aniadirm.Font = New System.Drawing.Font("Microsoft Sans Serif", 14.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.aniadirm.Location = New System.Drawing.Point(29, 466)
        Me.aniadirm.Margin = New System.Windows.Forms.Padding(4, 5, 4, 5)
        Me.aniadirm.Name = "aniadirm"
        Me.aniadirm.Size = New System.Drawing.Size(186, 55)
        Me.aniadirm.TabIndex = 57
        Me.aniadirm.Text = "AÑADIR"
        Me.aniadirm.UseVisualStyleBackColor = False
        '
        'Label3
        '
        Me.Label3.AutoSize = True
        Me.Label3.Location = New System.Drawing.Point(25, 288)
        Me.Label3.Margin = New System.Windows.Forms.Padding(4, 0, 4, 0)
        Me.Label3.Name = "Label3"
        Me.Label3.Size = New System.Drawing.Size(95, 20)
        Me.Label3.TabIndex = 56
        Me.Label3.Text = "CANTIDAD:"
        '
        'Label2
        '
        Me.Label2.AutoSize = True
        Me.Label2.Location = New System.Drawing.Point(25, 82)
        Me.Label2.Margin = New System.Windows.Forms.Padding(4, 0, 4, 0)
        Me.Label2.Name = "Label2"
        Me.Label2.Size = New System.Drawing.Size(92, 20)
        Me.Label2.TabIndex = 55
        Me.Label2.Text = "CVEPROD:"
        '
        'cantP
        '
        Me.cantP.Location = New System.Drawing.Point(200, 285)
        Me.cantP.Margin = New System.Windows.Forms.Padding(4, 5, 4, 5)
        Me.cantP.MaxLength = 5
        Me.cantP.Name = "cantP"
        Me.cantP.Size = New System.Drawing.Size(211, 26)
        Me.cantP.TabIndex = 70
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
        Me.Panel1.Size = New System.Drawing.Size(440, 52)
        Me.Panel1.TabIndex = 86
        '
        'Label9
        '
        Me.Label9.AutoSize = True
        Me.Label9.Font = New System.Drawing.Font("Microsoft Sans Serif", 20.0!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label9.ForeColor = System.Drawing.SystemColors.ButtonFace
        Me.Label9.Location = New System.Drawing.Point(60, 1)
        Me.Label9.Name = "Label9"
        Me.Label9.Size = New System.Drawing.Size(323, 46)
        Me.Label9.TabIndex = 0
        Me.Label9.Text = "Añadir Producto"
        '
        'detcompro
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(9.0!, 20.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(440, 554)
        Me.Controls.Add(Me.Panel1)
        Me.Controls.Add(Me.cantP)
        Me.Controls.Add(Me.gananciaProd)
        Me.Controls.Add(Me.Label8)
        Me.Controls.Add(Me.loteprod)
        Me.Controls.Add(Me.Label7)
        Me.Controls.Add(Me.fechacadProd)
        Me.Controls.Add(Me.Label6)
        Me.Controls.Add(Me.precomprod)
        Me.Controls.Add(Me.Label5)
        Me.Controls.Add(Me.nomprod)
        Me.Controls.Add(Me.cveprod)
        Me.Controls.Add(Me.Label4)
        Me.Controls.Add(Me.btnre10)
        Me.Controls.Add(Me.aniadirm)
        Me.Controls.Add(Me.Label3)
        Me.Controls.Add(Me.Label2)
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.None
        Me.Margin = New System.Windows.Forms.Padding(4, 5, 4, 5)
        Me.Name = "detcompro"
        Me.Text = "detcompro"
        Me.Panel1.ResumeLayout(False)
        Me.Panel1.PerformLayout()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents gananciaProd As TextBox
    Friend WithEvents Label8 As Label
    Friend WithEvents loteprod As TextBox
    Friend WithEvents Label7 As Label
    Friend WithEvents fechacadProd As DateTimePicker
    Friend WithEvents Label6 As Label
    Friend WithEvents precomprod As TextBox
    Friend WithEvents Label5 As Label
    Friend WithEvents nomprod As TextBox
    Friend WithEvents cveprod As TextBox
    Friend WithEvents Label4 As Label
    Friend WithEvents btnre10 As Button
    Friend WithEvents aniadirm As Button
    Friend WithEvents Label3 As Label
    Friend WithEvents Label2 As Label
    Friend WithEvents cantP As TextBox
    Friend WithEvents Panel1 As Panel
    Friend WithEvents Label9 As Label
End Class
