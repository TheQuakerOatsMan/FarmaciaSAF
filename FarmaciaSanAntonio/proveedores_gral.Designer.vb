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
        Me.PROVEEDORESBindingSource2 = New System.Windows.Forms.BindingSource(Me.components)
        Me.FarmSAntonioDataSet = New FarmaciaSanAntonio.FarmSAntonioDataSet()
        Me.salirprovt = New System.Windows.Forms.Button()
        Me.PROVEEDORESBindingSource1 = New System.Windows.Forms.BindingSource(Me.components)
        Me.FarmSAntonioDataSet6 = New FarmaciaSanAntonio.FarmSAntonioDataSet6()
        Me.PROVEEDORESTableAdapter2 = New FarmaciaSanAntonio.FarmSAntonioDataSet6TableAdapters.PROVEEDORESTableAdapter()
        Me.PROVEEDORESBindingSource = New System.Windows.Forms.BindingSource(Me.components)
        Me.FarmSAntonioDataSet1 = New FarmaciaSanAntonio.FarmSAntonioDataSet1()
        Me.PROVEEDORESTableAdapter1 = New FarmaciaSanAntonio.FarmSAntonioDataSet1TableAdapters.PROVEEDORESTableAdapter()
        Me.PROVEEDORESTableAdapter = New FarmaciaSanAntonio.FarmSAntonioDataSetTableAdapters.PROVEEDORESTableAdapter()
        Me.Label9 = New System.Windows.Forms.Label()
        Me.Panel1 = New System.Windows.Forms.Panel()
        CType(Me.DataGridView11, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.PROVEEDORESBindingSource2, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.FarmSAntonioDataSet, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.PROVEEDORESBindingSource1, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.FarmSAntonioDataSet6, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.PROVEEDORESBindingSource, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.FarmSAntonioDataSet1, System.ComponentModel.ISupportInitialize).BeginInit()
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
        Me.PROVEEDORESBindingSource2.DataMember = "PROVEEDORES"
        Me.PROVEEDORESBindingSource2.DataSource = Me.FarmSAntonioDataSet
        '
        'FarmSAntonioDataSet
        '
        Me.FarmSAntonioDataSet.DataSetName = "FarmSAntonioDataSet"
        Me.FarmSAntonioDataSet.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema
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
        Me.PROVEEDORESBindingSource1.DataMember = "PROVEEDORES"
        Me.PROVEEDORESBindingSource1.DataSource = Me.FarmSAntonioDataSet6
        '
        'FarmSAntonioDataSet6
        '
        Me.FarmSAntonioDataSet6.DataSetName = "FarmSAntonioDataSet6"
        Me.FarmSAntonioDataSet6.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema
        '
        'PROVEEDORESTableAdapter2
        '
        Me.PROVEEDORESTableAdapter2.ClearBeforeFill = True
        '
        'PROVEEDORESBindingSource
        '
        Me.PROVEEDORESBindingSource.DataMember = "PROVEEDORES"
        Me.PROVEEDORESBindingSource.DataSource = Me.FarmSAntonioDataSet1
        '
        'FarmSAntonioDataSet1
        '
        Me.FarmSAntonioDataSet1.DataSetName = "FarmSAntonioDataSet1"
        Me.FarmSAntonioDataSet1.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema
        '
        'PROVEEDORESTableAdapter1
        '
        Me.PROVEEDORESTableAdapter1.ClearBeforeFill = True
        '
        'PROVEEDORESTableAdapter
        '
        Me.PROVEEDORESTableAdapter.ClearBeforeFill = True
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
        CType(Me.PROVEEDORESBindingSource2, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.FarmSAntonioDataSet, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.PROVEEDORESBindingSource1, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.FarmSAntonioDataSet6, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.PROVEEDORESBindingSource, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.FarmSAntonioDataSet1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.Panel1.ResumeLayout(False)
        Me.Panel1.PerformLayout()
        Me.ResumeLayout(False)

    End Sub

    Friend WithEvents DataGridView11 As DataGridView
    Friend WithEvents PROVEEDORESBindingSource As BindingSource
    Friend WithEvents salirprovt As Button
    Friend WithEvents FarmSAntonioDataSet1 As FarmSAntonioDataSet1
    Friend WithEvents PROVEEDORESTableAdapter1 As FarmSAntonioDataSet1TableAdapters.PROVEEDORESTableAdapter
    Friend WithEvents ACTIVO As DataGridViewTextBoxColumn
    Friend WithEvents FarmSAntonioDataSet6 As FarmSAntonioDataSet6
    Friend WithEvents PROVEEDORESBindingSource1 As BindingSource
    Friend WithEvents PROVEEDORESTableAdapter2 As FarmSAntonioDataSet6TableAdapters.PROVEEDORESTableAdapter
    Friend WithEvents FarmSAntonioDataSet As FarmSAntonioDataSet
    Friend WithEvents PROVEEDORESBindingSource2 As BindingSource
    Friend WithEvents PROVEEDORESTableAdapter As FarmSAntonioDataSetTableAdapters.PROVEEDORESTableAdapter
    Friend WithEvents Label9 As Label
    Friend WithEvents Panel1 As Panel
End Class
