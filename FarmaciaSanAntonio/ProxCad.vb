

Public Class ProxCad
    Private Sub salircapt_Click(sender As Object, e As EventArgs) Handles salircapt.Click
        menuprin.Enabled = True
        Close()
    End Sub

    Private Sub ProxCad_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        consultaC = New ADODB.Recordset
        consultaC.Open("SELECT MEDICAMENTOS.NOMED, CADUCIDAD.FECHACAD, DETCADMED.LOTE FROM MEDICAMENTOS INNER JOIN (DETCADMED INNER JOIN CADUCIDAD ON DETCADMED.CVECAD = CADUCIDAD.CVECAD) ON DETCADMED.CVEMED =
        MEDICAMENTOS.CVEMED ORDER BY FECHACAD", modulo.conexionc)
        Dim ODA As New OleDb.OleDbDataAdapter
        Dim tb As New DataTable
        Dim ds As New DataSet
        ODA.Fill(ds, modulo.consultaC, "Table1")
        GRIDMED.DataSource = ds.Tables("Table1").DefaultView

        consulta2 = New ADODB.Recordset
        consulta2.Open("SELECT PRODUCTOS.NOMP, CADUCIDAD.FECHACAD, DETCADPRO.LOTE FROM PRODUCTOS INNER JOIN (DETCADPRO INNER JOIN CADUCIDAD ON DETCADPRO.CVECAD = CADUCIDAD.CVECAD) ON DETCADPRO.CVEPROD =
        PRODUCTOS.CVEPROD ORDER BY FECHACAD", modulo.conexionc)
        Dim ODA2 As New OleDb.OleDbDataAdapter
        Dim tb2 As New DataTable
        Dim ds2 As New DataSet
        ODA2.Fill(ds2, modulo.consulta2, "Table2")
        GRIDPROD.DataSource = ds2.Tables("Table2").DefaultView
    End Sub
End Class