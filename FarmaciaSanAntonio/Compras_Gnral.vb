Public Class Compras_Gnral

    Dim cvemed As Integer
    Dim cvecad As Integer
    Dim cveprod As Integer
    Private Sub btneTodo_Click(sender As Object, e As EventArgs) Handles btneTodo.Click
        ban = New ADODB.Parameter
        comanC = New ADODB.Command
        With comanC
            .CommandText = "BAJACOMPRAS"
            .CommandType = CommandType.StoredProcedure
            .Parameters.Append(.CreateParameter("0", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , Val(combocomp.SelectedItem)))
            .Parameters.Append(.CreateParameter("1", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , claveUser))
            .Parameters.Append(.CreateParameter("2", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamOutput, , 0)) 'BANDERA val(nombredelcampo.Text)'
            .ActiveConnection = conexionc
            .Execute()
            ban.Value = .Parameters(2).Value

        End With
        If ban.Value = 7 Then
            MsgBox("LA CLAVE DE LA COMPRA NO PUEDE ESTAR VACIA")
        Else
            If ban.Value = 8 Then
                MsgBox("DETALLES EXISTENTES")
            Else
                If ban.Value = 9 Then
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
                            End If
                        End If
                    End If
                End If
            End If
        End If
    End Sub

    Private Sub btnre16_Click(sender As Object, e As EventArgs) Handles btnre16.Click
        panelET.Visible = False
        panelP.Enabled = True
    End Sub

    Private Sub consultav_Click(sender As Object, e As EventArgs) Handles consultav.Click
        consulta2 = New ADODB.Recordset
        If CVECOMP.SelectedItem = 0 Then
            MsgBox("SELECIONA UNA CLAVE")
        Else
            consulta2 = conexionc.Execute("select * from compras where cvecomp=" & CVECOMP.Text)
            If Not consulta2.EOF Then
                TOTALCOMP.Text = FormatCurrency(consulta2.Fields(1).Value)
                FECHA.Text = consulta2.Fields(2).Value
                elimP.Enabled = True
                DETALLEMED.Enabled = True
            Else
                MsgBox("La cve del de la venta esta vacia o no existe")
            End If
        End If
    End Sub

    Private Sub Compras_Gnral_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        menuprin.Enabled = False
        menuprin.Visible = False
        TOTALCOMP.Enabled = False
        consulta3 = New ADODB.Recordset
        consulta3 = conexionc.Execute("select CVECOMP from COMPRAS order by CVECOMP")

        While Not consulta3.EOF
            combocomp.Items.Add(consulta3.Fields(0).Value)
            CVECOMP.Items.Add(consulta3.Fields(0).Value)
            consulta3.MoveNext()
        End While
    End Sub

    Private Sub salirV_Click(sender As Object, e As EventArgs) Handles salirV.Click
        menuprin.Enabled = True
        menuprin.Visible = True
        Close()
    End Sub

    Private Sub ELIMINA_Click(sender As Object, e As EventArgs) Handles ELIMINA.Click
        panelP.Enabled = False
        panelET.Visible = True
    End Sub



    Private Sub btnEDP_Click(sender As Object, e As EventArgs) Handles btnEDP.Click
        If (dataDetComed.SelectedRows.Count() > 0) Then
            cvemed = dataDetComed.CurrentRow.Cells(1).Value
            panelGanMed.Enabled = True
            panelGanMed.Visible = True
        Else
            MsgBox("DEBE SELECCIONAR UNA FILA")
        End If

    End Sub

    Private Sub btnAcep_Click(sender As Object, e As EventArgs) Handles btnAcep.Click
        ban = New ADODB.Parameter
        comanC2 = New ADODB.Command

        With comanC2
            .CommandText = "MODGANANCIAMED"
            .CommandType = CommandType.StoredProcedure
            .Parameters.Append(.CreateParameter("0", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , cvemed))
            .Parameters.Append(.CreateParameter("1", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , CDec(txtganancia.Text)))
            .Parameters.Append(.CreateParameter("2", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , claveUser))
            .Parameters.Append(.CreateParameter("3", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamOutput, , 0)) 'BANDERA val(nombredelcampo.Text)'
            .ActiveConnection = conexionc
            .Execute()
            ban.Value = .Parameters(3).Value

        End With

        If ban.Value = 1 Then
            MsgBox("LA CVE DEL MEDICAMENTO NO DEBE DE ESTAR VACIA")
        Else
            If ban.Value = 2 Then
                MsgBox("LA CVE DEL MEDICAMENTO NO DEBE DE ESTAR VACIA")
            Else
                If ban.Value = 3 Then
                    MsgBox("MEDICAMENTO INEXISTENTE")
                Else
                    If ban.Value = 4 Then
                        MsgBox("LA CVE DEL MEDICAMENTO NO DEBE DE ESTAR VACIA")
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
                                    MsgBox("GANANCIA MODIFICADA CON EXITO :D")
                                End If
                            End If
                        End If
                    End If
                End If
            End If
        End If

        panelGanMed.Visible = False
        panelGanMed.Enabled = False

        cvemed = 0
    End Sub

    Private Sub elimP_Click(sender As Object, e As EventArgs) Handles elimP.Click
        llenar2_data()
        panelEP.Enabled = False
        panelEP.Visible = False
        panDetProd.Enabled = True
        panDetProd.Visible = True
    End Sub

    Private Sub DETALLEMED_Click(sender As Object, e As EventArgs) Handles DETALLEMED.Click
        llenar_data()
        panelEP.Enabled = True
        panelEP.Visible = True
        panDetProd.Enabled = False
        panDetProd.Visible = False
    End Sub

    Public Sub llenar_data()
        consulta4 = New ADODB.Recordset
        consulta4.Open("select DETCOMMED.CVECOMP, DETCOMMED.CVEMED, DETCOMMED.CANTCOMPM, DETCOMMED.TIPOMED, DETCOMMED.CADM,DETCOMMED.PRECOMPM, DETCOMMED.LOTE, DETCOMMED.GANANCIAM from DETCOMMED where cvecomp=" & CVECOMP.Text, modulo.conexionc)
        Dim ODA As New OleDb.OleDbDataAdapter
        Dim tb As New DataTable
        Dim ds As New DataSet
        ODA.Fill(ds, modulo.consulta4, "Table1")
        dataDetComed.DataSource = ds.Tables("Table1").DefaultView
    End Sub

    Public Sub llenar2_data()
        consulta5 = New ADODB.Recordset
        consulta5.Open("select detcompro.CVECOMP, detcompro.cveprod, detcompro.CANTCOMP,  detcompro.CAD,detcompro.PRECOMP, detcompro.LOTE, detcompro.GANANCIAp from detcompro where cvecomp=" & CVECOMP.Text, modulo.conexionc)
        Dim ODA As New OleDb.OleDbDataAdapter
        Dim tb As New DataTable
        Dim ds As New DataSet
        ODA.Fill(ds, modulo.consulta5, "Table1")
        dataDetcompro.DataSource = ds.Tables("Table1").DefaultView
    End Sub

    Private Sub Button8_Click(sender As Object, e As EventArgs)
        If (dataDetcompro.SelectedRows.Count() > 0) Then
            cveprod = dataDetcompro.CurrentRow.Cells(1).Value
            panGanProd.Enabled = True
            panGanProd.Visible = True
        Else
            MsgBox("DEBE SELECCIONAR UNA FILA")
        End If
    End Sub

    Private Sub aceptarProd_Click(sender As Object, e As EventArgs) Handles acepFechaProd.Click
        ban = New ADODB.Parameter
        comanC3 = New ADODB.Command

        With comanC3
            .CommandText = "MODGANANCIAPROD"
            .CommandType = CommandType.StoredProcedure
            .Parameters.Append(.CreateParameter("0", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , cveprod))
            .Parameters.Append(.CreateParameter("1", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , CDec(txtgananprod.Text)))
            .Parameters.Append(.CreateParameter("2", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , claveUser))
            .Parameters.Append(.CreateParameter("3", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamOutput, , 0)) 'BANDERA val(nombredelcampo.Text)'
            .ActiveConnection = conexionc
            .Execute()
            ban.Value = .Parameters(3).Value

        End With
        If ban.Value = 1 Then
            MsgBox("LA CVE DEL PRODUCTO NO DEBE DE ESTAR VACIA")
        Else
            If ban.Value = 2 Then
                MsgBox("LA CVE DEL PRODUCTO NO DEBE DE ESTAR VACIA")
            Else
                If ban.Value = 3 Then
                    MsgBox("PRODUCTO INEXISTENTE")
                Else
                    If ban.Value = 4 Then
                        MsgBox("LA CVE DEL PRODUCTO NO DEBE DE ESTAR VACIA")
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
                                    MsgBox("GANANCIA MODIFICADA CON EXITO :D")
                                End If
                            End If
                        End If
                    End If
                End If
            End If
        End If

        panGanProd.Visible = False
        panGanProd.Enabled = False

        cveprod = 0

    End Sub

    Private Sub btnRegresar_Click(sender As Object, e As EventArgs) Handles btnRegresar.Click
        panelGanMed.Visible = False
        panelGanMed.Enabled = False
    End Sub

    Private Sub regprod_Click(sender As Object, e As EventArgs) Handles regfechProd.Click
        panGanProd.Visible = False
        panGanProd.Enabled = False
    End Sub


    Private Sub Button2_Click(sender As Object, e As EventArgs) Handles Button2.Click
        panFechaMed.Visible = False
        panFechaMed.Enabled = False
    End Sub

    Private Sub Button3_Click(sender As Object, e As EventArgs) Handles Button3.Click
        ban = New ADODB.Parameter
        comanC4 = New ADODB.Command
        With comanC4
            .CommandText = "MODFCAD"
            .CommandType = CommandType.StoredProcedure
            .Parameters.Append(.CreateParameter("0", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , cvecad))
            .Parameters.Append(.CreateParameter("1", DataTypeEnum.adDate, ParameterDirectionEnum.adParamInput, , Convert.ToDateTime(timepmed.Value.ToString("yyyy-MM-dd"))))
            .Parameters.Append(.CreateParameter("2", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , claveUser))
            .Parameters.Append(.CreateParameter("3", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamOutput, , 0)) 'BANDERA val(nombredelcampo.Text)'
            .ActiveConnection = conexionc
            .Execute()
            ban.Value = .Parameters(3).Value

        End With

        If ban.Value = 1 Then
            MsgBox("LA CVE DE LA CADUCIDAD ESTA VACIA")
        Else
            If ban.Value = 2 Then
                MsgBox("LA FECHA NO DEBE DE ESTAR VACIA")
            Else
                If ban.Value = 3 Then
                    MsgBox("LA FECHA INGRESADA ES MENOR A LA FECHA ACTUAL")
                Else
                    If ban.Value = 4 Then
                        MsgBox("RELACIONES ENCONTRADAS CON LA CADUCIDAD, NO SE PUEDE MODIFICAR")
                    Else
                        If ban.Value = 5 Then
                            MsgBox("LA FECHA DE CADUCIDAD NO EXISTE")
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
                                        MsgBox("CADUCIDAD MODIFICADA CON EXITO :D")
                                    End If
                                End If
                            End If
                        End If
                    End If
                End If
            End If
        End If

        panFechaMed.Visible = False
        panFechaMed.Enabled = False


        cvecad = 0
    End Sub

    Private Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click
        cvemed = dataDetComed.CurrentRow.Cells(1).Value
        Dim fecha As DateTime = dataDetComed.CurrentRow.Cells(4).Value
        Convert.ToDateTime(fecha)
        Dim fechac As String = Format(fecha, "yyyy/MM/dd")
        consulta5 = conexionc.Execute("select cvecad from caducidad where fechacad = " & fechac)
        cvecad = consulta5.Fields(0).Value

        If (dataDetComed.SelectedRows.Count() > 0) Then
            panFechaMed.Enabled = True
            panFechaMed.Visible = True
        Else
            MsgBox("DEBE SELECCIONAR UNA FILA")
        End If
    End Sub

    Private Sub regprodF_Click(sender As Object, e As EventArgs) Handles regprodF.Click
        panFechaProd.Visible = False
        panFechaProd.Enabled = False
    End Sub

    Private Sub acpFechaProd_Click(sender As Object, e As EventArgs) Handles acpFechaProd.Click
        ban = New ADODB.Parameter
        comanC5 = New ADODB.Command

        With comanC5
            .CommandText = "MODFCAD"
            .CommandType = CommandType.StoredProcedure
            .Parameters.Append(.CreateParameter("0", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , cvecad))
            .Parameters.Append(.CreateParameter("1", DataTypeEnum.adDate, ParameterDirectionEnum.adParamInput, , Convert.ToDateTime(timepprod.Value.ToString("yyyy-MM-dd"))))
            .Parameters.Append(.CreateParameter("2", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , claveUser))
            .Parameters.Append(.CreateParameter("3", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamOutput, , 0)) 'BANDERA val(nombredelcampo.Text)'
            .ActiveConnection = conexionc
            .Execute()
            ban.Value = .Parameters(3).Value

        End With

        If ban.Value = 1 Then
            MsgBox("LA CVE DE LA CADUCIDAD ESTA VACIA")
        Else
            If ban.Value = 2 Then
                MsgBox("LA FECHA NO DEBE DE ESTAR VACIA")
            Else
                If ban.Value = 3 Then
                    MsgBox("LA FECHA INGRESADA ES MENOR A LA FECHA ACTUAL")
                Else
                    If ban.Value = 4 Then
                        MsgBox("RELACIONES ENCONTRADAS CON LA CADUCIDAD, NO SE PUEDE MODIFICAR")
                    Else
                        If ban.Value = 5 Then
                            MsgBox("LA FECHA DE CADUCIDAD NO EXISTE")
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
                                        MsgBox("CADUCIDAD MODIFICADA CON EXITO :D")
                                    End If
                                End If
                            End If
                        End If
                    End If
                End If
            End If
        End If

        panFechaProd.Visible = False
        panFechaProd.Enabled = False

        cvecad = 0
    End Sub

    Private Sub btnre11_Click(sender As Object, e As EventArgs) Handles btnre11.Click
        panelEP.Enabled = False
        panelEP.Visible = False
    End Sub


    Private Sub Button6_Click(sender As Object, e As EventArgs) Handles Button6.Click
        cveprod = dataDetcompro.CurrentRow.Cells(1).Value
        Dim fecha As DateTime = dataDetcompro.CurrentRow.Cells(4).Value
        Convert.ToDateTime(fecha)
        Dim fechac As String = Format(fecha, "yyyy/MM/dd")
        consulta5 = conexionc.Execute("select cvecad from caducidad where fechacad = " & fechac)
        cvecad = consulta5.Fields(0).Value
        If (dataDetcompro.SelectedRows.Count() > 0) Then
            cvecad = dataDetcompro.CurrentRow.Cells(1).Value
            panFechaProd.Enabled = True
            panFechaProd.Visible = True
        Else
            MsgBox("DEBE SELECCIONAR UNA FILA")
        End If
    End Sub

    Private Sub Button8_Click_1(sender As Object, e As EventArgs) Handles Button8.Click
        If (dataDetcompro.SelectedRows.Count() > 0) Then
            cveprod = dataDetcompro.CurrentRow.Cells(1).Value
            panGanProd.Enabled = True
            panGanProd.Visible = True
        Else
            MsgBox("DEBE SELECCIONAR UNA FILA")
        End If
    End Sub

    Private Sub Button7_Click_1(sender As Object, e As EventArgs) Handles Button7.Click
        panDetProd.Visible = False
        panDetProd.Enabled = False
    End Sub
End Class