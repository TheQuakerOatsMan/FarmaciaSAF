Public Class confirmEmpComp

    Dim cveemp As Integer
    Dim ccomp As Integer
    Dim name2 As String

    Private Sub confirmEmpComp_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        menuprin.Enabled = False

        consulta2 = New ADODB.Recordset
        consulta2 = conexionc.Execute("select cveprov from proveedores order by cveprov")
        name2 = ""
        While Not consulta2.EOF
            procombox.Items.Add(consulta2.Fields(0).Value) 'si no jala fijate en referencias y en propiedades, y le ponemos la opcion 5 en false'
            consulta2.MoveNext()
        End While
    End Sub

    Private Sub btnCancelar_Click(sender As Object, e As EventArgs) Handles btnCancelar.Click
        menuprin.Enabled = True
        Close()
    End Sub

    Private Sub btnIng_Click(sender As Object, e As EventArgs) Handles btnIng.Click
        consulta3 = New ADODB.Recordset
        If depa = "COMPRAS" Then
            Call conectavta()
        End If
        consulta3 = conexionv.Execute("select * from empleados where cvemp=" & claveUser)
        If Not consulta3.EOF Then
            cveemp = consulta3.Fields(0).Value
            Name = consulta3.Fields(1).Value
        Else
            MsgBox("La cve del empleado esta vacia o el empleado esta dado de baja")
        End If

        ban = New ADODB.Parameter
        Dim clave As Integer
        clave = 0
        comanC = New ADODB.Command
        With comanC
            .CommandText = "COMAUTO"
            .CommandType = CommandType.StoredProcedure
            .Parameters.Append(.CreateParameter("0", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , procombox.Text))
            .Parameters.Append(.CreateParameter("1", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamInput, , claveUser))
            .Parameters.Append(.CreateParameter("2", DataTypeEnum.adInteger, ParameterDirectionEnum.adParamOutput, , 0)) 'BANDERA val(nombredelcampo.Text)'
            .ActiveConnection = conexionc
            .Execute()
            ban.Value = .Parameters(2).Value

        End With
        If ban.Value = 1 Then
            MsgBox("LA CLAVE NO DEBE ESTAR VACÍA O SER 0")
        Else
            If ban.Value = 2 Then
                MsgBox("LA CLAVE DEL PROVEEDOR NO EXISTE")
            Else
                If ban.Value = 3 Then
                    MsgBox("ESTE PROVEEDOR ESTA INACTIVO O DADO DE BAJA")
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
                                consql = ("select max(cvecomp) from compras")
                                consulta = New ADODB.Recordset
                                consulta = conexionc.Execute(consql)
                                If Not consulta.EOF Then
                                    clave = consulta.Fields(0).Value
                                End If
                                MsgBox("La cve del la compra es: " & clave & " INSERCIÓN CORRECTA")
                                'AÑADIR LOS CAMPOS QUE FALTAN'

                                menuprin.Visible = False

                                NewCompra.cvcomp.Text = clave
                                NewCompra.ctNEmp.Text = Name
                                NewCompra.ctemp.Text = claveUser

                                NewCompra.cvcomp.Enabled = False
                                NewCompra.ctNEmp.Enabled = False
                                NewCompra.ctemp.Enabled = False
                                If depa = "COMPRAS" Then
                                    conexionv.Close()
                                End If
                                clave = 0
                                NewCompra.Show()
                                Close()
                            End If
                        End If
                    End If
                End If
            End If
        End If
    End Sub


End Class