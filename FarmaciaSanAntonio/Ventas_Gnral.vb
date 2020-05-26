Imports System.Data.SqlClient

Public Class Ventas_Gnral
    Private Sub Ventas_Gnral_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        menuprin.Enabled = False
        consulta = New ADODB.Recordset
        consulta = conexionv.Execute("select cvevta from ventas order by cvevta")

        While Not consulta.EOF
            comboventa.Items.Add(consulta.Fields(0).Value)
            CVEVTA.Items.Add(consulta.Fields(0).Value)
            consulta.MoveNext()
        End While
    End Sub


    Private Sub btnre2_Click(sender As Object, e As EventArgs) Handles btnre2.Click
        PanelEM.Visible = False
        panelP.Enabled = True
    End Sub


    Private Sub modTP_Click(sender As Object, e As EventArgs) Handles modTP.Click
        ban = New ADODB.Parameter
        comanV = New ADODB.Command
        With comanV
            .CommandText = "MODTIPOPAG"
            .CommandType = CommandType.StoredProcedure
            '.Parameters.Append(.CreateParameter("0", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , Val(CVEPROV.Text))) ' sirve para un entero decimal o money para el tipo de dato fecha se busca como date y para el tipo de dato money se busca como currency'
            .Parameters.Append(.CreateParameter("0", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , Val(comboV.SelectedItem)))
            .Parameters.Append(.CreateParameter("1", DataTypeEnum.adVarChar, ParameterDirectionEnum.adParamInput, 21, tppag.SelectedItem.ToString))
            .Parameters.Append(.CreateParameter("2", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , claveUser))
            .Parameters.Append(.CreateParameter("3", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamOutput, , 0)) 'BANDERA val(nombredelcampo.Text)'
            .ActiveConnection = conexionv
            .Execute()
            ban.Value = .Parameters(3).Value

        End With
        If ban.Value = 1 Then
            MsgBox("LA CVE DE LA VENTA NO PUEDE ESTAR VACIA")
        Else
            If ban.Value = 2 Then
                MsgBox("EL TIPO DE PAGO NO DEBE DE ESTAR VACIO")
            Else
                If ban.Value = 3 Then
                    MsgBox("EL TIPO DE PAGO TIENE NUMEROS")
                Else
                    If ban.Value = 4 Then
                        MsgBox("EL TIPO DE PAGO EXCEDE EL RANGO")
                    Else
                        If ban.Value = 5 Then
                            MsgBox("ESTA VENTA NO SE ENCUENTRA REGISTRADA")
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
                                        If ban.Value = 53 Then
                                            MsgBox("EL DEPARTAMENTO AL QUE PERTENECE ESTE USUARIO NO ESTA PERMITIDO PARA REALIZAR ESTE TIPO DE OPERACION")
                                        Else
                                            MsgBox("TIPO DE PAGO ACTUALIZADO")

                                        End If
                                    End If
                                End If
                            End If
                        End If
                    End If
                End If
            End If
        End If

    End Sub

    Private Sub btnre3_Click_1(sender As Object, e As EventArgs) Handles btnre3.Click
        comboV.Items.Clear()
        PanelMT.Visible = False
        panelP.Enabled = True
    End Sub

    Private Sub consultav_Click(sender As Object, e As EventArgs) Handles consultav.Click
        consulta2 = New ADODB.Recordset
        If CVEVTA.SelectedItem = 0 Then
            MsgBox("SELECIONA UNA CLAVE")
        Else
            consulta2 = conexionv.Execute("select * from ventas where cvevta=" & CVEVTA.Text)
            If Not consulta2.EOF Then
                SUBTOTAL.Text = FormatCurrency(consulta2.Fields(1).Value)
                IVA.Text = FormatCurrency(consulta2.Fields(2).Value)
                TIPOP.Text = consulta2.Fields(3).Value
                FECHA.Text = FormatDateTime(consulta2.Fields(4).Value)
                modV.Enabled = True
                elimP.Enabled = True
                elimM.Enabled = True
            Else
                MsgBox("La cve del de la venta esta vacia o no existe")
            End If
        End If
    End Sub
    Public Sub llenar_data()
        consulta2 = New ADODB.Recordset
        consulta2.Open("select medicamentos.CVEMED, medicamentos.NOMED, medicamentos.PRECIOVTAM, detvtamed.IMGRECT, detvtamed.CANTVM from medicamentos inner join detvtamed on detvtamed.cvemed=medicamentos.cvemed where cvevta=" & CVEVTA.Text, modulo.conexionv)
        Dim ODA As New OleDb.OleDbDataAdapter
        Dim tb As New DataTable
        Dim ds As New DataSet
        ODA.Fill(ds, modulo.consulta2, "Table1")
        datadetvm.DataSource = ds.Tables("Table1").DefaultView
    End Sub
    Public Sub llenar_data2()
        consulta2 = New ADODB.Recordset
        consulta2.Open("select productos.CVEPROD, productos.NOMP, productos.PRECIOVTAP, detvtapro.CANTVP from productos inner join detvtapro on detvtapro.cveprod=productos.cveprod where cvevta=" & CVEVTA.Text, modulo.conexionv)
        Dim ODA As New OleDb.OleDbDataAdapter
        Dim tb As New DataTable
        Dim ds As New DataSet
        ODA.Fill(ds, modulo.consulta2, "Table1")
        datavtapro.DataSource = ds.Tables("Table1").DefaultView
    End Sub

    Private Sub modV_Click_1(sender As Object, e As EventArgs) Handles modV.Click
        PanelMT.Visible = True
        panelP.Enabled = False
        comboV.Items.Add(CVEVTA.SelectedItem)
        comboV.SelectedText = CVEVTA.SelectedItem
    End Sub

    Private Sub salirV_Click_1(sender As Object, e As EventArgs) Handles salirV.Click
        menuprin.Enabled = True
        menuprin.Visible = True
        Close()
    End Sub

    Private Sub elimM_Click_1(sender As Object, e As EventArgs) Handles elimM.Click
        llenar_data()
        panelP.Enabled = False
        PanelEM.Visible = True
    End Sub

    Private Sub btnre_Click(sender As Object, e As EventArgs) Handles btnre.Click
        Dim clavemed As Integer
        Dim clavevta As Integer
        Dim imgreceta As String
        If (datadetvm.SelectedRows.Count() > 0) Then
            clavemed = datadetvm.CurrentRow.Cells(0).Value
            clavevta = Val(CVEVTA.Text)
            imgreceta = datadetvm.CurrentRow.Cells(3).Value.ToString
            ban = New ADODB.Parameter
            comanV = New ADODB.Command
            With comanV
                .CommandText = "BAJADETMED"
                .CommandType = CommandType.StoredProcedure
                '.Parameters.Append(.CreateParameter("0", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , Val(CVEPROV.Text))) ' sirve para un entero decimal o money para el tipo de dato fecha se busca como date y para el tipo de dato money se busca como currency'
                .Parameters.Append(.CreateParameter("0", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , clavevta))
                .Parameters.Append(.CreateParameter("1", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , clavemed))
                .Parameters.Append(.CreateParameter("2", DataTypeEnum.adVarChar, ParameterDirectionEnum.adParamInput, 100, imgreceta))
                .Parameters.Append(.CreateParameter("3", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , claveUser))
                .Parameters.Append(.CreateParameter("4", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamOutput, , 0)) 'BANDERA val(nombredelcampo.Text)'
                .ActiveConnection = conexionv
                .Execute()
                ban.Value = .Parameters(4).Value

            End With
            If ban.Value = 1 Then
                MsgBox("EL DETALLE NO EXISTE")
            Else
                If ban.Value = 3 Then
                    MsgBox("MEDICAMENTO INEXISTENTE")
                Else
                    If ban.Value = 2 Then
                        MsgBox("SESION NO INICIADA, INICIE UNA SESION PARA CONTINUAR")
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
                                    If ban.Value = 53 Then
                                        MsgBox("EL DEPARTAMENTO AL QUE PERTENECE ESTE USUARIO NO ESTA PERMITIDO PARA REALIZAR ESTE TIPO DE OPERACION")
                                    Else
                                        MsgBox("DETALLE ELIMINADO CON EXITO :D")
                                        'AÑADIR LOS CAMPOS QUE FALTAN'
                                        llenar_data()
                                    End If
                                End If
                            End If
                        End If
                    End If
                End If
            End If
        Else
            MessageBox.Show("Debe seleccionar una fila")
        End If
    End Sub

    Private Sub elimP_Click(sender As Object, e As EventArgs) Handles elimP.Click
        llenar_data2()
        panelP.Enabled = False
        panelEP.Visible = True
    End Sub

    Private Sub btnre11_Click(sender As Object, e As EventArgs) Handles btnre11.Click
        panelEP.Visible = False
        panelP.Enabled = True
    End Sub

    Private Sub btnEDP_Click(sender As Object, e As EventArgs) Handles btnEDP.Click
        Dim claveprod As Integer
        Dim clavevta As Integer

        If (datavtapro.SelectedRows.Count() > 0) Then
            claveprod = datavtapro.CurrentRow.Cells(0).Value
            clavevta = Val(CVEVTA.Text)
            ban = New ADODB.Parameter
            comanV = New ADODB.Command
            With comanV
                .CommandText = "BAJADETPROD"
                .CommandType = CommandType.StoredProcedure
                '.Parameters.Append(.CreateParameter("0", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , Val(CVEPROV.Text))) ' sirve para un entero decimal o money para el tipo de dato fecha se busca como date y para el tipo de dato money se busca como currency'
                .Parameters.Append(.CreateParameter("0", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , clavevta))
                .Parameters.Append(.CreateParameter("1", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , claveprod))
                .Parameters.Append(.CreateParameter("2", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , claveUser))
                .Parameters.Append(.CreateParameter("3", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamOutput, , 0)) 'BANDERA val(nombredelcampo.Text)'
                .ActiveConnection = conexionv
                .Execute()
                ban.Value = .Parameters(3).Value

            End With
            If ban.Value = 1 Then
                MsgBox("EL DETALLE NO EXISTE")
            Else
                If ban.Value = 3 Then
                    MsgBox("PRODUCTO INEXISTENTE")
                Else
                    If ban.Value = 2 Then
                        MsgBox("SESION NO INICIADA, INICIE UNA SESION PARA CONTINUAR")
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
                                    If ban.Value = 53 Then
                                        MsgBox("EL DEPARTAMENTO AL QUE PERTENECE ESTE USUARIO NO ESTA PERMITIDO PARA REALIZAR ESTE TIPO DE OPERACION")
                                    Else
                                        MsgBox("DETALLE ELIMINADO CON EXITO :D")
                                        'AÑADIR LOS CAMPOS QUE FALTAN'
                                        llenar_data2()
                                    End If
                                End If
                            End If
                        End If
                    End If
                End If
            End If
        Else
            MessageBox.Show("Debe seleccionar una fila")
        End If
    End Sub

    Private Sub btnre16_Click(sender As Object, e As EventArgs) Handles btnre16.Click
        panelET.Visible = False
        panelP.Enabled = True
    End Sub

    Private Sub btneTodo_Click(sender As Object, e As EventArgs) Handles btneTodo.Click
        ban = New ADODB.Parameter
        comanV = New ADODB.Command
        With comanV
            .CommandText = "BAJAVTAS"
            .CommandType = CommandType.StoredProcedure
            '.Parameters.Append(.CreateParameter("0", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , Val(CVEPROV.Text))) ' sirve para un entero decimal o money para el tipo de dato fecha se busca como date y para el tipo de dato money se busca como currency'
            .Parameters.Append(.CreateParameter("0", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , Val(comboventa.SelectedItem)))
            .Parameters.Append(.CreateParameter("1", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , claveUser))
            .Parameters.Append(.CreateParameter("2", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamOutput, , 0)) 'BANDERA val(nombredelcampo.Text)'
            .ActiveConnection = conexionv
            .Execute()
            ban.Value = .Parameters(2).Value

        End With
        If ban.Value = 1 Then
            MsgBox("LA CVE DE LA VENTA SE ENCUENTRA VACIA")
        Else
            If ban.Value = 2 Then
                MsgBox("LA CVE DE LA VENTA NO EXISTE")
            Else
                If ban.Value = 3 Then
                    MsgBox("NO SE PUEDE BORRAR LA VENTA")
                Else
                    If ban.Value = 4 Then
                        MsgBox("SESION NO INICIADA, INICIE UNA SESION PARA CONTINUAR")
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
                                    If ban.Value = 53 Then
                                        MsgBox("EL DEPARTAMENTO AL QUE PERTENECE ESTE USUARIO NO ESTA PERMITIDO PARA REALIZAR ESTE TIPO DE OPERACION")
                                    Else
                                        MsgBox("VENTA CANCELADA")
                                        'AÑADIR LOS CAMPOS QUE FALTAN'
                                    End If
                                End If
                            End If
                        End If
                    End If
                End If
            End If
        End If
    End Sub

    Private Sub ELIMINA_Click(sender As Object, e As EventArgs) Handles ELIMINA.Click
        panelP.Enabled = False
        panelET.Visible = True
    End Sub

    Private Sub btnmodImg_Click(sender As Object, e As EventArgs) Handles btnmodImg.Click
        Dim clavemed As Integer
        Dim clavevta As Integer
        Dim imgreceta As String
        Dim formula As New MODIMGRECT
        If (datadetvm.SelectedRows.Count() > 0) Then
            clavemed = datadetvm.CurrentRow.Cells(0).Value
            clavevta = Val(CVEVTA.Text)
            imgreceta = datadetvm.CurrentRow.Cells(3).Value.ToString
            formula.txtcvevta.Text = clavevta.ToString
            formula.txtcvemed.Text = clavemed.ToString
            formula.txtimgrect.Text = imgreceta
            formula.ShowDialog()
        Else
            MessageBox.Show("Debe seleccionar una fila")
        End If
    End Sub

End Class