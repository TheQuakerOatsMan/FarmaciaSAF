Public Class NewCompra


    Public Sub habilita()
        Label1.Enabled = True
        Label2.Enabled = True
        Label5.Enabled = True
        panelTotal.Enabled = True
        addm.Enabled = True
        btnadd.Enabled = True
        btnCancel.Enabled = True
        data1.Enabled = True
        data2.Enabled = True


        Productos.Enabled = False
        Productos.Visible = False
        btnAgreProd.Enabled = False
        btnAgreProd.Visible = False
        btnRegProd.Enabled = False
        btnRegProd.Visible = False

        Medicamentos.Enabled = False
        Medicamentos.Visible = False
        btnAgrMed.Enabled = False
        btnAgrMed.Visible = False
        btnRegMed.Enabled = False
        btnRegMed.Visible = False
    End Sub
    Public Sub deshabilita()
        Label1.Enabled = False
        Label2.Enabled = False
        Label5.Enabled = False
        panelTotal.Enabled = False
        addm.Enabled = False
        btnadd.Enabled = False
        btnCancel.Enabled = False
        data1.Enabled = False
        data2.Enabled = False
    End Sub


    Public Sub cargadatos()
        'SE AGREGO ESTO PARA QUE SE ACTUALIZARA MAN'
        consulta6 = New ADODB.Recordset
        consulta6.Open("select * from medicamentos order by cvemed", modulo.conexionc)
        Dim ODAcM As New OleDb.OleDbDataAdapter
        Dim tb3 As New DataTable
        Dim ds3 As New DataSet
        ODAcM.Fill(ds3, modulo.consulta6, "Table1")
        Medicamentos.DataSource = ds3.Tables("Table1").DefaultView
        consulta7 = New ADODB.Recordset
        consulta7.Open("select * from productos order by cveprod", modulo.conexionc)
        Dim ODAcP As New OleDb.OleDbDataAdapter
        Dim tb4 As New DataTable
        Dim ds4 As New DataSet
        ODAcP.Fill(ds4, modulo.consulta7, "Table1")
        Productos.DataSource = ds4.Tables("Table1").DefaultView
        'fin de la llamada'
        consulta2 = New ADODB.Recordset
        consulta2.Open("select medicamentos.CVEMED, medicamentos.NOMED, medicamentos.PRECIOCOMPM, detcommed.CANTCOMPM from medicamentos inner join detcommed on detcommed.cvemed=medicamentos.cvemed where cvecomp=" & cvcomp.Text, modulo.conexionc)
        Dim ODA As New OleDb.OleDbDataAdapter
        Dim tb As New DataTable
        Dim ds As New DataSet
        ODA.Fill(ds, modulo.consulta2, "Table1")
        data1.DataSource = ds.Tables("Table1").DefaultView
        consulta3 = New ADODB.Recordset
        consulta3.Open("select productos.CVEPROD, productos.NOMP, productos.PRECIOCOMP, DETCOMPRO.CANTCOMP from productos inner join DETCOMPRO on DETCOMPRO.cveprod=productos.cveprod where cvecomp=" & cvcomp.Text, modulo.conexionc)
        Dim ODA2 As New OleDb.OleDbDataAdapter
        Dim tb2 As New DataTable
        Dim ds2 As New DataSet
        ODA.Fill(ds2, modulo.consulta3, "Table1")
        data2.DataSource = ds2.Tables("Table1").DefaultView
    End Sub

    Private Sub btnRegMed_Click(sender As Object, e As EventArgs) Handles btnRegMed.Click
        habilita()
    End Sub

    Private Sub btnRegProd_Click(sender As Object, e As EventArgs) Handles btnRegProd.Click
        habilita()
    End Sub


    Private Sub btnAgreProd_Click(sender As Object, e As EventArgs) Handles btnAgreProd.Click
        Dim frm As New detcompro
        If (Productos.SelectedRows.Count() > 0) Then
            frm.nomprod.Text = Productos.CurrentRow.Cells(1).Value.ToString()
            frm.cveprod.Text = Productos.CurrentRow.Cells(0).Value.ToString()
            frm.precomprod.Text = FormatCurrency(Productos.CurrentRow.Cells(3).Value.ToString())
            frm.cvecomp = Val(cvcomp.Text)
            frm.ShowDialog()
        Else
            MessageBox.Show("Debe seleccionar una fila")
        End If
    End Sub

    Private Sub btnAgrMed_Click(sender As Object, e As EventArgs) Handles btnAgrMed.Click
        Dim frm2 As New detcommed
        If (Medicamentos.SelectedRows.Count() > 0) Then
            frm2.nommed.Text = Medicamentos.CurrentRow.Cells(1).Value.ToString()
            frm2.cvemed.Text = Medicamentos.CurrentRow.Cells(0).Value.ToString()
            frm2.precommed.Text = FormatCurrency(Medicamentos.CurrentRow.Cells(3).Value.ToString())
            frm2.cvecomp = Val(cvcomp.Text)
            frm2.ShowDialog()
        Else
            MessageBox.Show("Debe seleccionar una fila")
        End If
    End Sub


    Private Sub NewCompra_Load_1(sender As Object, e As EventArgs) Handles MyBase.Load
        consulta6 = New ADODB.Recordset
        consulta6.Open("select * from medicamentos order by cvemed", modulo.conexionc)
        Dim ODAcM As New OleDb.OleDbDataAdapter
        Dim tb3 As New DataTable
        Dim ds3 As New DataSet
        ODAcM.Fill(ds3, modulo.consulta6, "Table1")
        Medicamentos.DataSource = ds3.Tables("Table1").DefaultView
        consulta7 = New ADODB.Recordset
        consulta7.Open("select * from productos order by cveprod", modulo.conexionc)
        Dim ODAcP As New OleDb.OleDbDataAdapter
        Dim tb4 As New DataTable
        Dim ds4 As New DataSet
        ODAcP.Fill(ds4, modulo.consulta7, "Table1")
        Productos.DataSource = ds4.Tables("Table1").DefaultView
        btnReComp.Enabled = False

        Productos.Enabled = False
        Productos.Visible = False
        btnAgreProd.Enabled = False
        btnAgreProd.Visible = False
        btnRegProd.Enabled = False
        btnRegProd.Visible = False

        Medicamentos.Enabled = False
        Medicamentos.Visible = False
        btnAgrMed.Enabled = False
        btnAgrMed.Visible = False
        btnRegMed.Enabled = False
        btnRegMed.Visible = False

        confirmEmp.Enabled = False
        confirmEmp.Visible = False

        consultaC = New ADODB.Recordset
        consultaC = conexionc.Execute("select * from COMPRAS where CVECOMP=" & cvcomp.Text)
        If Not consultaC.EOF Then
            subt.Text = FormatCurrency(consultaC.Fields(1).Value)
            fechaCom.Text = consultaC.Fields(2).Value
        Else
            MsgBox("La cve de la compra esta vacia o no se encuentra")
        End If
        subt.Enabled = False
        fechaCom.Enabled = False
        cargadatos()
    End Sub

    Private Sub btnCancel_Click_1(sender As Object, e As EventArgs) Handles btnCancel.Click
        ban = New ADODB.Parameter
        comanC = New ADODB.Command
        With comanC
            .CommandText = "BAJACOMPRAS"
            .CommandType = CommandType.StoredProcedure
            .Parameters.Append(.CreateParameter("0", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , Val(cvcomp.Text)))
            .Parameters.Append(.CreateParameter("1", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , claveUser))
            .Parameters.Append(.CreateParameter("2", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamOutput, , 0)) 'BANDERA val(nombredelcampo.Text)'
            .ActiveConnection = conexionc
            .Execute()
            ban.Value = .Parameters(2).Value

        End With
        If ban.Value = 1 Then
            MsgBox("LA CLAVE DE LA COMPRA NO PUEDE ESTAR VACIA")
        Else
            If ban.Value = 2 Then
                MsgBox("DETALLES EXISTENTES")
            Else
                If ban.Value = 4 Then
                    MsgBox("NO SE PUEDE BORRAR LA COMPRA")
                Else
                    If ban.Value = 50 Then
                        MsgBox("LA CLAVE DEL EMPLEADO NO PUEDE ESTA VACIA ")
                    Else
                        If ban.Value = 51 Then
                            MsgBox("EL USUARIO NO EXISTE")
                        Else
                            If ban.Value = 52 Then
                                MsgBox("SESION NO INICIADA, INICIE UNA SESION PARA CONTINUAR")
                            Else
                                MsgBox("COMPRA CANCELADA")
                                menuprin.Enabled = True
                                menuprin.Visible = True
                                Close()
                                'AÑADIR LOS CAMPOS QUE FALTAN'
                            End If
                        End If
                    End If
                End If
            End If
        End If
    End Sub

    Private Sub btnReComp_Click_1(sender As Object, e As EventArgs) Handles btnReComp.Click
        MessageBox.Show("COMPRA REALIZADA CON EXITO")
        menuprin.Enabled = True
        menuprin.Visible = True
        Close()
    End Sub

    Private Sub btnadd_Click_1(sender As Object, e As EventArgs) Handles btnadd.Click
        Productos.Enabled = True
        Productos.Visible = True
        btnAgreProd.Enabled = True
        btnAgreProd.Visible = True
        btnRegProd.Enabled = True
        btnRegProd.Visible = True

        deshabilita()
    End Sub

    Private Sub addm_Click(sender As Object, e As EventArgs) Handles addm.Click
        Medicamentos.Enabled = True
        Medicamentos.Visible = True
        btnAgrMed.Enabled = True
        btnAgrMed.Visible = True
        btnRegMed.Enabled = True
        btnRegMed.Visible = True

        deshabilita()
    End Sub
    Public Sub actData()
        consulta5 = New ADODB.Recordset
        consulta5 = conexionc.Execute("select * from compras where cvecomp=" & cvcomp.Text)
        If Not consulta5.EOF Then
            subt.Text = FormatCurrency(consulta5.Fields(1).Value)
        Else
            MsgBox("La cve de la venta esta vacia o no se encuentra")
        End If
        consulta6 = New ADODB.Recordset
        consulta6.Open("select * from medicamentos order by cvemed", modulo.conexionc)
        Dim ODAcM As New OleDb.OleDbDataAdapter
        Dim tb3 As New DataTable
        Dim ds3 As New DataSet
        ODAcM.Fill(ds3, modulo.consulta6, "Table1")
        Medicamentos.DataSource = ds3.Tables("Table1").DefaultView
        consulta7 = New ADODB.Recordset
        consulta7.Open("select * from productos order by cveprod", modulo.conexionc)
        Dim ODAcP As New OleDb.OleDbDataAdapter
        Dim tb4 As New DataTable
        Dim ds4 As New DataSet
        ODAcP.Fill(ds4, modulo.consulta7, "Table1")
        Productos.DataSource = ds4.Tables("Table1").DefaultView
    End Sub
End Class