Public Class TodasCompras
    Private Sub TodasCompras_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        consultaC = New ADODB.Recordset
        consultaC.Open("select * from COMPRAS order by CVECOMP", modulo.conexionc)
        Dim ODA As New OleDb.OleDbDataAdapter
        Dim tb As New DataTable
        Dim ds As New DataSet
        ODA.Fill(ds, modulo.consultaC, "Table1")
        DataGridView1.DataSource = ds.Tables("Table1").DefaultView
        menuprin.Enabled = False
        menuprin.Enabled = False
    End Sub

    Private Sub salircomt_Click(sender As Object, e As EventArgs) Handles salircomt.Click
        menuprin.Enabled = True
        Close()
    End Sub
End Class