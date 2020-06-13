Public Class Login

    Private Sub Login_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        inicio.Enabled = False
    End Sub

    Private Sub btning_Click(sender As Object, e As EventArgs) Handles btning.Click
        inicio.Enabled = True
        Call conectavta()
        ban = New ADODB.Parameter
        bande = New ADODB.Parameter
        comando = New ADODB.Command
        coman2 = New ADODB.Command
        tipoPueso = 0
        With comando
            .CommandText = "ACTIVASESION"
            .CommandType = CommandType.StoredProcedure
            .Parameters.Append(.CreateParameter("0", DataTypeEnum.adVarChar, ParameterDirectionEnum.adParamInput, 10, txtUser.Text))
            .Parameters.Append(.CreateParameter("1", DataTypeEnum.adVarChar, ParameterDirectionEnum.adParamInput, 12, txtPass.Text))
            .Parameters.Append(.CreateParameter("2", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamOutput, , 0))
            .ActiveConnection = conexionv
            .Execute()
            ban.Value = .Parameters(2).Value
        End With
        If ban.Value = 1 Then
            MsgBox("EL USUARIO O LA CONTRASEÑA NO PUEDEN ESTAR VACIOS")
        Else
            If ban.Value = 2 Then
                MsgBox("EL USUARIO TIENE UNA SESIÓN ABIERTA")
            Else
                If ban.Value = 3 Then
                    MsgBox("EL USUARIO O LA CONTRASEÑA NO EXISTEN, VERIFICA")
                Else
                    With coman2
                        .CommandText = "VDEPTO"
                        .CommandType = CommandType.StoredProcedure
                        .Parameters.Append(.CreateParameter("0", DataTypeEnum.adVarChar, ParameterDirectionEnum.adParamInput, 10, txtUser.Text))
                        .Parameters.Append(.CreateParameter("1", DataTypeEnum.adVarChar, ParameterDirectionEnum.adParamInput, 12, txtPass.Text))
                        .Parameters.Append(.CreateParameter("2", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamOutput, , 0))
                        .ActiveConnection = conexionv
                        .Execute()
                        bande.Value = .Parameters(2).Value
                    End With
                    If bande.Value = 1 Then
                        MsgBox("EL USUARIO O LA CONTRASEÑA NO PUEDEN ESTAR VACIOS")
                    Else
                        If bande.Value = 2 Then
                            MsgBox("EL USUARIO O LA CONTRASEÑA NO EXISTEN, VERIFICA")
                        Else
                            If bande.Value = 3 Then
                                darclave(txtUser.Text, txtPass.Text)
                                verPue(claveUser) 'CHECAMOS EL TIPO DE PUESTO PARA VER LOS PERMISOS'
                                'Call conectavta()
                                depa = "VENTAS"
                                nusuario = txtUser.Text
                                txtUser.Text = ""
                                txtPass.Text = ""
                                MsgBox("SESIÓN INICIADA VENTAS")
                                menuprin.Show()
                            Else
                                If bande.Value = 4 Then
                                    Call conectacomp()
                                    darclave(txtUser.Text, txtPass.Text)
                                    verPue(claveUser) 'CHECAMOS EL TIPO DE PUESTO PARA VER LOS PERMISOS'
                                    'Call conectavta()
                                    depa = "GERENCIA"
                                    nusuario = txtUser.Text
                                    txtUser.Text = ""
                                    txtPass.Text = ""

                                    MsgBox("SESIÓN INICIADA GERENCIA")
                                    menuprin.Show()
                                Else
                                    If bande.Value = 5 Then
                                        darclave(txtUser.Text, txtPass.Text)
                                        verPue(claveUser) 'CHECAMOS EL TIPO DE PUESTO PARA VER LOS PERMISOS'
                                        conexionv.Close()
                                        Call conectacomp()
                                        depa = "COMPRAS"
                                        nusuario = txtUser.Text
                                        txtUser.Text = ""
                                        txtPass.Text = ""
                                        MsgBox("SESIÓN INICIADA COMPRAS")
                                        menuprin.Show()
                                    End If
                                End If
                            End If
                        End If
                    End If
                End If
            End If
        End If


    End Sub

    Private Sub btnregre_Click(sender As Object, e As EventArgs) Handles btnregre.Click
        conexionv.Close()
        Close()
        inicio.Enabled = True
    End Sub
    Public Sub verPue(ByVal c As Integer)
        bandeEsp = New ADODB.Parameter
        comandoE = New ADODB.Command
        With comandoE
            .CommandText = "VPUESTO"
            .CommandType = CommandType.StoredProcedure
            .Parameters.Append(.CreateParameter("0", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , c))
            .Parameters.Append(.CreateParameter("1", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamOutput, , 0))
            .ActiveConnection = conexionv
            .Execute()
            bandeEsp.Value = .Parameters(1).Value
        End With
        If bandeEsp.Value = 1 Then
            MsgBox("LA CLAVE NO PUEDE ESTAR VACIA")
            tipoPueso = 0
        Else
            If bandeEsp.Value = 2 Then
                MsgBox("EL EMPLEADO NO EXISTE DENTRO DE LA BD")
                tipoPueso = 0
            Else
                If ban.Value = 9 Then
                    MsgBox("PUESTO NO ESPECIFICADO")
                    tipoPueso = 0
                Else
                    If bandeEsp.Value = 3 Then
                        tipoPueso = 3
                    Else
                        If bandeEsp.Value = 4 Then
                            tipoPueso = 4
                        Else
                            If bandeEsp.Value = 5 Then
                                tipoPueso = 5
                            Else
                                If bandeEsp.Value = 6 Then
                                    tipoPueso = 6
                                Else
                                    If bandeEsp.Value = 7 Then
                                        tipoPueso = 7
                                    Else
                                        If bandeEsp.Value = 8 Then
                                            tipoPueso = 8
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
End Class