<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class TodosProd
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
        Me.PRODUCTOSBindingSource = New System.Windows.Forms.BindingSource(Me.components)
        Me.FarmSAntonioDataSet8 = New FarmaciaSanAntonio.FarmSAntonioDataSet8()
        Me.PRODUCTOSTableAdapter = New FarmaciaSanAntonio.FarmSAntonioDataSet8TableAdapters.PRODUCTOSTableAdapter()
        Me.salirprodt = New System.Windows.Forms.Button()
        Me.DEVENTASP = New FarmaciaSanAntonio.DEVENTASP()
        Me.PRODUCTOSBindingSource1 = New System.Windows.Forms.BindingSource(Me.components)
        Me.PRODUCTOSTableAdapter1 = New FarmaciaSanAntonio.DEVENTASPTableAdapters.PRODUCTOSTableAdapter()
        Me.DECOMPRASP = New FarmaciaSanAntonio.DECOMPRASP()
        Me.PRODUCTOSBindingSource2 = New System.Windows.Forms.BindingSource(Me.components)
        Me.PRODUCTOSTableAdapter2 = New FarmaciaSanAntonio.DECOMPRASPTableAdapters.PRODUCTOSTableAdapter()
        Me.Label9 = New System.Windows.Forms.Label()
        Me.Panel1 = New System.Windows.Forms.Panel()
        CType(Me.DataGridView1, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.PRODUCTOSBindingSource, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.FarmSAntonioDataSet8, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.DEVENTASP, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.PRODUCTOSBindingSource1, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.DECOMPRASP, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.PRODUCTOSBindingSource2, System.ComponentModel.ISupportInitialize).BeginInit()
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
        'PRODUCTOSBindingSource
        '
        Me.PRODUCTOSBindingSource.DataMember = "PRODUCTOS"
        Me.PRODUCTOSBindingSource.DataSource = Me.FarmSAntonioDataSet8
        '
        'FarmSAntonioDataSet8
        '
        Me.FarmSAntonioDataSet8.DataSetName = "FarmSAntonioDataSet8"
        Me.FarmSAntonioDataSet8.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema
        '
        'PRODUCTOSTableAdapter
        '
        Me.PRODUCTOSTableAdapter.ClearBeforeFill = True
        '
        'salirprodt
        '
        Me.salirprodt.BackColor = System.Drawing.Color.Navy
        Me.salirprodt.Font = New System.Drawing.Font("Microsoft Sans Serif", 14.25!)
        Me.salirprodt.ForeColor = System.Drawing.Color.White
        Me.salirprodt.Location = New System.Drawing.Point(1040, 602)
        Me.salirprodt.Margin = New System.Windows.Forms.Padding(4, 5, 4, 5)
        Me.salirprodt.Name = "salirprodt"
        Me.salirprodt.Size = New System.Drawing.Size(147, 58)
        Me.salirprodt.TabIndex = 2
        Me.salirprodt.Text = "SALIR"
        Me.salirprodt.UseVisualStyleBackColor = False
        '
        'DEVENTASP
        '
        Me.DEVENTASP.DataSetName = "DEVENTASP"
        Me.DEVENTASP.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema
        '
        'PRODUCTOSBindingSource1
        '
        Me.PRODUCTOSBindingSource1.DataMember = "PRODUCTOS"
        Me.PRODUCTOSBindingSource1.DataSource = Me.DEVENTASP
        '
        'PRODUCTOSTableAdapter1
        '
        Me.PRODUCTOSTableAdapter1.ClearBeforeFill = True
        '
        'DECOMPRASP
        '
        Me.DECOMPRASP.DataSetName = "DECOMPRASP"
        Me.DECOMPRASP.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema
        '
        'PRODUCTOSBindingSource2
        '
        Me.PRODUCTOSBindingSource2.DataMember = "PRODUCTOS"
        Me.PRODUCTOSBindingSource2.DataSource = Me.DECOMPRASP
        '
        'PRODUCTOSTableAdapter2
        '
        Me.PRODUCTOSTableAdapter2.ClearBeforeFill = True
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
        Me.Panel1.TabIndex = 80
        '
        'TodosProd
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(9.0!, 20.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(1200, 667)
        Me.Controls.Add(Me.Panel1)
        Me.Controls.Add(Me.salirprodt)
        Me.Controls.Add(Me.DataGridView1)
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.None
        Me.Name = "TodosProd"
        Me.Text = "TodosProd"
        CType(Me.DataGridView1, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.PRODUCTOSBindingSource, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.FarmSAntonioDataSet8, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.DEVENTASP, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.PRODUCTOSBindingSource1, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.DECOMPRASP, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.PRODUCTOSBindingSource2, System.ComponentModel.ISupportInitialize).EndInit()
        Me.Panel1.ResumeLayout(False)
        Me.Panel1.PerformLayout()
        Me.ResumeLayout(False)

    End Sub

    Friend WithEvents DataGridView1 As DataGridView
    Friend WithEvents FarmSAntonioDataSet8 As FarmSAntonioDataSet8
    Friend WithEvents PRODUCTOSBindingSource As BindingSource
    Friend WithEvents PRODUCTOSTableAdapter As FarmSAntonioDataSet8TableAdapters.PRODUCTOSTableAdapter
    Friend WithEvents salirprodt As Button
    Friend WithEvents DEVENTASP As DEVENTASP
    Friend WithEvents PRODUCTOSBindingSource1 As BindingSource
    Friend WithEvents PRODUCTOSTableAdapter1 As DEVENTASPTableAdapters.PRODUCTOSTableAdapter
    Friend WithEvents DECOMPRASP As DECOMPRASP
    Friend WithEvents PRODUCTOSBindingSource2 As BindingSource
    Friend WithEvents PRODUCTOSTableAdapter2 As DECOMPRASPTableAdapters.PRODUCTOSTableAdapter
    Friend WithEvents Label9 As Label
    Friend WithEvents Panel1 As Panel
End Class
