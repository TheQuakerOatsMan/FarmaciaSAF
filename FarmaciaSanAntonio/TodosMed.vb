Public Class TodosMed
    Private Sub TodosMed_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        Select Case depa
            Case "COMPRAS"
                'TODO: esta línea de código carga datos en la tabla 'DECOMPRASGERENCIA.MEDICAMENTOS' Puede moverla o quitarla según sea necesario.
                'Me.MEDICAMENTOSTableAdapter2.Fill(Me.DECOMPRASGERENCIA.MEDICAMENTOS)'
                consultaC = New ADODB.Recordset
                consultaC.Open("select * from medicamentos order by cvemed", modulo.conexionc)
                Dim ODA As New OleDb.OleDbDataAdapter
                Dim tb As New DataTable
                Dim ds As New DataSet
                ODA.Fill(ds, modulo.consultaC, "Table1")
                DataGridView1.DataSource = ds.Tables("Table1").DefaultView
            Case "GERENCIA"
                consultaC = New ADODB.Recordset
                consultaC.Open("select * from medicamentos order by cvemed", modulo.conexionc)
                Dim ODA As New OleDb.OleDbDataAdapter
                Dim tb As New DataTable
                Dim ds As New DataSet
                ODA.Fill(ds, modulo.consultaC, "Table1")
                DataGridView1.DataSource = ds.Tables("Table1").DefaultView
            Case "VENTAS"
                consultaV = New ADODB.Recordset
                consultaV.Open("select * from medicamentos order by cvemed", modulo.conexionv)
                Dim ODA As New OleDb.OleDbDataAdapter
                Dim tb As New DataTable
                Dim ds As New DataSet
                ODA.Fill(ds, modulo.consultaV, "Table1")
                DataGridView1.DataSource = ds.Tables("Table1").DefaultView
            Case Else
                MsgBox("CONEXIONES NO DISPONIBLES, ERROR FALTAL")
        End Select
        menuprin.Enabled = False
    End Sub

    Private Sub salirmedt_Click(sender As Object, e As EventArgs) Handles salirmedt.Click
        menuprin.Enabled = True
        Close()
    End Sub
End Class