<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class TodosMed
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
        Me.MEDICAMENTOSBindingSource2 = New System.Windows.Forms.BindingSource(Me.components)
        Me.DECOMPRASGERENCIA = New FarmaciaSanAntonio.DECOMPRASGERENCIA()
        Me.MEDICAMENTOSBindingSource = New System.Windows.Forms.BindingSource(Me.components)
        Me.FarmSAntonioDataSet10 = New FarmaciaSanAntonio.FarmSAntonioDataSet10()
        Me.MEDICAMENTOSTableAdapter = New FarmaciaSanAntonio.FarmSAntonioDataSet10TableAdapters.MEDICAMENTOSTableAdapter()
        Me.salirmedt = New System.Windows.Forms.Button()
        Me.DEVENTAS = New FarmaciaSanAntonio.DEVENTAS()
        Me.MEDICAMENTOSBindingSource1 = New System.Windows.Forms.BindingSource(Me.components)
        Me.MEDICAMENTOSTableAdapter1 = New FarmaciaSanAntonio.DEVENTASTableAdapters.MEDICAMENTOSTableAdapter()
        Me.MEDICAMENTOSTableAdapter2 = New FarmaciaSanAntonio.DECOMPRASGERENCIATableAdapters.MEDICAMENTOSTableAdapter()
        Me.Label9 = New System.Windows.Forms.Label()
        Me.Panel1 = New System.Windows.Forms.Panel()
        CType(Me.DataGridView1, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.MEDICAMENTOSBindingSource2, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.DECOMPRASGERENCIA, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.MEDICAMENTOSBindingSource, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.FarmSAntonioDataSet10, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.DEVENTAS, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.MEDICAMENTOSBindingSource1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.Panel1.SuspendLayout()
        Me.SuspendLayout()
        '
        'DataGridView1
        '
        Me.DataGridView1.AutoSizeColumnsMode = System.Windows.Forms.DataGridViewAutoSizeColumnsMode.Fill
        Me.DataGridView1.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize
        Me.DataGridView1.Location = New System.Drawing.Point(12, 60)
        Me.DataGridView1.Name = "DataGridView1"
        Me.DataGridView1.RowHeadersWidth = 62
        Me.DataGridView1.RowTemplate.Height = 28
        Me.DataGridView1.Size = New System.Drawing.Size(1176, 534)
        Me.DataGridView1.TabIndex = 0
        '
        'MEDICAMENTOSBindingSource2
        '
        Me.MEDICAMENTOSBindingSource2.DataMember = "MEDICAMENTOS"
        Me.MEDICAMENTOSBindingSource2.DataSource = Me.DECOMPRASGERENCIA
        '
        'DECOMPRASGERENCIA
        '
        Me.DECOMPRASGERENCIA.DataSetName = "DECOMPRASGERENCIA"
        Me.DECOMPRASGERENCIA.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema
        '
        'MEDICAMENTOSBindingSource
        '
        Me.MEDICAMENTOSBindingSource.DataMember = "MEDICAMENTOS"
        Me.MEDICAMENTOSBindingSource.DataSource = Me.FarmSAntonioDataSet10
        '
        'FarmSAntonioDataSet10
        '
        Me.FarmSAntonioDataSet10.DataSetName = "FarmSAntonioDataSet10"
        Me.FarmSAntonioDataSet10.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema
        '
        'MEDICAMENTOSTableAdapter
        '
        Me.MEDICAMENTOSTableAdapter.ClearBeforeFill = True
        '
        'salirmedt
        '
        Me.salirmedt.BackColor = System.Drawing.Color.Navy
        Me.salirmedt.Font = New System.Drawing.Font("Microsoft Sans Serif", 14.25!)
        Me.salirmedt.ForeColor = System.Drawing.Color.White
        Me.salirmedt.Location = New System.Drawing.Point(1041, 602)
        Me.salirmedt.Margin = New System.Windows.Forms.Padding(4, 5, 4, 5)
        Me.salirmedt.Name = "salirmedt"
        Me.salirmedt.Size = New System.Drawing.Size(147, 58)
        Me.salirmedt.TabIndex = 4
        Me.salirmedt.Text = "SALIR"
        Me.salirmedt.UseVisualStyleBackColor = False
        '
        'DEVENTAS
        '
        Me.DEVENTAS.DataSetName = "DEVENTAS"
        Me.DEVENTAS.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema
        '
        'MEDICAMENTOSBindingSource1
        '
        Me.MEDICAMENTOSBindingSource1.DataMember = "MEDICAMENTOS"
        Me.MEDICAMENTOSBindingSource1.DataSource = Me.DEVENTAS
        '
        'MEDICAMENTOSTableAdapter1
        '
        Me.MEDICAMENTOSTableAdapter1.ClearBeforeFill = True
        '
        'MEDICAMENTOSTableAdapter2
        '
        Me.MEDICAMENTOSTableAdapter2.ClearBeforeFill = True
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
        Me.Panel1.TabIndex = 81
        '
        'TodosMed
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(9.0!, 20.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(1200, 667)
        Me.Controls.Add(Me.Panel1)
        Me.Controls.Add(Me.salirmedt)
        Me.Controls.Add(Me.DataGridView1)
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.None
        Me.Name = "TodosMed"
        Me.Text = "TodosMed"
        CType(Me.DataGridView1, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.MEDICAMENTOSBindingSource2, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.DECOMPRASGERENCIA, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.MEDICAMENTOSBindingSource, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.FarmSAntonioDataSet10, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.DEVENTAS, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.MEDICAMENTOSBindingSource1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.Panel1.ResumeLayout(False)
        Me.Panel1.PerformLayout()
        Me.ResumeLayout(False)

    End Sub

    Friend WithEvents DataGridView1 As DataGridView
    Friend WithEvents FarmSAntonioDataSet10 As FarmSAntonioDataSet10
    Friend WithEvents MEDICAMENTOSBindingSource As BindingSource
    Friend WithEvents MEDICAMENTOSTableAdapter As FarmSAntonioDataSet10TableAdapters.MEDICAMENTOSTableAdapter
    Friend WithEvents salirmedt As Button
    Friend WithEvents DEVENTAS As DEVENTAS
    Friend WithEvents MEDICAMENTOSBindingSource1 As BindingSource
    Friend WithEvents MEDICAMENTOSTableAdapter1 As DEVENTASTableAdapters.MEDICAMENTOSTableAdapter
    Friend WithEvents DECOMPRASGERENCIA As DECOMPRASGERENCIA
    Friend WithEvents MEDICAMENTOSBindingSource2 As BindingSource
    Friend WithEvents MEDICAMENTOSTableAdapter2 As DECOMPRASGERENCIATableAdapters.MEDICAMENTOSTableAdapter
    Friend WithEvents Label9 As Label
    Friend WithEvents Panel1 As Panel
End Class
