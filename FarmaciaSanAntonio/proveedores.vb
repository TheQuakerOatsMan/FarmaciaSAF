Public Class proveedores
    Private Sub proveedores_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        menuprin.Enabled = False
        consulta4 = New ADODB.Recordset
        consulta4 = conexionc.Execute("select CVEPROV from PROVEEDORES order by CVEPROV")
        While Not consulta4.EOF
            CVPROV.Items.Add(consulta4.Fields(0).Value)
            comboeliminar.Items.Add(consulta4.Fields(0).Value)
            combotemporal.Items.Add(consulta4.Fields(0).Value)
            comboreac.Items.Add(consulta4.Fields(0).Value)
            consulta4.MoveNext()
        End While
    End Sub

    Private Sub consultae_Click(sender As Object, e As EventArgs) Handles consultae.Click
        consulta3 = New ADODB.Recordset
        If CVPROV.SelectedItem = 0 Then
            MsgBox("INGRESA UNA CLAVE")
        Else
            consulta3 = conexionc.Execute("select * from PROVEEDORES where CVEPROV=" & CVPROV.Text)
            If Not consulta3.EOF Then
                NOMPROV.Text = consulta3.Fields(1).Value
                EMPRESA.Text = consulta3.Fields(2).Value
                DIRPROV.Text = consulta3.Fields(3).Value
                DIREMP.Text = consulta3.Fields(4).Value
                TELEFONO.Text = consulta3.Fields(5).Value
                ESTADO.Text = consulta3.Fields(6).Value
                CP.Text = consulta3.Fields(7).Value
                LOCALIDAD.Text = consulta3.Fields(8).Value
                CORREO.Text = consulta3.Fields(9).Value
            Else
                MsgBox("LA CLAVE DEL PROVEEDOR ESTA VACÍA O DADA DE BAJA")
            End If
        End If
    End Sub

    Private Sub btninsertar_Click(sender As Object, e As EventArgs) Handles btninsertar.Click
        ban = New ADODB.Parameter
        Dim clave As Integer
        clave = 0
        comanC = New ADODB.Command
        With comanC
            .CommandText = "PROVAUTO"
            .CommandType = CommandType.StoredProcedure
            .Parameters.Append(.CreateParameter("0", DataTypeEnum.adVarChar, ParameterDirectionEnum.adParamInput, 50, NOMPROV.Text))
            .Parameters.Append(.CreateParameter("1", DataTypeEnum.adVarChar, ParameterDirectionEnum.adParamInput, 30, EMPRESA.Text))
            .Parameters.Append(.CreateParameter("2", DataTypeEnum.adVarChar, ParameterDirectionEnum.adParamInput, 50, DIRPROV.Text))
            .Parameters.Append(.CreateParameter("3", DataTypeEnum.adVarChar, ParameterDirectionEnum.adParamInput, 50, DIREMP.Text))
            .Parameters.Append(.CreateParameter("4", DataTypeEnum.adVarChar, ParameterDirectionEnum.adParamInput, 15, TELEFONO.Text))
            .Parameters.Append(.CreateParameter("5", DataTypeEnum.adVarChar, ParameterDirectionEnum.adParamInput, 20, ESTADO.Text))
            .Parameters.Append(.CreateParameter("6", DataTypeEnum.adVarChar, ParameterDirectionEnum.adParamInput, 8, CP.Text))
            .Parameters.Append(.CreateParameter("7", DataTypeEnum.adVarChar, ParameterDirectionEnum.adParamInput, 30, LOCALIDAD.Text))
            .Parameters.Append(.CreateParameter("8", DataTypeEnum.adVarChar, ParameterDirectionEnum.adParamInput, 30, CORREO.Text))
            .Parameters.Append(.CreateParameter("9", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , claveUser))
            .Parameters.Append(.CreateParameter("10", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamOutput, , 0))
            .ActiveConnection = conexionc
            .Execute()
            ban.Value = .Parameters(10).Value

        End With
        If ban.Value = 1 Then
            MsgBox("EL NOMBRE DEL PROVEEDOR ESTA VACIO")
        Else
            If ban.Value = 2 Then
                MsgBox("El NOMBRE NO DEBE DE TENER CARACTERES NUMERICOS")
            Else
                If ban.Value = 3 Then
                    MsgBox("LA EMPRESA DEL PROVEEDOR NO DEBE DE ESTAR VACIA")
                Else
                    If ban.Value = 4 Then
                        MsgBox("LA DIRECCION DE LA EMPRESA NO DEBE DE ESTAR VACIA")
                    Else
                        If ban.Value = 5 Then
                            MsgBox("EL TELEFONO DEL PROVEEDOR NO DEBE DE ESTAR VACIO")
                        Else
                            If ban.Value = 6 Then
                                MsgBox("EL TELEFONO TIENE LETRAS")
                            Else
                                If ban.Value = 7 Then
                                    MsgBox("EL ESTADO NO DEBE DE ESTAR VACIO")
                                Else
                                    If ban.Value = 8 Then
                                        MsgBox("EL CODIGO POSTAL NO DEBE DE ESTAR VACIO")
                                    Else
                                        If ban.Value = 9 Then
                                            MsgBox("EL CODIGO POSTAL TIENE LETRAS")
                                        Else
                                            If ban.Value = 10 Then
                                                MsgBox("LA LOCALIDAD DEBE NO DEBE DE ESTAR VACIA")
                                            Else
                                                If ban.Value = 11 Then
                                                    MsgBox("EL CORREO DEL PROVEEDOR NO DEBE DE ESTAR VACIO")
                                                Else
                                                    If ban.Value = 21 Then
                                                        MsgBox("ESTE PROVEEDOR YA SE ENCUENTRA REGISTRADO EN LA BASE DE DATOS")
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
                                                                    consql = ("select max(cveprov) from proveedores")
                                                                    consultaC = New ADODB.Recordset
                                                                    consultaC = conexionc.Execute(consql)
                                                                    If Not consultaC.EOF Then
                                                                        clave = consultaC.Fields(0).Value
                                                                    End If
                                                                    MsgBox("La cve del proveedor es: " & clave & " insercion correcta")
                                                                    NOMPROV.Text = ""
                                                                    EMPRESA.Text = ""
                                                                    DIRPROV.Text = ""
                                                                    DIREMP.Text = ""
                                                                    TELEFONO.Text = ""
                                                                    ESTADO.Text = ""
                                                                    CP.Text = ""
                                                                    LOCALIDAD.Text = ""
                                                                    CORREO.Text = ""
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
    End Sub

    Private Sub salire_Click(sender As Object, e As EventArgs) Handles salire.Click
        menuprin.Enabled = True
        menuprin.Visible = True
        Close()
    End Sub

    Private Sub btnBajaTP_Click(sender As Object, e As EventArgs) Handles btnBajaTP.Click
        PanelTE.Visible = True
        PanelEmp.Enabled = False
        consultae.Enabled = False
        btnModP.Enabled = False
        btnRP.Enabled = False
        btnBajaTP.Enabled = False
        btnEP.Enabled = False
    End Sub

    Private Sub btnRP_Click(sender As Object, e As EventArgs) Handles btnRP.Click
        PanelRE.Visible = True
        PanelEmp.Enabled = False
        consultae.Enabled = False
        btnModP.Enabled = False
        btnRP.Enabled = False
        btnBajaTP.Enabled = False
        btnEP.Enabled = False
    End Sub

    Private Sub btnEP_Click(sender As Object, e As EventArgs) Handles btnEP.Click
        PanelEE.Visible = True
        PanelEmp.Enabled = False
        consultae.Enabled = False
        btnModP.Enabled = False
        btnRP.Enabled = False
        btnBajaTP.Enabled = False
        btnEP.Enabled = False
    End Sub

    Private Sub btnModP_Click(sender As Object, e As EventArgs) Handles btnModP.Click
        Dim frm As New modProveedores
        If (NOMPROV.Text = "" Or EMPRESA.Text = "" Or DIRPROV.Text = "" Or DIREMP.Text = "" Or TELEFONO.Text = "" Or CP.Text = "" Or LOCALIDAD.Text = "" Or CORREO.Text = "") Then
            MsgBox("INGRESA UNA CLAVE")
        Else
            frm.CVEp.Text = Val(CVPROV.SelectedItem)
            frm.CVEp.Enabled = False
            frm.NOMPROV.Text = NOMPROV.Text
            frm.EMPRESA.Text = EMPRESA.Text
            frm.DIRPROV.Text = DIRPROV.Text
            frm.DIREMP.Text = DIREMP.Text
            frm.TELEFONO.Text = TELEFONO.Text
            frm.ESTADO.Text = ESTADO.Text
            frm.CP.Text = CP.Text
            frm.LOCALIDAD.Text = LOCALIDAD.Text
            frm.CORREO.Text = CORREO.Text
            frm.btnApli.Enabled = False
            frm.btncan.Enabled = False
            frm.valor = 1
            frm.salirME.Visible = False
            frm.btnre2.Visible = True
            frm.ShowDialog()
        End If
    End Sub

    Private Sub btnre4_Click(sender As Object, e As EventArgs) Handles btnre4.Click
        PanelRE.Visible = False
        PanelEmp.Enabled = True
        consultae.Enabled = True
        btnModP.Enabled = True
        btnRP.Enabled = True
        btnBajaTP.Enabled = True
        btnEP.Enabled = True
    End Sub

    Private Sub btnReac_Click(sender As Object, e As EventArgs) Handles btnReac.Click
        ban = New ADODB.Parameter
        comanC = New ADODB.Command
        With comanC
            .CommandText = "REACTPROV"
            .CommandType = CommandType.StoredProcedure
            .Parameters.Append(.CreateParameter("0", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , Val(comboreac.SelectedItem)))
            .Parameters.Append(.CreateParameter("1", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , claveUser))
            .Parameters.Append(.CreateParameter("2", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamOutput, , 0))
            .ActiveConnection = conexionc
            .Execute()
            ban.Value = .Parameters(2).Value

        End With
        If ban.Value = 1 Then
            MsgBox("LA CLAVE DEL PROVEEDOR NO PUEDE ESTAR VACIA")
        Else
            If ban.Value = 2 Then
                MsgBox("EL PROVEEDOR NO SE ENCUENTRA DADO DE BAJA O ES INEXISTENTE")
            Else
                If ban.Value = 50 Then
                    MsgBox("LA CLAVE DEL EMPLEADO NO PUEDE ESTA VACIA")
                Else
                    If ban.Value = 51 Then
                        MsgBox("EL USUARIO NO EXISTE")

                    Else
                        If ban.Value = 52 Then
                            MsgBox("SESION NO INICIADA, INICIE UNA SESION PARA CONTINUAR")

                        Else
                            MsgBox("EMPLEADO REACTIVADO")
                            comboreac.SelectedText = ""
                            'AÑADIR LOS CAMPOS QUE FALTAN'
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
            .CommandText = "BAJAPROVTEMP"
            .CommandType = CommandType.StoredProcedure
            .Parameters.Append(.CreateParameter("0", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , Val(combotemporal.SelectedItem)))
            .Parameters.Append(.CreateParameter("1", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , claveUser))
            .Parameters.Append(.CreateParameter("2", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamOutput, , 0))
            .ActiveConnection = conexionc
            .Execute()
            ban.Value = .Parameters(2).Value

        End With
        If ban.Value = 1 Then
            MsgBox("LA CLAVE DEL PROVEEDOR NO PUEDE ESTAR VACIA")
        Else
            If ban.Value = 2 Then
                MsgBox("ESTA CLAVE DE PROVEEDOR NO EXISTE")
            Else
                If ban.Value = 3 Then
                    MsgBox("ESTE PROVEEDOR YA HA SIDO DADO DE BAJA TEMPORALMENTE")
                Else
                    If ban.Value = 50 Then
                        MsgBox("LA CLAVE DEL PROVEEDOR NO PUEDE ESTA VACIA")
                    Else
                        If ban.Value = 51 Then
                            MsgBox("EL USUARIO NO EXISTE")
                        Else
                            If ban.Value = 52 Then
                                MsgBox("SESION NO INICIADA, INICIE UNA SESION PARA CONTINUAR")
                            Else
                                MsgBox("PROVEEDOR DADO DE BAJA TEMPORALMENTE")
                                combotemporal.SelectedText = ""
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
        btnEP.Enabled = True
    End Sub

    Private Sub ElimMed_Click(sender As Object, e As EventArgs) Handles ElimMed.Click
        ban = New ADODB.Parameter
        comanC = New ADODB.Command
        With comanC
            .CommandText = "BAJAPROV"
            .CommandType = CommandType.StoredProcedure
            .Parameters.Append(.CreateParameter("0", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , Val(comboeliminar.SelectedItem)))
            .Parameters.Append(.CreateParameter("1", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , claveUser))
            .Parameters.Append(.CreateParameter("2", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamOutput, , 0))
            .ActiveConnection = conexionc
            .Execute()
            ban.Value = .Parameters(2).Value

        End With
        If ban.Value = 1 Then
            MsgBox("LA CLAVE DEL PROVEEDOR NO PUEDE ESTAR VACIA")
        Else
            If ban.Value = 50 Then
                MsgBox("LA CLAVE DEL EMPLEADO NO PUEDE ESTA VACIA")
            Else
                If ban.Value = 51 Then
                    MsgBox("EL USUARIO NO EXISTE")
                Else
                    If ban.Value = 52 Then
                        MsgBox("SESION NO INICIADA, INICIE UNA SESION PARA CONTINUAR")

                    Else
                        If ban.Value = 2 Then
                            MsgBox("AUN EXISTEN ARTICULOS DISPONIBLES DE ESTE PROVEEDOR")
                        Else
                            If ban.Value = 3 Then
                                MsgBox("LA CLAVE DEL PROVEEDOR NO SE ENCUENTRA REGISTRADA EN LA BASE DE DATOS")
                            Else
                                MsgBox("PROVEEDOR ELIMINADO CON EXITO")
                                comboeliminar.SelectedText = ""
                            End If
                        End If
                    End If
                End If
            End If
        End If
    End Sub

    Private Sub btnre2_Click(sender As Object, e As EventArgs) Handles btnre2.Click
        PanelEE.Visible = False
        PanelEmp.Enabled = True
        consultae.Enabled = True
        btnModP.Enabled = True
        btnRP.Enabled = True
        btnBajaTP.Enabled = True
        btnEP.Enabled = True
    End Sub

End Class