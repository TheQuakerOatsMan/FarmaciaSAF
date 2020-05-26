Public Class confirmEmp
    Dim cveemp As Integer
    Dim cvevta As Integer
    Dim name2 As String
    Private Sub confirmEmp_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        'menuprin.Enabled = False
        'consulta = New ADODB.Recordset
        'consulta = conexion.Execute("select cvemp from empleados order by cvemp")
        'name2 = ""
        'While Not consulta.EOF
        'cvemp.Items.Add(consulta.Fields(0).Value) 'si no jala fijate en referencias y en propiedades, y le ponemos la opcion 5 en false'
        'consulta.MoveNext()
        'End While '

    End Sub

    Private Sub btnIng_Click(sender As Object, e As EventArgs) Handles btnIng.Click
        consulta2 = New ADODB.Recordset
        consulta2 = conexionv.Execute("select * from empleados where cvemp=" & claveUser)
        If Not consulta2.EOF Then
            cveemp = consulta2.Fields(0).Value
            name2 = consulta2.Fields(1).Value
        Else
            MsgBox("La cve del empleado esta vacia o el empleado esta dado de baja")
        End If

        ban = New ADODB.Parameter
        Dim clave As Integer
        clave = 100
        comanV = New ADODB.Command
        With comanV
            .CommandText = "VTAUTO"
            .CommandType = CommandType.StoredProcedure
            '.Parameters.Append(.CreateParameter("0", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , Val(CVEPROV.Text))) ' sirve para un entero decimal o money para el tipo de dato fecha se busca como date y para el tipo de dato money se busca como currency'
            .Parameters.Append(.CreateParameter("0", DataTypeEnum.adVarChar, ParameterDirectionEnum.adParamInput, 20, tppag.SelectedItem.ToString))
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
                                If ban.Value = 7 Then
                                    MsgBox("USTED NO HA INICADO SESION, INICIELA")
                                Else
                                    consql = ("select max(cvevta) from ventas")
                                    consultaV = New ADODB.Recordset
                                    consultaV = conexionv.Execute(consql)
                                    If Not consultaV.EOF Then
                                        clave = consultaV.Fields(0).Value
                                    End If
                                    MsgBox("La cve del la venta es: " & clave & " INSERCION CORRECTA")
                                    'AÑADIR LOS CAMPOS QUE FALTAN'

                                    menuprin.Visible = False
                                    'NewVenta.ctemp.Text = cvemp.Text'
                                    NewVenta.ctNEmp.Text = name
                                    NewVenta.ctNEmp.Enabled = False
                                    NewVenta.ctemp.Enabled = False
                                    NewVenta.ctpag.Enabled = False
                                    NewVenta.cvvta.Text = clave
                                    clave = 0
                                    NewVenta.Show()
                                    Close()
                                End If
                            End If
                        End If
                    End If
                End If
            End If
        End If
    End Sub

End Class