Public Class Medicamentos_gnral
    Private Sub MedicamentosGral_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        menuprin.Enabled = False
        menuprin.Visible = False
        If (depa = "VENTAS") Then
            consultaV = New ADODB.Recordset
            consultaV = conexionv.Execute("select cvemed from medicamentos order by cvemed")

            While Not consultaV.EOF
                CVEMED.Items.Add(consultaV.Fields(0).Value) 'si no jala fijate en referencias y en propiedades, y le ponemos la opcion 5 en false'
                comboeliminar.Items.Add(consultaV.Fields(0).Value)
                combotemporal.Items.Add(consultaV.Fields(0).Value)
                comboreac.Items.Add(consultaV.Fields(0).Value)
                combomod.Items.Add(consultaV.Fields(0).Value)
                consultaV.MoveNext()
            End While
        End If
        If (depa = "COMPRAS" Or depa = "GERENCIA") Then
            consultaC = New ADODB.Recordset
            consultaC = conexionc.Execute("select cvemed from medicamentos order by cvemed")

            While Not consultaC.EOF
                CVEMED.Items.Add(consultaC.Fields(0).Value) 'si no jala fijate en referencias y en propiedades, y le ponemos la opcion 5 en false'
                comboeliminar.Items.Add(consultaC.Fields(0).Value)
                combotemporal.Items.Add(consultaC.Fields(0).Value)
                comboreac.Items.Add(consultaC.Fields(0).Value)
                combomod.Items.Add(consultaC.Fields(0).Value)
                consultaC.MoveNext()
            End While
        End If

    End Sub

    Private Sub btnConsulta_Click(sender As Object, e As EventArgs) Handles btnConsulta.Click
        If CVEMED.SelectedItem = 0 Then
            MsgBox("CLAVE VACIA")
        Else
            consulta2 = New ADODB.Recordset
            If (depa = "COMPRAS" Or depa = "GERENCIA") Then

                consulta2 = conexionc.Execute("select * from medicamentos where cvemed=" & CVEMED.Text)
                If Not consulta2.EOF Then
                    NOMED.Text = consulta2.Fields(1).Value
                    DESCRIPCIONM.Text = consulta2.Fields(2).Value
                    PRECIOCOMPM.Text = FormatCurrency(consulta2.Fields(3).Value)
                    PRECIOVTAM.Text = FormatCurrency(consulta2.Fields(4).Value)
                    EXISTENCIASM.Text = consulta2.Fields(5).Value
                    ESTADO.Text = consulta2.Fields(6).Value
                Else
                    MsgBox("La cve del medicamento esta vacia o esta dada de baja")
                End If
            End If
            If (depa = "VENTAS") Then
                consulta2 = conexionv.Execute("select * from medicamentos where cvemed=" & CVEMED.Text)
                If Not consulta2.EOF Then
                    NOMED.Text = consulta2.Fields(1).Value
                    DESCRIPCIONM.Text = consulta2.Fields(2).Value
                    PRECIOVTAM.Text = FormatCurrency(consulta2.Fields(3).Value)
                    EXISTENCIASM.Text = consulta2.Fields(4).Value
                    ESTADO.Text = consulta2.Fields(5).Value
                Else
                    MsgBox("La cve del medicamento esta vacia o esta dada de baja")
                End If
            End If
        End If

    End Sub

    Private Sub btnSalir_Click(sender As Object, e As EventArgs) Handles btnSalir.Click
        menuprin.Enabled = True
        menuprin.Visible = True
        Close()
    End Sub

    Private Sub btnEM_Click(sender As Object, e As EventArgs) Handles btnEM.Click
        PanelEM.Visible = True
        btnEM.Enabled = False
        btnModM.Enabled = False
        btnBajaTM.Enabled = False
        btnRM.Enabled = False
    End Sub

    Private Sub btnModM_Click(sender As Object, e As EventArgs) Handles btnModM.Click
        PanelOP.Visible = True
        btnModM.Enabled = False
        btnEM.Enabled = False
        btnBajaTM.Enabled = False
        btnRM.Enabled = False
    End Sub

    Private Sub btnBajaTM_Click(sender As Object, e As EventArgs) Handles btnBajaTM.Click
        PanelTM.Visible = True
        btnBajaTM.Enabled = False
        btnEM.Enabled = False
        btnModM.Enabled = False
        btnRM.Enabled = False
    End Sub

    Private Sub btnre1_Click(sender As Object, e As EventArgs) Handles btnre1.Click
        PanelOP.Visible = False
        btnBajaTM.Enabled = True
        btnEM.Enabled = True
        btnModM.Enabled = True
        btnRM.Enabled = True
    End Sub

    Private Sub btnre2_Click(sender As Object, e As EventArgs) Handles btnre2.Click
        PanelEM.Visible = False
        btnBajaTM.Enabled = True
        btnEM.Enabled = True
        btnModM.Enabled = True
        btnRM.Enabled = True
    End Sub

    Private Sub btnre3_Click(sender As Object, e As EventArgs) Handles btnre3.Click
        PanelTM.Visible = False
        btnBajaTM.Enabled = True
        btnEM.Enabled = True
        btnModM.Enabled = True
        btnRM.Enabled = True
    End Sub

    Private Sub ElimMed_Click(sender As Object, e As EventArgs) Handles ElimMed.Click
        ban = New ADODB.Parameter
        comanC = New ADODB.Command
        With comanC
            .CommandText = "BAJAMED"
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
            MsgBox("LA CLAVE DEL MEDICAMENTO NO PUEDE ESTAR VACIA")
        Else
            If ban.Value = 2 Then
                MsgBox("HAY EXISTENCIAS DENTRO DEL MEDICAMENTO, NO SE PUEDE DAR DE BAJA")
            Else
                If ban.Value = 3 Then
                    MsgBox("EL MEDICAMENTO TIENE UNA CADUCIDAD ASIGNADA")
                Else
                    If ban.Value = 4 Then
                        MsgBox("EL MEDICAMENTO TIENE UNA VENTA ASIGNADA")
                    Else
                        If ban.Value = 5 Then
                            MsgBox("EL MEDICAMENTO TIENE UNA COMPRA ASIGNADA")
                        Else
                            If ban.Value = 6 Then
                                MsgBox("LA CLAVE DEL MEDICAMENTO NO EXISTE")
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
                                            MsgBox("MEDICAMENTO ELIMINADO CON EXITO")
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

    Private Sub btnModD_Click(sender As Object, e As EventArgs) Handles btnModD.Click
        ban = New ADODB.Parameter
        comanC = New ADODB.Command
        With comanC
            .CommandText = "MODDESMED"
            .CommandType = CommandType.StoredProcedure
            '.Parameters.Append(.CreateParameter("0", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , Val(CVEPROV.Text))) ' sirve para un entero decimal o money para el tipo de dato fecha se busca como date y para el tipo de dato money se busca como currency'
            .Parameters.Append(.CreateParameter("0", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , Val(combomod.SelectedItem)))
            .Parameters.Append(.CreateParameter("1", DataTypeEnum.adVarChar, ParameterDirectionEnum.adParamInput, 60, txtdesc.Text))
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
                MsgBox("LA DESCRPICION NO PUEDE ESTAR VACIA")
            Else
                If ban.Value = 2 Then
                    MsgBox("EL MEDICAMENTO NO EXISTE")
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
                                txtdesc.Text = ""
                                'AÑADIR LOS CAMPOS QUE FALTAN'
                            End If
                        End If
                    End If
                End If
            End If
        End If
    End Sub

    Private Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click
        ban = New ADODB.Parameter
        comanC = New ADODB.Command
        With comanC
            .CommandText = "MODNOMMED"
            .CommandType = CommandType.StoredProcedure
            '.Parameters.Append(.CreateParameter("0", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , Val(CVEPROV.Text))) ' sirve para un entero decimal o money para el tipo de dato fecha se busca como date y para el tipo de dato money se busca como currency'
            .Parameters.Append(.CreateParameter("0", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , Val(combomod.SelectedItem)))
            .Parameters.Append(.CreateParameter("1", DataTypeEnum.adVarChar, ParameterDirectionEnum.adParamInput, 30, txtnomed.Text))
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
                MsgBox("EL NOMBRE DEL MEDICAMENTO NO PUEDE ESTAR VACIO")
            Else
                If ban.Value = 3 Then
                    MsgBox("ESTE NOMBRE YA SE ENCUENTRA REGISTRADO")
                Else
                    If ban.Value = 4 Then
                        MsgBox("ESTE MEDICAMENTO NO EXISTE")
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
                                    MsgBox("DESCRIPCION ACTUALIZADA CON EXITO")
                                    txtnomed.Text = ""
                                    'AÑADIR LOS CAMPOS QUE FALTAN'
                                End If
                            End If
                        End If
                    End If
                End If
            End If
        End If
    End Sub

    Private Sub btnBajaTemp_Click(sender As Object, e As EventArgs) Handles btnBajaTemp.Click
        ban = New ADODB.Parameter
        comanC = New ADODB.Command
        With comanC
            .CommandText = "BAJAMEDTEMP"
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
            MsgBox("LA CVE DEL MEDICAMENTO NO DEBE DE ESTAR VACIA")
        Else
            If ban.Value = 2 Then
                MsgBox("LA CLAVE DEL MEDICAMENTO NO EXISTE")
            Else
                If ban.Value = 3 Then
                    MsgBox("HAY EXISTENCIAS DENTRO DEL MEDICAMENTO, NO SE PUEDE DAR DE BAJA")
                Else
                    If ban.Value = 4 Then
                        MsgBox("ESTE MEDICAMENTO NO SE ENCUENTRA DADO DE ALTA ")
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
                                    MsgBox("MEDICAMENTO DADO DE BAJA")
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

    Private Sub btnRM_Click(sender As Object, e As EventArgs) Handles btnRM.Click
        PanelRM.Visible = True
        btnBajaTM.Enabled = False
        btnEM.Enabled = False
        btnModM.Enabled = False
        btnRM.Enabled = False
    End Sub

    Private Sub btnre4_Click(sender As Object, e As EventArgs) Handles btnre4.Click
        PanelRM.Visible = False
        btnBajaTM.Enabled = True
        btnEM.Enabled = True
        btnModM.Enabled = True
        btnRM.Enabled = True
    End Sub

    Private Sub btnReac_Click(sender As Object, e As EventArgs) Handles btnReac.Click
        ban = New ADODB.Parameter
        comanC = New ADODB.Command
        With comanC
            .CommandText = "REACTMED"
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
            MsgBox("LA CLAVE DEL MEDICAMENTO NO PUEDE ESTAR VACIA")
        Else
            If ban.Value = 2 Then
                MsgBox("EL MEDICAMENTO NO SE ENCUENTRA DADO DE BAJA TEMPORALMENTE")
            Else
                If ban.Value = 3 Then
                    MsgBox("EL MEDICAMENTO NO EXISTE")
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
                                MsgBox("MEDICAMENTO REACTIVADO")
                                comboreac.SelectedText = ""
                                'AÑADIR LOS CAMPOS QUE FALTAN'
                            End If
                        End If
                    End If
                End If
            End If
        End If
    End Sub

    Private Sub btnInsM_Click(sender As Object, e As EventArgs) Handles btnInsM.Click
        ban = New ADODB.Parameter
        Dim clave As Integer
        clave = 4000
        comanC = New ADODB.Command
        With comanC
            .CommandText = "MEDAUTO"
            .CommandType = CommandType.StoredProcedure
            '.Parameters.Append(.CreateParameter("0", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , Val(CVEPROV.Text))) ' sirve para un entero decimal o money para el tipo de dato fecha se busca como date y para el tipo de dato money se busca como currency'
            .Parameters.Append(.CreateParameter("0", DataTypeEnum.adVarChar, ParameterDirectionEnum.adParamInput, 30, NOMED.Text))
            .Parameters.Append(.CreateParameter("1", DataTypeEnum.adVarChar, ParameterDirectionEnum.adParamInput, 60, DESCRIPCIONM.Text))
            .Parameters.Append(.CreateParameter("2", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , claveUser)) 'BANDERA val(nombredelcampo.Text)'
            .Parameters.Append(.CreateParameter("3", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamOutput, , 0)) 'BANDERA val(nombredelcampo.Text)'
            .ActiveConnection = conexionc
            .Execute()
            ban.Value = .Parameters(3).Value

        End With
        If ban.Value = 1 Then
            MsgBox("EL NOMBRE DEL MEDICAMENTO NO DEBE DE ESTAR VACIO")
        Else
            If ban.Value = 2 Then
                MsgBox("LA DESCRICION NO DEBE DE ESTAR VACIA")
            Else
                If ban.Value = 5 Then
                    MsgBox("ESTE MEDICAMENTO YA SE ENCUENTRA REGISTRADO EN LA BASE DE DATOS")
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
                                consql = ("select max(cvemed) from medicamentos")
                                consultaC = New ADODB.Recordset
                                consultaC = conexionc.Execute(consql)
                                If Not consultaC.EOF Then
                                    clave = consultaC.Fields(0).Value
                                End If
                                MsgBox("La cve del medicamento es: " & clave & " insercion correcta")
                                NOMED.Text = ""
                                DESCRIPCIONM.Text = ""
                                'AÑADIR LOS CAMPOS QUE FALTAN'
                                clave = 0
                            End If
                        End If
                    End If
                End If
            End If
        End If
    End Sub

End Class