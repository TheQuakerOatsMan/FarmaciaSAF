Public Class modProveedores
    Friend valor As Integer
    Private Sub modProveedores_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        If valor = 1 Then
            MsgBox("DATOS CARGADOS CORRESPONDIENTES AL PROVEEDOR")
        Else
            menuprin.Enabled = False
            menuprin.Visible = False
            consulta4 = conexionc.Execute("select CVEPROV from PROVEEDORES order by CVEPROV")
            While Not consulta4.EOF
                CVEp.Items.Add(consulta4.Fields(0).Value)
                consulta4.MoveNext()
            End While
            btnBB.Visible = True
        End If
    End Sub

    Private Sub btnBB_Click(sender As Object, e As EventArgs) Handles btnBB.Click
        consulta3 = New ADODB.Recordset
        If CVEp.SelectedItem = "" Then
            MsgBox("INGRESA UNA CLAVE")
        Else
            consulta3 = conexionc.Execute("select * from PROVEEDORES where CVEPROV =" & CVEp.Text)
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
                MsgBox("La cve del empleado esta vacia o esta dada de baja")
            End If
            btncan.Enabled = False
            btnApli.Enabled = False
            modEGral.Enabled = True
            valor = 0
        End If
    End Sub

    Private Sub btnre2_Click(sender As Object, e As EventArgs) Handles btnre2.Click
        proveedores.Enabled = True
        CVEp.Text = ""
        NOMPROV.Text = ""
        DIRPROV.Text = ""
        DIREMP.Text = ""
        EMPRESA.Text = ""
        TELEFONO.Text = ""
        ESTADO.Text = ""
        CP.Text = ""
        LOCALIDAD.Text = ""
        CORREO.Text = ""
        valor = 0
        Close()
    End Sub

    Private Sub salirME_Click(sender As Object, e As EventArgs) Handles salirME.Click
        menuprin.Enabled = True
        menuprin.Visible = True
        Close()
    End Sub

    Private Sub btnApli_Click(sender As Object, e As EventArgs) Handles btnApli.Click
        ban = New ADODB.Parameter
        comanC = New ADODB.Command

        If valor = 9 Then
            With comanC
                .CommandText = "MODPROV"
                .CommandType = CommandType.StoredProcedure
                .Parameters.Append(.CreateParameter("0", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , Val(CVEp.Text)))
                .Parameters.Append(.CreateParameter("1", DataTypeEnum.adVarChar, ParameterDirectionEnum.adParamInput, 50, NOMPROV.Text))
                .Parameters.Append(.CreateParameter("2", DataTypeEnum.adVarChar, ParameterDirectionEnum.adParamInput, 30, EMPRESA.Text))
                .Parameters.Append(.CreateParameter("3", DataTypeEnum.adVarChar, ParameterDirectionEnum.adParamInput, 50, DIRPROV.Text))
                .Parameters.Append(.CreateParameter("4", DataTypeEnum.adVarChar, ParameterDirectionEnum.adParamInput, 50, DIREMP.Text))
                .Parameters.Append(.CreateParameter("5", DataTypeEnum.adVarChar, ParameterDirectionEnum.adParamInput, 15, TELEFONO.Text))
                .Parameters.Append(.CreateParameter("6", DataTypeEnum.adVarChar, ParameterDirectionEnum.adParamInput, 20, ESTADO.Text))
                .Parameters.Append(.CreateParameter("7", DataTypeEnum.adVarChar, ParameterDirectionEnum.adParamInput, 8, CP.Text))
                .Parameters.Append(.CreateParameter("8", DataTypeEnum.adVarChar, ParameterDirectionEnum.adParamInput, 30, LOCALIDAD.Text))
                .Parameters.Append(.CreateParameter("9", DataTypeEnum.adVarChar, ParameterDirectionEnum.adParamInput, 30, CORREO.Text))
                .Parameters.Append(.CreateParameter("10", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , claveUser))
                .Parameters.Append(.CreateParameter("11", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamOutput, , 0))
                .ActiveConnection = conexionc
                .Execute()
                ban.Value = .Parameters(11).Value

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
                                MsgBox("EL PROVEEDOR ES INEXISTENTE")
                            Else
                                MsgBox("PROVEEDOR ACTUALIZADO")
                                NOMPROV.Enabled = False
                                EMPRESA.Enabled = False
                                DIRPROV.Enabled = False
                                DIREMP.Enabled = False
                                TELEFONO.Enabled = False
                                CP.Enabled = False
                                LOCALIDAD.Enabled = False
                                CORREO.Enabled = False
                            End If
                        End If
                    End If
                End If
            End If
        End If
        btncan.Enabled = False
        btnApli.Enabled = False
        modEGral.Enabled = True
        valor = 0
    End Sub

    Private Sub modEGral_Click(sender As Object, e As EventArgs) Handles modEGral.Click
        valor = 9
        btncan.Enabled = True
        btnApli.Enabled = True
        modEGral.Enabled = False
        NOMPROV.Enabled = True
        EMPRESA.Enabled = True
        DIRPROV.Enabled = True
        DIREMP.Enabled = True
        TELEFONO.Enabled = True
        ESTADO.Enabled = True
        CP.Enabled = True
        LOCALIDAD.Enabled = True
        CORREO.Enabled = True
    End Sub

    Private Sub btncan_Click(sender As Object, e As EventArgs) Handles btncan.Click
        If valor = 9 Then
            NOMPROV.Enabled = False
            EMPRESA.Enabled = False
            DIRPROV.Enabled = False
            DIREMP.Enabled = False
            TELEFONO.Enabled = False
            CP.Enabled = False
            LOCALIDAD.Enabled = False
            CORREO.Enabled = False
        End If
        btncan.Enabled = False
        btnApli.Enabled = False
        modEGral.Enabled = True
        valor = 0
    End Sub
End Class