<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class MODIMGRECT
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
        Me.btnre1 = New System.Windows.Forms.Button()
        Me.btnchange = New System.Windows.Forms.Button()
        Me.Label1 = New System.Windows.Forms.Label()
        Me.Label2 = New System.Windows.Forms.Label()
        Me.Label3 = New System.Windows.Forms.Label()
        Me.txtcvemed = New System.Windows.Forms.TextBox()
        Me.txtcvevta = New System.Windows.Forms.TextBox()
        Me.txtimgrect = New System.Windows.Forms.TextBox()
        Me.change = New System.Windows.Forms.Button()
        Me.OpenFileDialog1 = New System.Windows.Forms.OpenFileDialog()
        Me.Panel1 = New System.Windows.Forms.Panel()
        Me.Label9 = New System.Windows.Forms.Label()
        Me.Panel1.SuspendLayout()
        Me.SuspendLayout()
        '
        'btnre1
        '
        Me.btnre1.BackColor = System.Drawing.Color.Navy
        Me.btnre1.ForeColor = System.Drawing.SystemColors.ButtonFace
        Me.btnre1.Location = New System.Drawing.Point(309, 129)
        Me.btnre1.Name = "btnre1"
        Me.btnre1.Size = New System.Drawing.Size(124, 31)
        Me.btnre1.TabIndex = 0
        Me.btnre1.Text = "REGRESAR"
        Me.btnre1.UseVisualStyleBackColor = False
        '
        'btnchange
        '
        Me.btnchange.BackColor = System.Drawing.Color.CornflowerBlue
        Me.btnchange.Location = New System.Drawing.Point(156, 129)
        Me.btnchange.Name = "btnchange"
        Me.btnchange.Size = New System.Drawing.Size(124, 31)
        Me.btnchange.TabIndex = 2
        Me.btnchange.Text = "MODIFICAR RECETA"
        Me.btnchange.UseVisualStyleBackColor = False
        '
        'Label1
        '
        Me.Label1.AutoSize = True
        Me.Label1.Location = New System.Drawing.Point(9, 87)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(56, 13)
        Me.Label1.TabIndex = 3
        Me.Label1.Text = "IMGRECT"
        '
        'Label2
        '
        Me.Label2.AutoSize = True
        Me.Label2.Location = New System.Drawing.Point(9, 42)
        Me.Label2.Name = "Label2"
        Me.Label2.Size = New System.Drawing.Size(55, 13)
        Me.Label2.TabIndex = 4
        Me.Label2.Text = "CVEMED:"
        '
        'Label3
        '
        Me.Label3.AutoSize = True
        Me.Label3.Location = New System.Drawing.Point(9, 64)
        Me.Label3.Name = "Label3"
        Me.Label3.Size = New System.Drawing.Size(52, 13)
        Me.Label3.TabIndex = 5
        Me.Label3.Text = "CVEVTA:"
        '
        'txtcvemed
        '
        Me.txtcvemed.Location = New System.Drawing.Point(87, 40)
        Me.txtcvemed.Name = "txtcvemed"
        Me.txtcvemed.Size = New System.Drawing.Size(83, 20)
        Me.txtcvemed.TabIndex = 7
        '
        'txtcvevta
        '
        Me.txtcvevta.Location = New System.Drawing.Point(87, 62)
        Me.txtcvevta.Name = "txtcvevta"
        Me.txtcvevta.Size = New System.Drawing.Size(83, 20)
        Me.txtcvevta.TabIndex = 8
        '
        'txtimgrect
        '
        Me.txtimgrect.Location = New System.Drawing.Point(87, 85)
        Me.txtimgrect.MaxLength = 100
        Me.txtimgrect.Name = "txtimgrect"
        Me.txtimgrect.Size = New System.Drawing.Size(396, 20)
        Me.txtimgrect.TabIndex = 9
        '
        'change
        '
        Me.change.BackColor = System.Drawing.Color.CornflowerBlue
        Me.change.Location = New System.Drawing.Point(487, 78)
        Me.change.Name = "change"
        Me.change.Size = New System.Drawing.Size(124, 31)
        Me.change.TabIndex = 10
        Me.change.Text = "CAMBIAR"
        Me.change.UseVisualStyleBackColor = False
        '
        'OpenFileDialog1
        '
        Me.OpenFileDialog1.FileName = "OpenFileDialog1"
        '
        'Panel1
        '
        Me.Panel1.BackColor = System.Drawing.Color.Navy
        Me.Panel1.BackgroundImageLayout = System.Windows.Forms.ImageLayout.None
        Me.Panel1.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.Panel1.Controls.Add(Me.Label9)
        Me.Panel1.Dock = System.Windows.Forms.DockStyle.Top
        Me.Panel1.Location = New System.Drawing.Point(0, 0)
        Me.Panel1.Margin = New System.Windows.Forms.Padding(2, 2, 2, 2)
        Me.Panel1.Name = "Panel1"
        Me.Panel1.Size = New System.Drawing.Size(623, 35)
        Me.Panel1.TabIndex = 84
        '
        'Label9
        '
        Me.Label9.AutoSize = True
        Me.Label9.Font = New System.Drawing.Font("Microsoft Sans Serif", 20.0!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label9.ForeColor = System.Drawing.SystemColors.ButtonFace
        Me.Label9.Location = New System.Drawing.Point(3, 1)
        Me.Label9.Margin = New System.Windows.Forms.Padding(2, 0, 2, 0)
        Me.Label9.Name = "Label9"
        Me.Label9.Size = New System.Drawing.Size(301, 31)
        Me.Label9.TabIndex = 0
        Me.Label9.Text = "Farmacia San Antonio"
        '
        'MODIMGRECT
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Zoom
        Me.ClientSize = New System.Drawing.Size(623, 194)
        Me.Controls.Add(Me.Panel1)
        Me.Controls.Add(Me.change)
        Me.Controls.Add(Me.txtimgrect)
        Me.Controls.Add(Me.txtcvevta)
        Me.Controls.Add(Me.txtcvemed)
        Me.Controls.Add(Me.Label3)
        Me.Controls.Add(Me.Label2)
        Me.Controls.Add(Me.Label1)
        Me.Controls.Add(Me.btnchange)
        Me.Controls.Add(Me.btnre1)
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.None
        Me.Name = "MODIMGRECT"
        Me.Text = "MODIMGRECT"
        Me.Panel1.ResumeLayout(False)
        Me.Panel1.PerformLayout()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub

    Friend WithEvents btnre1 As Button
    Friend WithEvents btnchange As Button
    Friend WithEvents Label1 As Label
    Friend WithEvents Label2 As Label
    Friend WithEvents Label3 As Label
    Friend WithEvents txtcvemed As TextBox
    Friend WithEvents txtcvevta As TextBox
    Friend WithEvents txtimgrect As TextBox
    Friend WithEvents change As Button
    Friend WithEvents OpenFileDialog1 As OpenFileDialog
    Friend WithEvents Panel1 As Panel
    Friend WithEvents Label9 As Label
End Class
