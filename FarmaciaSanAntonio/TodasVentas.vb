Public Class TodasVentas
    Private Sub TodasVentas_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        consultaV = New ADODB.Recordset
        consultaV.Open("select * from ventas order by cvevta", modulo.conexionv)
        Dim ODA As New OleDb.OleDbDataAdapter
        Dim tb As New DataTable
        Dim ds As New DataSet
        ODA.Fill(ds, modulo.consultaV, "Table1")
        DataGridView1.DataSource = ds.Tables("Table1").DefaultView
        menuprin.Enabled = False
    End Sub

    Private Sub salirvent_Click(sender As Object, e As EventArgs) Handles salirvent.Click
        menuprin.Enabled = True
        Close()
    End Sub

End Class