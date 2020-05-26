<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class TodasCompras
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
        Me.DataGridView1 = New System.Windows.Forms.DataGridView()
        Me.COMPRASBindingSource1 = New System.Windows.Forms.BindingSource(Me.components)
        Me.FarmSAntonioComprasDataSet = New FarmaciaSanAntonio.FarmSAntonioComprasDataSet()
        Me.salircomt = New System.Windows.Forms.Button()
        Me.COMPRASBindingSource = New System.Windows.Forms.BindingSource(Me.components)
        Me.FarmSAntonioDataSet11 = New FarmaciaSanAntonio.FarmSAntonioDataSet11()
        Me.COMPRASTableAdapter = New FarmaciaSanAntonio.FarmSAntonioDataSet11TableAdapters.COMPRASTableAdapter()
        Me.COMPRASTableAdapter1 = New FarmaciaSanAntonio.FarmSAntonioComprasDataSetTableAdapters.COMPRASTableAdapter()
        Me.Label9 = New System.Windows.Forms.Label()
        Me.Panel1 = New System.Windows.Forms.Panel()
        CType(Me.DataGridView1, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.COMPRASBindingSource1, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.FarmSAntonioComprasDataSet, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.COMPRASBindingSource, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.FarmSAntonioDataSet11, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.Panel1.SuspendLayout()
        Me.SuspendLayout()
        '
        'DataGridView1
        '
        Me.DataGridView1.AutoSizeColumnsMode = System.Windows.Forms.DataGridViewAutoSizeColumnsMode.Fill
        Me.DataGridView1.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize
        Me.DataGridView1.Location = New System.Drawing.Point(12, 56)
        Me.DataGridView1.Name = "DataGridView1"
        Me.DataGridView1.RowHeadersWidth = 62
        Me.DataGridView1.RowTemplate.Height = 28
        Me.DataGridView1.Size = New System.Drawing.Size(1176, 534)
        Me.DataGridView1.TabIndex = 0
        '
        'COMPRASBindingSource1
        '
        Me.COMPRASBindingSource1.DataMember = "COMPRAS"
        Me.COMPRASBindingSource1.DataSource = Me.FarmSAntonioComprasDataSet
        '
        'FarmSAntonioComprasDataSet
        '
        Me.FarmSAntonioComprasDataSet.DataSetName = "FarmSAntonioComprasDataSet"
        Me.FarmSAntonioComprasDataSet.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema
        '
        'salircomt
        '
        Me.salircomt.BackColor = System.Drawing.Color.Navy
        Me.salircomt.Font = New System.Drawing.Font("Microsoft Sans Serif", 14.25!)
        Me.salircomt.ForeColor = System.Drawing.Color.White
        Me.salircomt.Location = New System.Drawing.Point(1040, 598)
        Me.salircomt.Margin = New System.Windows.Forms.Padding(4, 5, 4, 5)
        Me.salircomt.Name = "salircomt"
        Me.salircomt.Size = New System.Drawing.Size(147, 58)
        Me.salircomt.TabIndex = 3
        Me.salircomt.Text = "SALIR"
        Me.salircomt.UseVisualStyleBackColor = False
        '
        'COMPRASBindingSource
        '
        Me.COMPRASBindingSource.DataMember = "COMPRAS"
        Me.COMPRASBindingSource.DataSource = Me.FarmSAntonioDataSet11
        '
        'FarmSAntonioDataSet11
        '
        Me.FarmSAntonioDataSet11.DataSetName = "FarmSAntonioDataSet11"
        Me.FarmSAntonioDataSet11.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema
        '
        'COMPRASTableAdapter
        '
        Me.COMPRASTableAdapter.ClearBeforeFill = True
        '
        'COMPRASTableAdapter1
        '
        Me.COMPRASTableAdapter1.ClearBeforeFill = True
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
        Me.Panel1.TabIndex = 82
        '
        'TodasCompras
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(9.0!, 20.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(1200, 667)
        Me.Controls.Add(Me.Panel1)
        Me.Controls.Add(Me.salircomt)
        Me.Controls.Add(Me.DataGridView1)
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.None
        Me.Name = "TodasCompras"
        Me.Text = "TodasCompras"
        CType(Me.DataGridView1, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.COMPRASBindingSource1, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.FarmSAntonioComprasDataSet, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.COMPRASBindingSource, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.FarmSAntonioDataSet11, System.ComponentModel.ISupportInitialize).EndInit()
        Me.Panel1.ResumeLayout(False)
        Me.Panel1.PerformLayout()
        Me.ResumeLayout(False)

    End Sub

    Friend WithEvents DataGridView1 As DataGridView
    Friend WithEvents FarmSAntonioDataSet11 As FarmSAntonioDataSet11
    Friend WithEvents COMPRASBindingSource As BindingSource
    Friend WithEvents COMPRASTableAdapter As FarmSAntonioDataSet11TableAdapters.COMPRASTableAdapter
    Friend WithEvents salircomt As Button
    Friend WithEvents FarmSAntonioComprasDataSet As FarmSAntonioComprasDataSet
    Friend WithEvents COMPRASBindingSource1 As BindingSource
    Friend WithEvents COMPRASTableAdapter1 As FarmSAntonioComprasDataSetTableAdapters.COMPRASTableAdapter
    Friend WithEvents Label9 As Label
    Friend WithEvents Panel1 As Panel
End Class
