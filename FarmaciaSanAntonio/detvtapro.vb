Public Class detvtam
    'VARIABLE DE VALIDACION'
    Friend vali As Integer
    Friend cventa As Integer
    Private Sub detvtapro_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        vali = NewVenta.valida
    End Sub

    Private Sub btnre8_Click(sender As Object, e As EventArgs) Handles btnre8.Click
        NewVenta.DataProd.Enabled = True
        NewVenta.DataProd.Visible = True
        NewVenta.addProd.Enabled = True
        NewVenta.addProd.Visible = True
        NewVenta.btnre.Enabled = True
        NewVenta.btnre.Visible = True
        Close()
    End Sub

    Private Sub aniadirp_Click(sender As Object, e As EventArgs) Handles aniadirp.Click
        Dim clave As Integer
        clave = 100
        If cantvp.SelectedItem IsNot Nothing Then
            If vali = 0 Then 'SE CREA UNA NUEVA VENTA'
                ban = New ADODB.Parameter
                comanV = New ADODB.Command
                With comanV
                    .CommandText = "VTAUTO"
                    .CommandType = CommandType.StoredProcedure
                    '.Parameters.Append(.CreateParameter("0", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , Val(CVEPROV.Text))) ' sirve para un entero decimal o money para el tipo de dato fecha se busca como date y para el tipo de dato money se busca como currency'
                    .Parameters.Append(.CreateParameter("0", DataTypeEnum.adVarChar, ParameterDirectionEnum.adParamInput, 20, NewVenta.ctpag.Text)) 'si te fijas puse efectivo por default, paraque pueda corrrer el poc'
                    .Parameters.Append(.CreateParameter("1", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , claveUser))
                    .Parameters.Append(.CreateParameter("2", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamOutput, , 0)) 'BANDERA val(nombredelcampo.Text)'
                    .ActiveConnection = conexionv
                    .Execute()
                    ban.Value = .Parameters(2).Value

                End With
                If ban.Value = 1 Then
                    MsgBox("EL TIPO DE PAGO NO DEBE DE ESTAR VACIO")
                Else
                    If ban.Value = 2 Then
                        MsgBox("EL TIPO DE PAGO TIENE NUMEROS")
                    Else
                        If ban.Value = 3 Then
                            MsgBox("LA CVE DEL EMPLEADO ESTA VACIA")
                        Else
                            If ban.Value = 4 Then
                                MsgBox("LA CVE DEL EMPLEADO NO EXISTE")
                            Else
                                If ban.Value = 5 Then
                                    MsgBox("ESTE EMPLEADO SE ENCUENTRA DADO DE BAJA")
                                Else
                                    If ban.Value = 6 Then
                                        MsgBox("LAS VENTAS SOLO PUEDEN SER COBRADAs (REALIZADAS) POR LOS CAJEROS, ADMINSITRADORES O ENCARGADOS DE TIENDA")
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

                                                        consql = ("select max(cvevta) from ventas")
                                                        consultaV = New ADODB.Recordset
                                                        consultaV = conexionv.Execute(consql)
                                                        If Not consultaV.EOF Then
                                                            clave = consultaV.Fields(0).Value
                                                        End If
                                                        MsgBox("VENTA INGRESADA CON EXITO CLAVE" & clave)

                                                        NewVenta.cvvta.Enabled = False
                                                        NewVenta.cvvta.Text = clave
                                                        NewVenta.btnCoVta.Enabled = True
                                                        NewVenta.btnCancel.Enabled = True
                                                        vali = 1
                                                        NewVenta.valida = vali
                                                    End If
                                                End If
                                            End If
                                        End If
                                    End If
                                End If
                            End If
                        End If
                    End If
                End If

            End If
            bande = New ADODB.Parameter
            comanV2 = New ADODB.Command
            With comanV2
                .CommandText = "DETVPRO"
                .CommandType = CommandType.StoredProcedure
                '.Parameters.Append(.CreateParameter("0", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , Val(CVEPROV.Text))) ' sirve para un entero decimal o money para el tipo de dato fecha se busca como date y para el tipo de dato money se busca como currency'
                .Parameters.Append(.CreateParameter("0", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , Val(NewVenta.cvvta.Text)))
                .Parameters.Append(.CreateParameter("1", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , Val(cveprod.Text)))
                .Parameters.Append(.CreateParameter("2", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , Val(cantvp.SelectedItem)))
                .Parameters.Append(.CreateParameter("3", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , claveUser))
                .Parameters.Append(.CreateParameter("4", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamOutput, , 0)) 'BANDERA val(nombredelcampo.Text)'
                .ActiveConnection = conexionv
                .Execute()
                bande.Value = .Parameters(4).Value

            End With
            If bande.Value = 1 Then
                MsgBox("LA CVE DE LA VENTA ESTA VACIA")
            Else
                If bande.Value = 2 Then
                    MsgBox("LA CVE DE LA VENTA NO EXISTE, MODIFICALA")
                Else
                    If bande.Value = 3 Then
                        MsgBox("LA CVE DEL PRODUCTO NO EXISTE")
                    Else
                        If bande.Value = 4 Then
                            MsgBox("LA CVE DEL PRODUCTO NO EXISTE, MODIFICALA")
                        Else
                            If bande.Value = 5 Then
                                MsgBox("LA CANTIDAD VENDIDA ESTA VACIA O ES MENOR A 1")
                            Else
                                If bande.Value = 6 Then
                                    MsgBox("ESTE PRODUCTO HA SIDO DADO DE BAJA")
                                Else
                                    If bande.Value = 7 Then
                                        MsgBox("LA CANTIDAD SOLICITADA EXCEDE LAS EXISTENCIAS DE ESTE PRODUCTO")
                                    Else
                                        If bande.Value = 8 Then
                                            MsgBox("LA CANTIDAD SOLICITADA EXCEDE LAS EXISTENCIAS DE ESTE PRODUCTO")
                                        Else
                                            If bande.Value = 9 Then
                                                MsgBox("SESION NO INICIADA")
                                            Else
                                                MsgBox("DETALLE EXITOSO")
                                                'AÑADIR LOS CAMPOS QUE FALTAN'
                                                cantvp.SelectedText = ""
                                                ''NewVenta.cargadaprod()
                                                NewVenta.actualizardatos()
                                                NewVenta.cargadatos()
                                                NewVenta.btnCoVta.Enabled = True
                                                NewVenta.btnCancel.Enabled = True
                                                NewVenta.BTNEREVTA.Enabled = False
                                                Close()
                                            End If
                                        End If
                                    End If
                                End If
                            End If
                        End If
                    End If
                End If
            End If

        Else
            MsgBox("INGRESE UNA CANTIDAD VENDIDA DEL PRODUCTO")
        End If



    End Sub

End Class