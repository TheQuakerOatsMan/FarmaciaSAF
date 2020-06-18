<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class ProxCad
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
        Me.GRIDMED = New System.Windows.Forms.DataGridView()
        Me.salircapt = New System.Windows.Forms.Button()
        Me.Panel1 = New System.Windows.Forms.Panel()
        Me.Label9 = New System.Windows.Forms.Label()
        Me.Label1 = New System.Windows.Forms.Label()
        Me.Label2 = New System.Windows.Forms.Label()
        Me.GRIDPROD = New System.Windows.Forms.DataGridView()
        CType(Me.GRIDMED, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.Panel1.SuspendLayout()
        CType(Me.GRIDPROD, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'GRIDMED
        '
        Me.GRIDMED.AutoSizeColumnsMode = System.Windows.Forms.DataGridViewAutoSizeColumnsMode.Fill
        Me.GRIDMED.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize
        Me.GRIDMED.Location = New System.Drawing.Point(8, 57)
        Me.GRIDMED.Margin = New System.Windows.Forms.Padding(2, 2, 2, 2)
        Me.GRIDMED.Name = "GRIDMED"
        Me.GRIDMED.RowHeadersWidth = 62
        Me.GRIDMED.RowTemplate.Height = 28
        Me.GRIDMED.Size = New System.Drawing.Size(784, 144)
        Me.GRIDMED.TabIndex = 0
        '
        'salircapt
        '
        Me.salircapt.BackColor = System.Drawing.Color.Navy
        Me.salircapt.Font = New System.Drawing.Font("Microsoft Sans Serif", 14.25!)
        Me.salircapt.ForeColor = System.Drawing.Color.White
        Me.salircapt.Location = New System.Drawing.Point(693, 389)
        Me.salircapt.Name = "salircapt"
        Me.salircapt.Size = New System.Drawing.Size(98, 38)
        Me.salircapt.TabIndex = 4
        Me.salircapt.Text = "SALIR"
        Me.salircapt.UseVisualStyleBackColor = False
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
        Me.Panel1.Size = New System.Drawing.Size(800, 35)
        Me.Panel1.TabIndex = 83
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
        'Label1
        '
        Me.Label1.AutoSize = True
        Me.Label1.Location = New System.Drawing.Point(7, 42)
        Me.Label1.Margin = New System.Windows.Forms.Padding(2, 0, 2, 0)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(222, 13)
        Me.Label1.TabIndex = 84
        Me.Label1.Text = "MEDICAMENTOS PRÓXIMOS A CADUCAR:"
        '
        'Label2
        '
        Me.Label2.AutoSize = True
        Me.Label2.Location = New System.Drawing.Point(7, 210)
        Me.Label2.Margin = New System.Windows.Forms.Padding(2, 0, 2, 0)
        Me.Label2.Name = "Label2"
        Me.Label2.Size = New System.Drawing.Size(203, 13)
        Me.Label2.TabIndex = 86
        Me.Label2.Text = "PRODUCTOS PRÓXIMOS A CADUCAR:"
        '
        'GRIDPROD
        '
        Me.GRIDPROD.AutoSizeColumnsMode = System.Windows.Forms.DataGridViewAutoSizeColumnsMode.Fill
        Me.GRIDPROD.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize
        Me.GRIDPROD.Location = New System.Drawing.Point(7, 225)
        Me.GRIDPROD.Margin = New System.Windows.Forms.Padding(2, 2, 2, 2)
        Me.GRIDPROD.Name = "GRIDPROD"
        Me.GRIDPROD.RowHeadersWidth = 62
        Me.GRIDPROD.RowTemplate.Height = 28
        Me.GRIDPROD.Size = New System.Drawing.Size(784, 144)
        Me.GRIDPROD.TabIndex = 85
        '
        'ProxCad
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.BackgroundImage = Global.FarmaciaSanAntonio.My.Resources.Resources.farmaantonio3
        Me.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Stretch
        Me.ClientSize = New System.Drawing.Size(800, 434)
        Me.Controls.Add(Me.Label2)
        Me.Controls.Add(Me.GRIDPROD)
        Me.Controls.Add(Me.Label1)
        Me.Controls.Add(Me.Panel1)
        Me.Controls.Add(Me.salircapt)
        Me.Controls.Add(Me.GRIDMED)
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.None
        Me.Margin = New System.Windows.Forms.Padding(2, 2, 2, 2)
        Me.Name = "ProxCad"
        Me.Text = "ProxCad"
        CType(Me.GRIDMED, System.ComponentModel.ISupportInitialize).EndInit()
        Me.Panel1.ResumeLayout(False)
        Me.Panel1.PerformLayout()
        CType(Me.GRIDPROD, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub

    Friend WithEvents GRIDMED As DataGridView
    Friend WithEvents salircapt As Button
    Friend WithEvents Panel1 As Panel
    Friend WithEvents Label9 As Label
    Friend WithEvents Label1 As Label
    Friend WithEvents Label2 As Label
    Friend WithEvents GRIDPROD As DataGridView
End Class
