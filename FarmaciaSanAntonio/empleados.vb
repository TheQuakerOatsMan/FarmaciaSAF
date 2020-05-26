Public Class empleados

    Private Sub altaemp_Paint(sender As Object, e As PaintEventArgs)
        menuprin.Enabled = False
        menuprin.Visible = False
    End Sub

    Private Sub empleados_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        menuprin.Enabled = False
        consulta4 = New ADODB.Recordset
        consulta4 = conexionv.Execute("select cvemp from empleados order by cvemp")
        'PARA LA EDAD'
        Dim edad As Integer
        edad = 18
        While Not edad > 69
            EDADEMP.Items.Add(edad)
            edad = edad + 1
        End While

        While Not consulta4.EOF
            CVEMP.Items.Add(consulta4.Fields(0).Value) 'si no jala fijate en referencias y en propiedades, y le ponemos la opcion 5 en false'
            comboeliminar.Items.Add(consulta4.Fields(0).Value)
            combotemporal.Items.Add(consulta4.Fields(0).Value)
            comboreac.Items.Add(consulta4.Fields(0).Value)
            consulta4.MoveNext()
        End While
    End Sub

    Private Sub btninsertar_Click(sender As Object, e As EventArgs) Handles btninsertar.Click
        ban = New ADODB.Parameter
        Dim clave As Integer
        clave = 0
        comanV = New ADODB.Command
        With comanV
            .CommandText = "INSEREMP"
            .CommandType = CommandType.StoredProcedure
            '.Parameters.Append(.CreateParameter("0", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , Val(CVEPROV.Text))) ' sirve para un entero decimal o money para el tipo de dato fecha se busca como date y para el tipo de dato money se busca como currency'
            .Parameters.Append(.CreateParameter("0", DataTypeEnum.adVarChar, ParameterDirectionEnum.adParamInput, 50, NOMEMP.Text))
            .Parameters.Append(.CreateParameter("1", DataTypeEnum.adVarChar, ParameterDirectionEnum.adParamInput, 30, DIREMP.Text))
            .Parameters.Append(.CreateParameter("2", DataTypeEnum.adVarChar, ParameterDirectionEnum.adParamInput, 50, CORREOEMP.Text))
            .Parameters.Append(.CreateParameter("3", DataTypeEnum.adVarChar, ParameterDirectionEnum.adParamInput, 50, TELEMP.Text))
            .Parameters.Append(.CreateParameter("4", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , Val(EDADEMP.Text)))
            .Parameters.Append(.CreateParameter("5", DataTypeEnum.adVarChar, ParameterDirectionEnum.adParamInput, 20, PUESTO.Text))
            .Parameters.Append(.CreateParameter("6", DataTypeEnum.adVarChar, ParameterDirectionEnum.adParamInput, 10, DEPTO.Text))
            .Parameters.Append(.CreateParameter("7", DataTypeEnum.adVarChar, ParameterDirectionEnum.adParamInput, 10, USER.Text))
            .Parameters.Append(.CreateParameter("8", DataTypeEnum.adVarChar, ParameterDirectionEnum.adParamInput, 12, PASS.Text))
            .Parameters.Append(.CreateParameter("9", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , claveUser))
            .Parameters.Append(.CreateParameter("10", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamOutput, , 0)) 'BANDERA val(nombredelcampo.Text)'
            .ActiveConnection = conexionv
            .Execute()
            ban.Value = .Parameters(10).Value

        End With
        If ban.Value = 1 Then
            MsgBox("EL NOMBRE DEL EMPLEADO NO DEBE DE ESTAR VACIO")
        Else
            If ban.Value = 2 Then
                MsgBox("LA DIRECCION DEL EMPLEADO NO DEBE DE ESTAR VACIO")
            Else
                If ban.Value = 3 Then
                    MsgBox("EL CORREO DEL EMPLEADO NO DEBE DE ESTAR VACIO")
                Else
                    If ban.Value = 4 Then
                        MsgBox("EL TELEFONO DEL EMPLEADO NO DEBE DE ESTAR VACIO")
                    Else
                        If ban.Value = 5 Then
                            MsgBox("EL TELEFONO DEL EMPLEADO TIENE LETRAS")
                        Else
                            If ban.Value = 6 Then
                                MsgBox("LA EDAD DEL EMPLEADO NO DEBE DE ESTAR VACIA")
                            Else
                                If ban.Value = 8 Then
                                    MsgBox("EL PUESTO DEL EMPLEADO NO DEBE DE ESTAR VACIO")
                                Else
                                    If ban.Value = 9 Then
                                        MsgBox("EL PUESTO DEL EMPLEADO DEBE DE SER CAJERO(A), MOSTRADOR, ENC. DE TIENDA, AUX. CONTABLE, ADMINISTRADOR(A) o CONTADOR(A)")
                                    Else
                                        If ban.Value = 15 Then
                                            MsgBox("ESTE EMPLEADO YA SE ENCUENTRA REGISTRADO")
                                        Else
                                            If ban.Value = 16 Then
                                                MsgBox("EL CORREO ELECTRONICO YA EXISTE")
                                            Else
                                                If ban.Value = 17 Then
                                                    MsgBox("EL DEPARTAMENTO NO PUEDE ESTAR VACIO")
                                                Else
                                                    If ban.Value = 18 Then
                                                        MsgBox("EL USUARIO NO PUEDE ESTAR VACIO")
                                                    Else
                                                        If ban.Value = 19 Then
                                                            MsgBox("LA CONTRASEÑA NO PUEDE ESTAR VACIA")
                                                        Else
                                                            If ban.Value = 20 Then
                                                                MsgBox("DEPARTAMENTO NO EXISTENTE")
                                                            Else
                                                                If ban.Value = 21 Then
                                                                    MsgBox("YA EXISTE ESTA CONTRASEÑA CON OTRO USUARIO")
                                                                Else
                                                                    consql = ("select max(cvemp) from empleados")
                                                                    If ban.Value = 22 Then
                                                                        MsgBox("EL NOMBRE DE USUARIO YA SE ENCUENTRA REGISTRADO")
                                                                    Else
                                                                        If ban.Value = 24 Then
                                                                            MsgBox("EL DEPTO NO CONCUERDA CON EL PUESTO")
                                                                        Else
                                                                            If ban.Value = 25 Then
                                                                                MsgBox("EL DEPTO NO CONCUERDA CON EL PUESTO")
                                                                            Else
                                                                                If ban.Value = 26 Then
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
                                                                                                    consultaV = New ADODB.Recordset
                                                                                                    consultaV = conexionv.Execute(consql)
                                                                                                    If Not consultaV.EOF Then
                                                                                                        clave = consultaV.Fields(0).Value
                                                                                                    End If
                                                                                                    MsgBox("La cve del empleado es: " & clave & " INSERCION CORRECTA")
                                                                                                    NOMEMP.Text = ""
                                                                                                    DIREMP.Text = ""
                                                                                                    CORREOEMP.Text = ""
                                                                                                    TELEMP.Text = ""
                                                                                                    EDADEMP.Text = ""
                                                                                                    PUESTO.Text = ""
                                                                                                    DEPTO.Text = ""
                                                                                                    USER.Text = ""
                                                                                                    PASS.Text = ""
                                                                                                    ACTIVO.Text = ""
                                                                                                    'AÑADIR LOS CAMPOS QUE FALTAN'
                                                                                                    clave = 0
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
    End Sub

    Private Sub consultae_Click(sender As Object, e As EventArgs) Handles consultae.Click
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
        End If
    End Sub

    Private Sub salire_Click(sender As Object, e As EventArgs) Handles salire.Click
        menuprin.Enabled = True
        menuprin.Visible = True
        Close()
    End Sub

    Private Sub btnReac_Click(sender As Object, e As EventArgs) Handles btnReac.Click
        ban = New ADODB.Parameter
        comanV = New ADODB.Command
        With comanV
            .CommandText = "REACTEMP"
            .CommandType = CommandType.StoredProcedure
            '.Parameters.Append(.CreateParameter("0", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , Val(CVEPROV.Text))) ' sirve para un entero decimal o money para el tipo de dato fecha se busca como date y para el tipo de dato money se busca como currency'
            .Parameters.Append(.CreateParameter("0", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , Val(comboreac.SelectedItem)))
            .Parameters.Append(.CreateParameter("1", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , claveUser))
            .Parameters.Append(.CreateParameter("2", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamOutput, , 0)) 'BANDERA val(nombredelcampo.Text)'
            .ActiveConnection = conexionv
            .Execute()
            ban.Value = .Parameters(2).Value

        End With
        If ban.Value = 1 Then
            MsgBox("LA CLAVE DEL EMPLEADO NO PUEDE ESTAR VACIA")
        Else
            If ban.Value = 2 Then
                MsgBox("LA CVE DEL EMPLEADO NO EXISTE")
            Else
                If ban.Value = 3 Then
                    MsgBox("EL EMPLEADO YA SE ENCUENTRA DADO DE ALTA")
                Else
                    If ban.Value = 4 Then
                        MsgBox("INICIE UNA SESION PARA CONTINUAR")
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
                                        MsgBox("EMPLEADO REACTIVADO")
                                        comboreac.SelectedText = ""
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

    Private Sub btnre4_Click(sender As Object, e As EventArgs) Handles btnre4.Click
        PanelRE.Visible = False
        PanelEmp.Enabled = True
        consultae.Enabled = True
        btnModP.Enabled = True
        btnRP.Enabled = True
        btnBajaTP.Enabled = True
        btnEEmp.Enabled = True
    End Sub

    Private Sub btnRP_Click(sender As Object, e As EventArgs) Handles btnRP.Click
        PanelRE.Visible = True
        PanelEmp.Enabled = False
        consultae.Enabled = False
        btnModP.Enabled = False
        btnRP.Enabled = False
        btnBajaTP.Enabled = False
        btnEEmp.Enabled = False
    End Sub

    Private Sub ElimMed_Click(sender As Object, e As EventArgs) Handles ElimMed.Click
        ban = New ADODB.Parameter
        comanV = New ADODB.Command
        With comanV
            .CommandText = "BAJAEMP"
            .CommandType = CommandType.StoredProcedure
            .Parameters.Append(.CreateParameter("0", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , Val(comboeliminar.SelectedItem)))
            .Parameters.Append(.CreateParameter("1", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , claveUser)) 'BANDERA val(nombredelcampo.Text)'
            .Parameters.Append(.CreateParameter("2", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamOutput, , 0)) 'BANDERA val(nombredelcampo.Text)'
            .ActiveConnection = conexionv
            .Execute()
            ban.Value = .Parameters(1).Value

        End With
        If ban.Value = 1 Then
            MsgBox("LA CLAVE DEL EMPLEADO NO PUEDE ESTAR VACIA")
        Else
            If ban.Value = 2 Then
                MsgBox("LA CLAVE DEL EMPELADO NO SE ENCUENTRA REGISTRADA EN LA BASE DE DATOS")
            Else
                If ban.Value = 3 Then
                    MsgBox("AUN EXISTEN VENTAS REALIZADAS POR ESTE EMPLEADO")
                Else
                    If ban.Value = 4 Then
                        MsgBox("EL USUARIO NO TIENE UNA SESION INICIADA, CIERRE ESA SESION PARA TERMINAR")
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
                                        MsgBox("EMPLEADO ELIMINADO CON EXITO")
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
    End Sub

    Private Sub btnBajaTP_Click(sender As Object, e As EventArgs) Handles btnBajaTP.Click
        PanelTE.Visible = True
        PanelEmp.Enabled = False
        consultae.Enabled = False
        btnModP.Enabled = False
        btnRP.Enabled = False
        btnBajaTP.Enabled = False
        btnEEmp.Enabled = False
    End Sub

    Private Sub btnre2_Click(sender As Object, e As EventArgs) Handles btnre2.Click
        PanelEE.Visible = False
        PanelEmp.Enabled = True
        consultae.Enabled = True
        btnModP.Enabled = True
        btnRP.Enabled = True
        btnBajaTP.Enabled = True
        btnEEmp.Enabled = True
    End Sub

    Private Sub btnBajaTemp_Click(sender As Object, e As EventArgs) Handles btnBajaTemp.Click
        ban = New ADODB.Parameter
        comanV = New ADODB.Command
        With comanV
            .CommandText = "BAJAEMPTEMP"
            .CommandType = CommandType.StoredProcedure
            '.Parameters.Append(.CreateParameter("0", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , Val(CVEPROV.Text))) ' sirve para un entero decimal o money para el tipo de dato fecha se busca como date y para el tipo de dato money se busca como currency'
            .Parameters.Append(.CreateParameter("0", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , Val(combotemporal.SelectedItem)))
            .Parameters.Append(.CreateParameter("1", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , claveUser))
            .Parameters.Append(.CreateParameter("2", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamOutput, , 0)) 'BANDERA val(nombredelcampo.Text)'
            .ActiveConnection = conexionv
            .Execute()
            ban.Value = .Parameters(2).Value

        End With
        If ban.Value = 1 Then
            MsgBox("LA CLAVE DEL EMPLEADO NO PUEDE ESTAR VACIA")
        Else
            If ban.Value = 2 Then
                MsgBox("LA CVE DEL EMPLEADO NO EXISTE")
            Else
                If ban.Value = 3 Then
                    MsgBox("ESTE EMPLEADO YA HA SIDO DADO DE BAJA TEMPORALMENTE")
                Else
                    If ban.Value = 4 Then
                        MsgBox("EL USUARIO NO TIENE UNA SESION INICIADA, CIERRE ESA SESION PARA TERMINAR")
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
                                        MsgBox("EMPLEADO DADO DE BAJA TEMPORALMENTE")
                                        combotemporal.SelectedText = ""
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

    Private Sub btnre3_Click(sender As Object, e As EventArgs) Handles btnre3.Click
        PanelTE.Visible = False
        PanelEmp.Enabled = True
        consultae.Enabled = True
        btnModP.Enabled = True
        btnRP.Enabled = True
        btnBajaTP.Enabled = True
        btnEEmp.Enabled = True
    End Sub

    Private Sub btnEEmp_Click(sender As Object, e As EventArgs) Handles btnEEmp.Click
        PanelEE.Visible = True
        PanelEmp.Enabled = False
        consultae.Enabled = False
        btnModP.Enabled = False
        btnRP.Enabled = False
        btnBajaTP.Enabled = False
        btnEEmp.Enabled = False
    End Sub

    Private Sub btnModP_Click(sender As Object, e As EventArgs) Handles btnModP.Click
        Dim frm As New modEmpleados
        If (CVEMP.SelectedItem = 0 Or NOMEMP.Text = "" Or DIREMP.Text = "" Or CORREOEMP.Text = "" Or TELEMP.Text = "" Or EDADEMP.SelectedItem = 0 Or PUESTO.Text = "" Or ACTIVO.Text = "" Or DEPTO.Text = "") Then
            MsgBox("INGRESA UNA CLAVE")
        Else
            frm.CVEMP.Text = Val(CVEMP.SelectedItem)
            frm.NOMEMP.Text = NOMEMP.Text
            frm.DIREMP.Text = DIREMP.Text
            frm.CORREOEMP.Text = CORREOEMP.Text
            frm.TELEMP.Text = TELEMP.Text
            frm.EDADEMP.Text = EDADEMP.Text
            frm.PUESTO.Text = PUESTO.Text
            frm.DEPTO.Text = DEPTO.Text
            frm.ACTIVO.Text = ACTIVO.Text
            frm.btnApli.Enabled = False
            frm.btncan.Enabled = False
            frm.valor = 1
            frm.salirME.Visible = False
            frm.btnre2.Visible = True
            frm.ShowDialog()
        End If
    End Sub

End Class