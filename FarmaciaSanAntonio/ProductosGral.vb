Public Class ProductosGral
    Private Sub ProductosGral_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        menuprin.Enabled = False
        menuprin.Visible = False
        If (depa = "VENTAS") Then
            consultaV = New ADODB.Recordset
            consultaV = conexionv.Execute("select cveprod from productos order by cveprod")

            While Not consultaV.EOF
                CVEPROD.Items.Add(consultaV.Fields(0).Value) 'si no jala fijate en referencias y en propiedades, y le ponemos la opcion 5 en false'
                comboeliminar.Items.Add(consultaV.Fields(0).Value)
                combotemporal.Items.Add(consultaV.Fields(0).Value)
                comboreac.Items.Add(consultaV.Fields(0).Value)
                combomod.Items.Add(consultaV.Fields(0).Value)
                consultaV.MoveNext()
            End While
        Else
            If (depa = "GERENCIA" Or depa = "COMPRAS") Then
                consultaC = New ADODB.Recordset
                consultaC = conexionc.Execute("select cveprod from productos order by cveprod")

                While Not consultaC.EOF
                    CVEPROD.Items.Add(consultaC.Fields(0).Value) 'si no jala fijate en referencias y en propiedades, y le ponemos la opcion 5 en false'
                    comboeliminar.Items.Add(consultaC.Fields(0).Value)
                    combotemporal.Items.Add(consultaC.Fields(0).Value)
                    comboreac.Items.Add(consultaC.Fields(0).Value)
                    combomod.Items.Add(consultaC.Fields(0).Value)
                    consultaC.MoveNext()
                End While
            End If
        End If

    End Sub

    Private Sub btnConsultaP_Click(sender As Object, e As EventArgs) Handles btnConsultaP.Click
        consulta2 = New ADODB.Recordset
        If CVEPROD.SelectedItem = 0 Then
            MsgBox("CLAVE VACIA")
        Else
            If (depa = "GERENCIA" Or depa = "COMPRAS") Then
                consulta2 = conexionc.Execute("select * from productos where cveprod=" & CVEPROD.Text)
                If Not consulta2.EOF Then
                    NOMPROD.Text = consulta2.Fields(1).Value
                    DESCRIP.Text = consulta2.Fields(2).Value
                    PRECIOCOMP.Text = FormatCurrency(consulta2.Fields(3).Value)
                    PRECIOVTAP.Text = FormatCurrency(consulta2.Fields(4).Value)
                    EXISTENCIASP.Text = consulta2.Fields(5).Value
                    ESTADO.Text = consulta2.Fields(6).Value
                Else
                    MsgBox("La cve del producto esta vacia el producto no existe")
                End If
            End If
            If (depa = "VENTAS") Then
                consulta2 = conexionv.Execute("select * from productos where cveprod=" & CVEPROD.Text)
                If Not consulta2.EOF Then
                    NOMPROD.Text = consulta2.Fields(1).Value
                    DESCRIP.Text = consulta2.Fields(2).Value
                    PRECIOVTAP.Text = FormatCurrency(consulta2.Fields(3).Value)
                    EXISTENCIASP.Text = consulta2.Fields(4).Value
                    ESTADO.Text = consulta2.Fields(5).Value
                Else
                    MsgBox("La cve del producto esta vacia el producto no existe")
                End If
            End If
        End If


    End Sub

    Private Sub btnEP_Click(sender As Object, e As EventArgs) Handles btnEP.Click
        PanelEP.Visible = True
        btnEP.Enabled = False
        btnModP.Enabled = False
        btnBajaTP.Enabled = False
        btnRP.Enabled = False
    End Sub

    Private Sub btnInsP_Click(sender As Object, e As EventArgs) Handles btnInsP.Click
        ban = New ADODB.Parameter
        Dim clave As Integer
        clave = 0
        comanC = New ADODB.Command
        With comanC
            .CommandText = "PRODAUTO"
            .CommandType = CommandType.StoredProcedure
            '.Parameters.Append(.CreateParameter("0", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , Val(CVEPROV.Text))) ' sirve para un entero decimal o money para el tipo de dato fecha se busca como date y para el tipo de dato money se busca como currency'
            .Parameters.Append(.CreateParameter("0", DataTypeEnum.adVarChar, ParameterDirectionEnum.adParamInput, 30, NOMPROD.Text))
            .Parameters.Append(.CreateParameter("1", DataTypeEnum.adVarChar, ParameterDirectionEnum.adParamInput, 60, DESCRIP.Text))
            .Parameters.Append(.CreateParameter("2", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , claveUser))
            .Parameters.Append(.CreateParameter("3", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamOutput, , 0)) 'BANDERA val(nombredelcampo.Text)'
            .ActiveConnection = conexionc
            .Execute()
            ban.Value = .Parameters(3).Value

        End With
        If ban.Value = 1 Then
            MsgBox("EL NOMBRE DEL PRODUCTO NO DEBE DE ESTAR VACIO")
        Else
            If ban.Value = 2 Then
                MsgBox("LA DESCRICION NO DEBE DE ESTAR VACIA")
            Else
                If ban.Value = 5 Then
                    MsgBox("ESTE PRODUCTO YA SE ENCUENTRA REGISTRADO EN LA BASE DE DATOS")
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
                                consql = ("select max(cveprod) from productos")
                                consultaC = New ADODB.Recordset
                                consultaC = conexionc.Execute(consql)
                                If Not consultaC.EOF Then
                                    clave = consultaC.Fields(0).Value
                                End If
                                MsgBox("La cve del producto es: " & clave & " insercion correcta")
                                NOMPROD.Text = ""
                                DESCRIP.Text = ""
                                'AÑADIR LOS CAMPOS QUE FALTAN'
                                clave = 0
                            End If
                        End If
                    End If
                End If
            End If
        End If
    End Sub

    Private Sub btnModP_Click(sender As Object, e As EventArgs) Handles btnModP.Click
        PanelOPP.Visible = True
        btnEP.Enabled = False
        btnModP.Enabled = False
        btnBajaTP.Enabled = False
        btnRP.Enabled = False
    End Sub

    Private Sub btnBajaTP_Click(sender As Object, e As EventArgs) Handles btnBajaTP.Click
        PanelTP.Visible = True
        btnEP.Enabled = False
        btnModP.Enabled = False
        btnBajaTP.Enabled = False
        btnRP.Enabled = False
    End Sub

    Private Sub btnRP_Click(sender As Object, e As EventArgs) Handles btnRP.Click
        PanelRP.Visible = True
        btnEP.Enabled = False
        btnModP.Enabled = False
        btnBajaTP.Enabled = False
        btnRP.Enabled = False
    End Sub

    Private Sub btnre4_Click(sender As Object, e As EventArgs) Handles btnre4.Click
        PanelRP.Visible = False
        btnEP.Enabled = True
        btnModP.Enabled = True
        btnBajaTP.Enabled = True
        btnRP.Enabled = True
    End Sub

    Private Sub btnre1_Click(sender As Object, e As EventArgs)
        PanelOPP.Visible = False
        btnBajaTP.Enabled = True
        btnEP.Enabled = True
        btnModP.Enabled = True
        btnRP.Enabled = True
    End Sub

    Private Sub btnre2_Click(sender As Object, e As EventArgs) Handles btnre2.Click
        PanelEP.Visible = False
        btnBajaTP.Enabled = True
        btnEP.Enabled = True
        btnModP.Enabled = True
        btnRP.Enabled = True
    End Sub

    Private Sub btnre3_Click(sender As Object, e As EventArgs) Handles btnre3.Click
        PanelTP.Visible = False
        btnBajaTP.Enabled = True
        btnEP.Enabled = True
        btnModP.Enabled = True
        btnRP.Enabled = True
    End Sub

    Private Sub btnBajaTempP_Click(sender As Object, e As EventArgs) Handles btnBajaTempP.Click
        ban = New ADODB.Parameter
        comanC = New ADODB.Command
        With comanC
            .CommandText = "BAJAPRODTEMP"
            .CommandType = CommandType.StoredProcedure
            '.Parameters.Append(.CreateParameter("0", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , Val(CVEPROV.Text))) ' sirve para un entero decimal o money para el tipo de dato fecha se busca como date y para el tipo de dato money se busca como currency'
            .Parameters.Append(.CreateParameter("0", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , Val(combotemporal.SelectedItem)))
            .Parameters.Append(.CreateParameter("1", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , claveUser))
            .Parameters.Append(.CreateParameter("2", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamOutput, , 0)) 'BANDERA val(nombredelcampo.Text)'
            .ActiveConnection = conexionc
            .Execute()
            ban.Value = .Parameters(2).Value

        End With
        If ban.Value = 1 Then
            MsgBox("LA CLAVE DEL PRODUCTO NO PUEDE ESTAR VACIA")
        Else
            If ban.Value = 2 Then
                MsgBox("LA CLAVE DEL PRODUCTO NO EXISTE")
            Else
                If ban.Value = 3 Then
                    MsgBox("HAY EXISTENCIAS DENTRO DEL PRODUCTO, NO SE PUEDE DAR DE BAJA")
                Else
                    If ban.Value = 4 Then
                        MsgBox("EL PRODUCTO NO SE ENCUENTRA DADO DE ALTA")
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
                                    MsgBox("PRDUCTO DADO DE BAJA")
                                    combotemporal.SelectedText = ""
                                    'AÑADIR LOS CAMPOS QUE FALTAN'
                                End If
                            End If
                        End If
                    End If
                End If
            End If
        End If
    End Sub

    Private Sub ElimProd_Click(sender As Object, e As EventArgs) Handles ElimProd.Click
        ban = New ADODB.Parameter
        comanC = New ADODB.Command
        With comanC
            .CommandText = "BAJPROD"
            .CommandType = CommandType.StoredProcedure
            '.Parameters.Append(.CreateParameter("0", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , Val(CVEPROV.Text))) ' sirve para un entero decimal o money para el tipo de dato fecha se busca como date y para el tipo de dato money se busca como currency'
            .Parameters.Append(.CreateParameter("0", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , Val(comboeliminar.SelectedItem)))
            .Parameters.Append(.CreateParameter("1", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , claveUser))
            .Parameters.Append(.CreateParameter("2", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamOutput, , 0)) 'BANDERA val(nombredelcampo.Text)'
            .ActiveConnection = conexionc
            .Execute()
            ban.Value = .Parameters(2).Value

        End With
        If ban.Value = 1 Then
            MsgBox("LA CLAVE DEL PRODUCTO NO PUEDE ESTAR VACIA")
        Else
            If ban.Value = 2 Then
                MsgBox("HAY EXISTENCIAS DENTRO DEL PRODUCTO, NO SE PUEDE DAR DE BAJA")
            Else
                If ban.Value = 3 Then
                    MsgBox("EL PRODUCTO TIENE UNA CADUCIDAD ASIGNADA")
                Else
                    If ban.Value = 4 Then
                        MsgBox("EL PRODUCTO TIENE UNA VENTA ASIGNADA")
                    Else
                        If ban.Value = 5 Then
                            MsgBox("EL PRODUCTO TIENE UNA COMPRA ASIGNADA")
                        Else
                            If ban.Value = 6 Then
                                MsgBox("LA CLAVE DEL PRODUCTO NO EXISTE")
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
                                            MsgBox("PRODUCTO ELIMINADO CON EXITO")
                                            'AÑADIR LOS CAMPOS QUE FALTAN'
                                            comboeliminar.SelectedText = ""
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

    Private Sub btnReacP_Click(sender As Object, e As EventArgs) Handles btnReacP.Click
        ban = New ADODB.Parameter
        comanC = New ADODB.Command
        With comanC
            .CommandText = "REACTPROD"
            .CommandType = CommandType.StoredProcedure
            '.Parameters.Append(.CreateParameter("0", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , Val(CVEPROV.Text))) ' sirve para un entero decimal o money para el tipo de dato fecha se busca como date y para el tipo de dato money se busca como currency'
            .Parameters.Append(.CreateParameter("0", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , Val(comboreac.SelectedItem)))
            .Parameters.Append(.CreateParameter("1", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , claveUser))
            .Parameters.Append(.CreateParameter("2", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamOutput, , 0)) 'BANDERA val(nombredelcampo.Text)'
            .ActiveConnection = conexionc
            .Execute()
            ban.Value = .Parameters(2).Value

        End With
        If ban.Value = 1 Then
            MsgBox("LA CVE DEL PRODUCTO NO DEBE DE ESTAR VACIA")
        Else
            If ban.Value = 2 Then
                MsgBox("LA CLAVE DEL PRODUCTO NO EXISTE")
            Else
                If ban.Value = 3 Then
                    MsgBox("EL PRODUCTO NO SE ENCUENTRA DADO DE BAJA TEMPORALMENTE")
                Else
                    If ban.Value = 4 Then
                        MsgBox("EL PRODUCTO NO SE ENCUENTRA DADO DE ALTA ")
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
                                    MsgBox("PRODUCTO REACTIVADO")
                                    comboreac.SelectedText = ""
                                    'AÑADIR LOS CAMPOS QUE FALTAN'
                                End If
                            End If
                        End If
                    End If
                End If
            End If
        End If
    End Sub

    Private Sub btnModNP_Click(sender As Object, e As EventArgs) Handles btnModNP.Click
        ban = New ADODB.Parameter
        comanC = New ADODB.Command
        With comanC
            .CommandText = "MODNOMPROD"
            .CommandType = CommandType.StoredProcedure
            '.Parameters.Append(.CreateParameter("0", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , Val(CVEPROV.Text))) ' sirve para un entero decimal o money para el tipo de dato fecha se busca como date y para el tipo de dato money se busca como currency'
            .Parameters.Append(.CreateParameter("0", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , Val(combomod.SelectedItem)))
            .Parameters.Append(.CreateParameter("1", DataTypeEnum.adVarChar, ParameterDirectionEnum.adParamInput, 30, txtnompro.Text))
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
                MsgBox("EL NOMBRE DEL PRODUCTO NO PUEDE ESTAR VACIO")
            Else
                If ban.Value = 3 Then
                    MsgBox("ESTE NOMBRE YA SE ENCUENTRA REGISTRADO")
                Else
                    If ban.Value = 4 Then
                        MsgBox("ESTE PRODUCTO NO EXISTE")
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
                                    MsgBox("NOMBRE DE PRODUCTO MODIFICADO CON EXITO")
                                    txtnompro.Text = ""
                                    'AÑADIR LOS CAMPOS QUE FALTAN'
                                End If
                            End If
                        End If
                    End If
                End If
            End If
        End If
    End Sub

    Private Sub btnModDP_Click(sender As Object, e As EventArgs) Handles btnModDP.Click
        ban = New ADODB.Parameter
        comanC = New ADODB.Command
        With comanC
            .CommandText = "MODDESPROD"
            .CommandType = CommandType.StoredProcedure
            '.Parameters.Append(.CreateParameter("0", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , Val(CVEPROV.Text))) ' sirve para un entero decimal o money para el tipo de dato fecha se busca como date y para el tipo de dato money se busca como currency'
            .Parameters.Append(.CreateParameter("0", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , Val(combomod.SelectedItem)))
            .Parameters.Append(.CreateParameter("1", DataTypeEnum.adVarChar, ParameterDirectionEnum.adParamInput, 60, txtdescp.Text))
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
                MsgBox("LA DESCRPICION NO PUEDE ESTAR VACIA")
            Else
                If ban.Value = 3 Then
                    MsgBox("ESTE PRODUCTO NO SE ENCUENTRA REGISTRADO EN LA BD")
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
                                MsgBox("DESCRIPCION ACTULIZADA CON EXITO")
                                txtdescp.Text = ""
                                'AÑADIR LOS CAMPOS QUE FALTAN'

                            End If
                        End If
                    End If
                End If
            End If
        End If
    End Sub

    Private Sub btnSalir_Click(sender As Object, e As EventArgs) Handles btnSalir.Click
        menuprin.Enabled = True
        menuprin.Visible = True
        Close()
    End Sub

End Class