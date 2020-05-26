<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class confirmEmpComp
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
        Me.procombox = New System.Windows.Forms.ComboBox()
        Me.btnIng = New System.Windows.Forms.Button()
        Me.Label2 = New System.Windows.Forms.Label()
        Me.btnCancelar = New System.Windows.Forms.Button()
        Me.Panel1 = New System.Windows.Forms.Panel()
        Me.Label9 = New System.Windows.Forms.Label()
        Me.Panel1.SuspendLayout()
        Me.SuspendLayout()
        '
        'procombox
        '
        Me.procombox.FormattingEnabled = True
        Me.procombox.Location = New System.Drawing.Point(137, 91)
        Me.procombox.Name = "procombox"
        Me.procombox.Size = New System.Drawing.Size(186, 28)
        Me.procombox.TabIndex = 13
        '
        'btnIng
        '
        Me.btnIng.BackColor = System.Drawing.Color.Navy
        Me.btnIng.ForeColor = System.Drawing.SystemColors.ButtonFace
        Me.btnIng.Location = New System.Drawing.Point(43, 154)
        Me.btnIng.Margin = New System.Windows.Forms.Padding(4, 5, 4, 5)
        Me.btnIng.Name = "btnIng"
        Me.btnIng.Size = New System.Drawing.Size(130, 42)
        Me.btnIng.TabIndex = 8
        Me.btnIng.Text = "INGRESAR"
        Me.btnIng.UseVisualStyleBackColor = False
        '
        'Label2
        '
        Me.Label2.AutoSize = True
        Me.Label2.Location = New System.Drawing.Point(39, 94)
        Me.Label2.Margin = New System.Windows.Forms.Padding(4, 0, 4, 0)
        Me.Label2.Name = "Label2"
        Me.Label2.Size = New System.Drawing.Size(91, 20)
        Me.Label2.TabIndex = 12
        Me.Label2.Text = "CVEPROV:"
        '
        'btnCancelar
        '
        Me.btnCancelar.BackColor = System.Drawing.Color.CornflowerBlue
        Me.btnCancelar.Location = New System.Drawing.Point(188, 154)
        Me.btnCancelar.Margin = New System.Windows.Forms.Padding(4, 5, 4, 5)
        Me.btnCancelar.Name = "btnCancelar"
        Me.btnCancelar.Size = New System.Drawing.Size(135, 42)
        Me.btnCancelar.TabIndex = 9
        Me.btnCancelar.Text = "CANCELAR"
        Me.btnCancelar.UseVisualStyleBackColor = False
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
        Me.Panel1.Size = New System.Drawing.Size(363, 52)
        Me.Panel1.TabIndex = 81
        '
        'Label9
        '
        Me.Label9.AutoSize = True
        Me.Label9.Font = New System.Drawing.Font("Microsoft Sans Serif", 20.0!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label9.ForeColor = System.Drawing.SystemColors.ButtonFace
        Me.Label9.Location = New System.Drawing.Point(46, 0)
        Me.Label9.Name = "Label9"
        Me.Label9.Size = New System.Drawing.Size(269, 46)
        Me.Label9.TabIndex = 0
        Me.Label9.Text = "Confirmación"
        '
        'confirmEmpComp
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(9.0!, 20.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(363, 244)
        Me.Controls.Add(Me.Panel1)
        Me.Controls.Add(Me.procombox)
        Me.Controls.Add(Me.Label2)
        Me.Controls.Add(Me.btnCancelar)
        Me.Controls.Add(Me.btnIng)
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.None
        Me.Name = "confirmEmpComp"
        Me.Text = "confirmEmpComp"
        Me.Panel1.ResumeLayout(False)
        Me.Panel1.PerformLayout()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents procombox As ComboBox
    Friend WithEvents btnIng As Button
    Friend WithEvents Label2 As Label
    Friend WithEvents btnCancelar As Button
    Friend WithEvents Panel1 As Panel
    Friend WithEvents Label9 As Label
End Class
