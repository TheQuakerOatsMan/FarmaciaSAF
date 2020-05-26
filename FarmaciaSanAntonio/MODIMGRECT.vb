Public Class MODIMGRECT
    Private Sub MODIMGRECT_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        txtcvemed.Enabled = False
        txtcvevta.Enabled = False
        txtimgrect.Enabled = False
        Ventas_Gnral.Enabled = False
    End Sub

    Private Sub btnchange_Click(sender As Object, e As EventArgs) Handles btnchange.Click

        ban = New ADODB.Parameter
        comando = New ADODB.Command
        With comando
            .CommandText = "MODDETVTAMED"
            .CommandType = CommandType.StoredProcedure
            '.Parameters.Append(.CreateParameter("0", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , Val(CVEPROV.Text))) ' sirve para un entero decimal o money para el tipo de dato fecha se busca como date y para el tipo de dato money se busca como currency'
            .Parameters.Append(.CreateParameter("0", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , Val(txtcvemed.Text)))
            .Parameters.Append(.CreateParameter("1", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , Val(txtcvevta.Text)))
            .Parameters.Append(.CreateParameter("2", DataTypeEnum.adVarChar, ParameterDirectionEnum.adParamInput, 100, txtimgrect.Text))
            .Parameters.Append(.CreateParameter("3", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamOutput, , 0)) 'BANDERA val(nombredelcampo.Text)'
            .ActiveConnection = conexion
            .Execute()
            ban.Value = .Parameters(3).Value

        End With
        If ban.Value = 1 Then
            MsgBox("LA CLAVE DEL MED ESTA VACIA")
        Else
            If ban.Value = 2 Then
                MsgBox("LA CLAVE DE LA VENTA ESTA VACIA")
            Else
                If ban.Value = 3 Then
                    MsgBox("LA CVE DEL MED NO EXISTE")
                Else
                    If ban.Value = 4 Then
                        MsgBox("LA CVE DE LA VENTA NO EXISTE")
                    Else
                        If ban.Value = 5 Then
                            MsgBox("LA RUTA DE LA IMAGEN NO DEBE DE ESTAR VACIA")
                        Else
                            If ban.Value = 6 Then
                                MsgBox("ESTE DETALLE NO EXISTE")
                            Else
                                If ban.Value = 7 Then
                                    MsgBox("ESTE DETALLE YA CUENTA CON LA MISMA INFO")
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
                                                    MsgBox("DETALLE MODIFICADO CON EXITO :D")
                                                    'AÑADIR LOS CAMPOS QUE FALTAN'
                                                    Ventas_Gnral.llenar_data()
                                                    Close()
                                                    Ventas_Gnral.Enabled = True
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

    Private Sub btnre1_Click(sender As Object, e As EventArgs) Handles btnre1.Click
        Close()
        Ventas_Gnral.Enabled = True
    End Sub

    Private Sub change_Click(sender As Object, e As EventArgs) Handles change.Click
        Try
            Dim archivo As New OpenFileDialog
            archivo.Filter = "ARCHIVO PDF|*.pdf"
            If archivo.ShowDialog = DialogResult.OK Then
                txtimgrect.Text = archivo.FileName
            End If
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub
End Class