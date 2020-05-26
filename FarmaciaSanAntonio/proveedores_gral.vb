Public Class proveedores_gral
    Private Sub proveedores_gral_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        consultaC = New ADODB.Recordset
        consultaC.Open("select * from proveedores order by cveprov", modulo.conexionc)
        Dim ODA As New OleDb.OleDbDataAdapter
        Dim tb As New DataTable
        Dim ds As New DataSet
        ODA.Fill(ds, modulo.consultaC, "Table1")
        DataGridView11.DataSource = ds.Tables("Table1").DefaultView
        menuprin.Enabled = False
    End Sub

    Private Sub salirprovt_Click(sender As Object, e As EventArgs) Handles salirprovt.Click
        menuprin.Enabled = True
        Close()
    End Sub

End Class