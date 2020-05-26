Public Class modEmpleados
    Friend valor As Integer
    Private Sub modEmpleados_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        If valor = 1 Then
            MsgBox("DATOS CARGADOS CORRESPONDIENTES AL EMPLEADO")
        Else
            menuprin.Enabled = False
            menuprin.Visible = False
            consulta4 = conexionv.Execute("select cvemp from empleados order by cvemp")
            'PARA LA EDAD'
            Dim edad As Integer
            edad = 18
            While Not edad > 69
                EDADEMP.Items.Add(edad)
                edad = edad + 1
            End While

            While Not consulta4.EOF
                CVEMP.Items.Add(consulta4.Fields(0).Value)
                consulta4.MoveNext()
            End While
            btnBB.Visible = True
        End If
    End Sub

    Private Sub btnre2_Click(sender As Object, e As EventArgs) Handles btnre2.Click
        empleados.Enabled = True
        CVEMP.Text = ""
        NOMEMP.Text = ""
        DIREMP.Text = ""
        CORREOEMP.Text = ""
        TELEMP.Text = ""
        EDADEMP.Text = ""
        PUESTO.Text = ""
        ACTIVO.Text = ""
        valor = 0
        Close()
    End Sub

    Private Sub modN_Click(sender As Object, e As EventArgs) Handles modN.Click
        valor = 5
        btncan.Enabled = True
        btnApli.Enabled = True
        moT.Enabled = False
        modN.Enabled = False
        modP.Enabled = False
        modE.Enabled = False
        modEGral.Enabled = False
        NOMEMP.Enabled = True
    End Sub

    Private Sub btncan_Click(sender As Object, e As EventArgs) Handles btncan.Click
        If valor = 5 Then
            NOMEMP.Enabled = False
        End If
        If valor = 9 Then
            NOMEMP.Enabled = False
            DIREMP.Enabled = False
            TELEMP.Enabled = False
            CORREOEMP.Enabled = False
            EDADEMP.Enabled = False
            PUESTO.Enabled = False
            DEPTO.Enabled = False
        End If
        If valor = 6 Then
            PUESTO.Enabled = False
        End If
        If valor = 7 Then
            EDADEMP.Enabled = False
        End If
        If valor = 8 Then
            TELEMP.Enabled = False
        End If
        moT.Enabled = True
        btncan.Enabled = False
        btnApli.Enabled = False
        modN.Enabled = True
        modP.Enabled = True
        modE.Enabled = True
        modEGral.Enabled = True
        valor = 0
    End Sub

    Private Sub modEGral_Click(sender As Object, e As EventArgs) Handles modEGral.Click
        valor = 9
        btncan.Enabled = True
        btnApli.Enabled = True
        modN.Enabled = False
        moT.Enabled = False
        modP.Enabled = False
        modE.Enabled = False
        modEGral.Enabled = False
        NOMEMP.Enabled = True
        DIREMP.Enabled = True
        TELEMP.Enabled = True
        CORREOEMP.Enabled = True
        EDADEMP.Enabled = True
        PUESTO.Enabled = True
        DEPTO.Enabled = True
    End Sub

    Private Sub modP_Click(sender As Object, e As EventArgs) Handles modP.Click
        valor = 6
        btncan.Enabled = True
        btnApli.Enabled = True
        modN.Enabled = False
        modP.Enabled = False
        moT.Enabled = False
        modE.Enabled = False
        modEGral.Enabled = False
        PUESTO.Enabled = True

    End Sub

    Private Sub modE_Click(sender As Object, e As EventArgs) Handles modE.Click
        valor = 7
        btncan.Enabled = True
        btnApli.Enabled = True
        modN.Enabled = False
        modP.Enabled = False
        modE.Enabled = False
        moT.Enabled = False
        modEGral.Enabled = False
        Dim edad As Integer
        edad = 18
        While Not edad > 69
            EDADEMP.Items.Add(edad)
            edad = edad + 1
        End While
        EDADEMP.Enabled = True
    End Sub

    Private Sub moT_Click(sender As Object, e As EventArgs) Handles moT.Click
        valor = 8
        btncan.Enabled = True
        btnApli.Enabled = True
        moT.Enabled = False
        modN.Enabled = False
        modP.Enabled = False
        modE.Enabled = False
        modEGral.Enabled = False
        TELEMP.Enabled = True
    End Sub

    Private Sub btnApli_Click(sender As Object, e As EventArgs) Handles btnApli.Click
        ban = New ADODB.Parameter
        comanV = New ADODB.Command
        If valor = 5 Then
            With comanV
                .CommandText = "MODNOMEMP"
                .CommandType = CommandType.StoredProcedure
                '.Parameters.Append(.CreateParameter("0", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , Val(CVEPROV.Text))) ' sirve para un entero decimal o money para el tipo de dato fecha se busca como date y para el tipo de dato money se busca como currency'
                .Parameters.Append(.CreateParameter("0", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , Val(CVEMP.SelectedItem)))
                .Parameters.Append(.CreateParameter("1", DataTypeEnum.adVarChar, ParameterDirectionEnum.adParamInput, 50, NOMEMP.Text))
                .Parameters.Append(.CreateParameter("2", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , claveUser))
                .Parameters.Append(.CreateParameter("3", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamOutput, , 0)) 'BANDERA val(nombredelcampo.Text)'
                .ActiveConnection = conexionv
                .Execute()
                ban.Value = .Parameters(3).Value

            End With
            If ban.Value = 1 Then
                MsgBox("LA CVE DEL EMPLEADO NO DEBE DE ESTAR VACIA")
            Else
                If ban.Value = 2 Then
                    MsgBox("LA CVE DEL EMPLEADO NO DEBE DE ESTAR VACIA")
                Else
                    If ban.Value = 3 Then
                        MsgBox("EL NOMBRE EXCEDE LOS CARACTERES")
                    Else
                        If ban.Value = 4 Then
                            MsgBox("EL NOMBRE DEL EMPLEADO TIENE NUMEROS")
                        Else
                            If ban.Value = 5 Then
                                MsgBox("EL EMPLEADO NO EXISTE")
                            Else
                                If ban.Value = 6 Then
                                    MsgBox("ESTE NOMBRE YA SE ENCUENTRA REGISTRADO CON OTRO EMPLEADO")
                                Else
                                    If ban.Value = 7 Then
                                        MsgBox("EL USUARIO INGRESADO TIENE UNA SESION INICIADA, CIERRE ESA SESION PARA TERMINAR")
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
                                                        MsgBox("NOMBRE MODIFICADO")
                                                        NOMEMP.Enabled = False
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
        End If
        If valor = 6 Then
            With comanV
                .CommandText = "MODPUEEMP"
                .CommandType = CommandType.StoredProcedure
                '.Parameters.Append(.CreateParameter("0", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , Val(CVEPROV.Text))) ' sirve para un entero decimal o money para el tipo de dato fecha se busca como date y para el tipo de dato money se busca como currency'
                .Parameters.Append(.CreateParameter("0", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , Val(CVEMP.SelectedItem)))
                .Parameters.Append(.CreateParameter("1", DataTypeEnum.adVarChar, ParameterDirectionEnum.adParamInput, 30, PUESTO.SelectedItem.ToString))
                .Parameters.Append(.CreateParameter("2", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , claveUser))
                .Parameters.Append(.CreateParameter("3", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamOutput, , 0)) 'BANDERA val(nombredelcampo.Text)'
                .ActiveConnection = conexionv
                .Execute()
                ban.Value = .Parameters(3).Value

            End With
            If ban.Value = 1 Then
                MsgBox("LA CVE DEL EMPLEADO NO DEBE DE ESTAR VACIA")
            Else
                If ban.Value = 2 Then
                    MsgBox("EL PUESTO DEL EMPLEADO NO DEBE DE ESTAR VACIO")
                Else
                    If ban.Value = 3 Then
                        MsgBox("EL PUESTO DEL EMPLEADO DEBE DE SER CAJERO(A) O MOSTRADOR")
                    Else
                        If ban.Value = 4 Then
                            MsgBox("EL NOMBRE EXCEDE LOS CARACTERES")
                        Else
                            If ban.Value = 5 Then
                                MsgBox("EL EMPLEADO NO EXISTE")
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
                                                MsgBox("PUESTO MODIFICADO")
                                                PUESTO.Enabled = False
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
        If valor = 7 Then
            With comanV
                .CommandText = "MODEDAEMP"
                .CommandType = CommandType.StoredProcedure
                '.Parameters.Append(.CreateParameter("0", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , Val(CVEPROV.Text))) ' sirve para un entero decimal o money para el tipo de dato fecha se busca como date y para el tipo de dato money se busca como currency'
                .Parameters.Append(.CreateParameter("0", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , Val(CVEMP.SelectedItem)))
                .Parameters.Append(.CreateParameter("1", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , Val(EDADEMP.SelectedItem)))
                .Parameters.Append(.CreateParameter("2", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , claveUser))
                .Parameters.Append(.CreateParameter("3", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamOutput, , 0)) 'BANDERA val(nombredelcampo.Text)'
                .ActiveConnection = conexionv
                .Execute()
                ban.Value = .Parameters(3).Value

            End With
            If ban.Value = 1 Then
                MsgBox("LA CVE DEL EMPLEADO NO DEBE DE ESTAR VACIA")
            Else
                If ban.Value = 2 Then
                    MsgBox("LA EDAD DEL EMPLEADO NO DEBE DE ESTAR VACIA")
                Else
                    If ban.Value = 3 Then
                        MsgBox("LA EDAD DEL EMPLEADO DEBE DE SER MAYOR A 18 AÑOS")
                    Else
                        If ban.Value = 4 Then
                            MsgBox("EL EMPLEADO NO EXISTE")
                        Else
                            If ban.Value = 5 Then
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
                                                MsgBox("EDAD MODIFICADA")
                                                EDADEMP.Enabled = False
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
        If valor = 8 Then
            With comanV
                .CommandText = "MODTELEMP"
                .CommandType = CommandType.StoredProcedure
                '.Parameters.Append(.CreateParameter("0", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , Val(CVEPROV.Text))) ' sirve para un entero decimal o money para el tipo de dato fecha se busca como date y para el tipo de dato money se busca como currency'
                .Parameters.Append(.CreateParameter("0", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , Val(CVEMP.SelectedItem)))
                .Parameters.Append(.CreateParameter("1", DataTypeEnum.adVarChar, ParameterDirectionEnum.adParamInput, 16, TELEMP.Text))
                .Parameters.Append(.CreateParameter("2", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , claveUser))
                .Parameters.Append(.CreateParameter("3", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamOutput, , 0)) 'BANDERA val(nombredelcampo.Text)'
                .ActiveConnection = conexionv
                .Execute()
                ban.Value = .Parameters(3).Value

            End With
            If ban.Value = 1 Then
                MsgBox("LA CVE DEL EMPLEADO NO DEBE DE ESTAR VACIA")
            Else
                If ban.Value = 2 Then
                    MsgBox("EL TELEFONO DEL EMPLEADO NO DEBE DE ESTAR VACIO'")
                Else
                    If ban.Value = 3 Then
                        MsgBox("LA LONGITUD DEL TELEFONO EXCEDE LA CANTIDAD PERMITIDA")
                    Else
                        If ban.Value = 4 Then
                            MsgBox("EL EMPLEADO NO EXISTE")
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
                                            MsgBox("TELEFONO MODIFICADO")
                                            TELEMP.Enabled = False
                                        End If
                                    End If
                                End If
                            End If
                        End If
                    End If
                End If
            End If
        End If
        If valor = 9 Then
            With comanV
                .CommandText = "MODEMP"
                .CommandType = CommandType.StoredProcedure
                '.Parameters.Append(.CreateParameter("0", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , Val(CVEPROV.Text))) ' sirve para un entero decimal o money para el tipo de dato fecha se busca como date y para el tipo de dato money se busca como currency'
                .Parameters.Append(.CreateParameter("0", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , Val(CVEMP.SelectedItem)))
                .Parameters.Append(.CreateParameter("1", DataTypeEnum.adVarChar, ParameterDirectionEnum.adParamInput, 50, NOMEMP.Text))
                .Parameters.Append(.CreateParameter("2", DataTypeEnum.adVarChar, ParameterDirectionEnum.adParamInput, 30, DIREMP.Text))
                .Parameters.Append(.CreateParameter("3", DataTypeEnum.adVarChar, ParameterDirectionEnum.adParamInput, 50, CORREOEMP.Text))
                .Parameters.Append(.CreateParameter("4", DataTypeEnum.adVarChar, ParameterDirectionEnum.adParamInput, 50, TELEMP.Text))
                .Parameters.Append(.CreateParameter("5", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , Val(EDADEMP.SelectedItem)))
                .Parameters.Append(.CreateParameter("6", DataTypeEnum.adVarChar, ParameterDirectionEnum.adParamInput, 20, PUESTO.Text))
                .Parameters.Append(.CreateParameter("7", DataTypeEnum.adVarChar, ParameterDirectionEnum.adParamInput, 10, DEPTO.Text))
                .Parameters.Append(.CreateParameter("8", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , claveUser))
                .Parameters.Append(.CreateParameter("9", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamOutput, , 0)) 'BANDERA val(nombredelcampo.Text)'
                .ActiveConnection = conexionv
                .Execute()
                ban.Value = .Parameters(9).Value

            End With
            If ban.Value = 1 Then
                MsgBox("LA CVE DEL EMPLEADO NO PUEDE ESTAR VACIA")
            Else
                If ban.Value = 2 Then
                    MsgBox("EL NOMBRE DEL EMPLEADO NO DEBE DE ESTAR VACIO")
                Else
                    If ban.Value = 3 Then
                        MsgBox("LA DIRECCION DEL EMPLEADO NO DEBE DE ESTAR VACIO")
                    Else
                        If ban.Value = 4 Then
                            MsgBox("EL CORREO DEL EMPLEADO NO DEBE DE ESTAR VACIO")
                        Else
                            If ban.Value = 5 Then
                                MsgBox("EL TELEFONO DEL EMPLEADO NO DEBE DE ESTAR VACIO")
                            Else
                                If ban.Value = 6 Then
                                    MsgBox("EL TELEFONO DEL EMPLEADO TIENE LETRAS")
                                Else
                                    If ban.Value = 7 Then
                                        MsgBox("LA EDAD DEL EMPLEADO NO DEBE DE ESTAR VACIA ")
                                    Else
                                        If ban.Value = 8 Then
                                            MsgBox("LA EDAD DEL EMPLEADO DEBE DE SER MAYOR A 18 AÑOS")
                                        Else
                                            If ban.Value = 9 Then
                                                MsgBox("EL PUESTO DEL EMPLEADO NO DEBE DE ESTAR VACIO")
                                            Else
                                                If ban.Value = 10 Then
                                                    MsgBox("EL PUESTO DEL EMPLEADO DEBE DE SER CAJERO(A) AUX CONTABLE, ADMINISTRADOR(A) ENC. DE TIENDA, CONTADOR(A) O  MOSTRADOR")
                                                Else
                                                    If ban.Value = 16 Then
                                                        MsgBox("ESTE EMPLEADO NO SE ENCUENTRA REGISTRADO")
                                                    Else
                                                        If ban.Value = 17 Then
                                                            MsgBox("NO SE REALIZO NINGUNA MODIFICACION AL CAMPO")
                                                        Else
                                                            If ban.Value = 18 Then
                                                                MsgBox("EL NOMBRE YA SE ENCUENTRA REGISTRADO CON OTRO EMPLEADO")
                                                            Else
                                                                If ban.Value = 19 Then
                                                                    MsgBox("ESTE TELEFONO YA SE ENCUENTRA REGISTRADO")
                                                                Else
                                                                    If ban.Value = 20 Then
                                                                        MsgBox("EL CORREO ELECTRONICO YA SE ENCUENTRA REGISTRADO")
                                                                    Else
                                                                        If ban.Value = 21 Then
                                                                            MsgBox("EL DEPTO DEL EMPLEADO NO DEBE DE ESTAR VACIO")
                                                                        Else
                                                                            If ban.Value = 22 Then
                                                                                MsgBox("EL DEPARTAMENTO NO COINCIDE CON LOS ESTABLECIDOS EN LA BD, COMPRAS, VENTAS, GERENCIA")
                                                                            Else
                                                                                If ban.Value = 23 Then
                                                                                    MsgBox("SESION NO INICIADA, INICIE UNA SESION PARA CONTINUAR")
                                                                                Else
                                                                                    If ban.Value = 24 Then
                                                                                        MsgBox("EL DEPTO NO CONCUERDA CON EL PUESTO")
                                                                                    Else
                                                                                        If ban.Value = 25 Then
                                                                                            MsgBox("EL DEPTO NO CONCUERDA CON EL PUESTO")
                                                                                        Else
                                                                                            If ban.Value = 27 Then
                                                                                                MsgBox("EL DEPTO NO CONCUERDA CON EL PUESTO")
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
                                                                                                                MsgBox("EMPLEADO ACTUALIZADO")
                                                                                                                NOMEMP.Enabled = False
                                                                                                                DIREMP.Enabled = False
                                                                                                                TELEMP.Enabled = False
                                                                                                                CORREOEMP.Enabled = False
                                                                                                                EDADEMP.Enabled = False
                                                                                                                PUESTO.Enabled = False
                                                                                                                DEPTO.Enabled = False
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
                    End If
                End If
            End If
        End If
        moT.Enabled = True
        btncan.Enabled = False
        btnApli.Enabled = False
        modN.Enabled = True
        modP.Enabled = True
        modE.Enabled = True
        modEGral.Enabled = True
        valor = 0
    End Sub

    Private Sub btnBB_Click(sender As Object, e As EventArgs) Handles btnBB.Click
        consulta3 = New ADODB.Recordset
        If CVEMP.SelectedItem = 0 Then
            MsgBox("INGRESA UNA CLAVE")
        Else
            consulta3 = conexionv.Execute("select * from empleados where cvemp=" & CVEMP.Text)
            If Not consulta3.EOF Then
                NOMEMP.Text = consulta3.Fields(1).Value
                DIREMP.Text = consulta3.Fields(2).Value
                CORREOEMP.Text = consulta3.Fields(3).Value
                TELEMP.Text = consulta3.Fields(4).Value
                EDADEMP.Text = consulta3.Fields(5).Value
                PUESTO.Text = consulta3.Fields(6).Value
                DEPTO.Text = consulta3.Fields(7).Value
                ACTIVO.Text = consulta3.Fields(8).Value
            Else
                MsgBox("La cve del empleado esta vacia o esta dada de baja")
            End If
            moT.Enabled = True
            btncan.Enabled = False
            btnApli.Enabled = False
            modN.Enabled = True
            modP.Enabled = True
            modE.Enabled = True
            modEGral.Enabled = True
            valor = 0
        End If
    End Sub

    Private Sub salirME_Click(sender As Object, e As EventArgs) Handles salirME.Click
        menuprin.Enabled = True
        menuprin.Visible = True
        Close()
    End Sub
End Class