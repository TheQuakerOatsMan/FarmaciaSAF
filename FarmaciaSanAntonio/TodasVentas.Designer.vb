<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class TodasVentas
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
        Me.VENTASBindingSource1 = New System.Windows.Forms.BindingSource(Me.components)
        Me.FarmSAntonioVentasDataSet = New FarmaciaSanAntonio.FarmSAntonioVentasDataSet()
        Me.VENTASBindingSource = New System.Windows.Forms.BindingSource(Me.components)
        Me.FarmSAntonioDataSet9 = New FarmaciaSanAntonio.FarmSAntonioDataSet9()
        Me.VENTASTableAdapter = New FarmaciaSanAntonio.FarmSAntonioDataSet9TableAdapters.VENTASTableAdapter()
        Me.salirvent = New System.Windows.Forms.Button()
        Me.VENTASTableAdapter1 = New FarmaciaSanAntonio.FarmSAntonioVentasDataSetTableAdapters.VENTASTableAdapter()
        Me.Panel1 = New System.Windows.Forms.Panel()
        Me.Label9 = New System.Windows.Forms.Label()
        CType(Me.DataGridView1, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.VENTASBindingSource1, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.FarmSAntonioVentasDataSet, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.VENTASBindingSource, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.FarmSAntonioDataSet9, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.Panel1.SuspendLayout()
        Me.SuspendLayout()
        '
        'DataGridView1
        '
        Me.DataGridView1.AutoSizeColumnsMode = System.Windows.Forms.DataGridViewAutoSizeColumnsMode.Fill
        Me.DataGridView1.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize
        Me.DataGridView1.Location = New System.Drawing.Point(12, 58)
        Me.DataGridView1.Name = "DataGridView1"
        Me.DataGridView1.RowHeadersWidth = 62
        Me.DataGridView1.RowTemplate.Height = 28
        Me.DataGridView1.Size = New System.Drawing.Size(1176, 534)
        Me.DataGridView1.TabIndex = 0
        '
        'VENTASBindingSource1
        '
        Me.VENTASBindingSource1.DataMember = "VENTAS"
        Me.VENTASBindingSource1.DataSource = Me.FarmSAntonioVentasDataSet
        '
        'FarmSAntonioVentasDataSet
        '
        Me.FarmSAntonioVentasDataSet.DataSetName = "FarmSAntonioVentasDataSet"
        Me.FarmSAntonioVentasDataSet.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema
        '
        'VENTASBindingSource
        '
        Me.VENTASBindingSource.DataMember = "VENTAS"
        Me.VENTASBindingSource.DataSource = Me.FarmSAntonioDataSet9
        '
        'FarmSAntonioDataSet9
        '
        Me.FarmSAntonioDataSet9.DataSetName = "FarmSAntonioDataSet9"
        Me.FarmSAntonioDataSet9.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema
        '
        'VENTASTableAdapter
        '
        Me.VENTASTableAdapter.ClearBeforeFill = True
        '
        'salirvent
        '
        Me.salirvent.BackColor = System.Drawing.Color.Navy
        Me.salirvent.Font = New System.Drawing.Font("Microsoft Sans Serif", 14.25!)
        Me.salirvent.ForeColor = System.Drawing.Color.White
        Me.salirvent.Location = New System.Drawing.Point(1041, 600)
        Me.salirvent.Margin = New System.Windows.Forms.Padding(4, 5, 4, 5)
        Me.salirvent.Name = "salirvent"
        Me.salirvent.Size = New System.Drawing.Size(147, 58)
        Me.salirvent.TabIndex = 3
        Me.salirvent.Text = "SALIR"
        Me.salirvent.UseVisualStyleBackColor = False
        '
        'VENTASTableAdapter1
        '
        Me.VENTASTableAdapter1.ClearBeforeFill = True
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
        Me.Panel1.TabIndex = 81
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
        'TodasVentas
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(9.0!, 20.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(1200, 667)
        Me.Controls.Add(Me.Panel1)
        Me.Controls.Add(Me.salirvent)
        Me.Controls.Add(Me.DataGridView1)
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.None
        Me.Name = "TodasVentas"
        Me.Text = "TodasVentas"
        CType(Me.DataGridView1, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.VENTASBindingSource1, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.FarmSAntonioVentasDataSet, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.VENTASBindingSource, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.FarmSAntonioDataSet9, System.ComponentModel.ISupportInitialize).EndInit()
        Me.Panel1.ResumeLayout(False)
        Me.Panel1.PerformLayout()
        Me.ResumeLayout(False)

    End Sub

    Friend WithEvents DataGridView1 As DataGridView
    Friend WithEvents FarmSAntonioDataSet9 As FarmSAntonioDataSet9
    Friend WithEvents VENTASBindingSource As BindingSource
    Friend WithEvents VENTASTableAdapter As FarmSAntonioDataSet9TableAdapters.VENTASTableAdapter
    Friend WithEvents salirvent As Button
    Friend WithEvents FarmSAntonioVentasDataSet As FarmSAntonioVentasDataSet
    Friend WithEvents VENTASBindingSource1 As BindingSource
    Friend WithEvents VENTASTableAdapter1 As FarmSAntonioVentasDataSetTableAdapters.VENTASTableAdapter
    Friend WithEvents Panel1 As Panel
    Friend WithEvents Label9 As Label
End Class
