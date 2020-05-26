<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class inicio
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
        Me.salir = New System.Windows.Forms.Button()
        Me.ini = New System.Windows.Forms.Button()
        Me.Panel1 = New System.Windows.Forms.Panel()
        Me.Label9 = New System.Windows.Forms.Label()
        Me.Panel1.SuspendLayout()
        Me.SuspendLayout()
        '
        'salir
        '
        Me.salir.BackColor = System.Drawing.Color.Navy
        Me.salir.Font = New System.Drawing.Font("Microsoft Sans Serif", 14.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.salir.ForeColor = System.Drawing.SystemColors.ButtonFace
        Me.salir.Location = New System.Drawing.Point(433, 355)
        Me.salir.Name = "salir"
        Me.salir.Size = New System.Drawing.Size(218, 55)
        Me.salir.TabIndex = 83
        Me.salir.Text = "SALIR"
        Me.salir.UseVisualStyleBackColor = False
        '
        'ini
        '
        Me.ini.BackColor = System.Drawing.Color.CornflowerBlue
        Me.ini.Font = New System.Drawing.Font("Microsoft Sans Serif", 14.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ini.ForeColor = System.Drawing.Color.Black
        Me.ini.Location = New System.Drawing.Point(209, 355)
        Me.ini.Name = "ini"
        Me.ini.Size = New System.Drawing.Size(218, 55)
        Me.ini.TabIndex = 82
        Me.ini.Text = "INICIO"
        Me.ini.UseVisualStyleBackColor = False
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
        Me.Panel1.Size = New System.Drawing.Size(862, 63)
        Me.Panel1.TabIndex = 85
        '
        'Label9
        '
        Me.Label9.AutoSize = True
        Me.Label9.Font = New System.Drawing.Font("Market Deco", 22.0!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label9.ForeColor = System.Drawing.SystemColors.ButtonFace
        Me.Label9.Location = New System.Drawing.Point(230, 7)
        Me.Label9.Name = "Label9"
        Me.Label9.Size = New System.Drawing.Size(537, 48)
        Me.Label9.TabIndex = 0
        Me.Label9.Text = "Farmacia San Antonio"
        Me.Label9.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
        '
        'inicio
        '
        Me.BackgroundImage = Global.FarmaciaSanAntonio.My.Resources.Resources.far
        Me.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Stretch
        Me.ClientSize = New System.Drawing.Size(862, 422)
        Me.Controls.Add(Me.Panel1)
        Me.Controls.Add(Me.salir)
        Me.Controls.Add(Me.ini)
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.None
        Me.Name = "inicio"
        Me.Panel1.ResumeLayout(False)
        Me.Panel1.PerformLayout()
        Me.ResumeLayout(False)

    End Sub
    Friend WithEvents binicio As Button
    Friend WithEvents bsalir As Button
    Friend WithEvents salir As Button
    Friend WithEvents ini As Button
    Friend WithEvents Panel1 As Panel
    Friend WithEvents Label9 As Label
End Class
