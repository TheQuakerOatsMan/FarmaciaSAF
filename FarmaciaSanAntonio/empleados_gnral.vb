Public Class empleados_gnral
    Private Sub empleados_gnral_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        Select Case depa
            Case "VENTAS"
                consultaV = New ADODB.Recordset
                consultaV.Open("select * from EMPLEADOS order by CVEMP", modulo.conexionv)
                Dim ODA2 As New OleDb.OleDbDataAdapter
                Dim tb2 As New DataTable
                Dim ds2 As New DataSet
                ODA2.Fill(ds2, modulo.consultaV, "Table1")
                DataGridView1.DataSource = ds2.Tables("Table1").DefaultView
            Case "GERENCIA"
                consultaV2 = New ADODB.Recordset
                consultaV2.Open("select empleados.NOMEMP, empleados.DIREMP, empleados.CORREOEMP, empleados.TELEMP, empleados.EDADEMP, empleados.PUESTO, empleados.DEPTO, empleados.ACTIVO, usuarios.NUSUARIO from empleados inner join usuarios on usuarios.cvemp=empleados.cvemp order by empleados.cvemp", modulo.conexionv)
                Dim ODA As New OleDb.OleDbDataAdapter
                Dim tb As New DataTable
                Dim ds As New DataSet
                ODA.Fill(ds, modulo.consultaV2, "Table1")
                DataGridView1.DataSource = ds.Tables("Table1").DefaultView
            Case Else
                MsgBox("CONEXIONES NO DISPONIBLES, ERROR FALTAL")
        End Select

        menuprin.Enabled = False
    End Sub

    Private Sub salirempt_Click(sender As Object, e As EventArgs) Handles salirempt.Click
        menuprin.Enabled = True
        Close()
    End Sub
End Class