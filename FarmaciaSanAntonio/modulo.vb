Module modulo
    Public consulta As Recordset
    Public consulta1 As Recordset
    Public consulta2 As Recordset
    Public consulta3 As Recordset
    Public consulta4 As Recordset
    Public consulta5 As Recordset
    Public consulta6 As Recordset 'para compras med'
    Public consulta7 As Recordset 'compras prod'
    Public consultaUser As Recordset
    Public consultaV As Recordset 'cons de vtas
    Public consultaV2 As Recordset 'cons de vtas'
    Public consultaC As Recordset 'cons de compras'
    Public ban As ADODB.Parameter
    Public bande As ADODB.Parameter
    Public bandeEsp As ADODB.Parameter 'Variable especiál para ver el departamento'
    Public comando As ADODB.Command
    Public comandoE As ADODB.Command
    Public coman2 As ADODB.Command
    Public comanC As ADODB.Command 'comando de compras'
    Public comanC2 As ADODB.Command 'comando de compras'
    Public comanC3 As ADODB.Command 'comando de compras'
    Public comanC4 As ADODB.Command 'comando de compras'
    Public comanC5 As ADODB.Command 'comando de compras'
    Public comanV As ADODB.Command 'comando de ventas'
    Public comanV2 As ADODB.Command 'comando de ventas'
    Public conexion As ADODB.Connection 'INTERFAZ DE CONEXION DE VISUAL A SQL'
    Public conexionc As ADODB.Connection 'INTERFAZ DE CONEXION DE VISUAL A SQL compras'
    Public conexionv As ADODB.Connection 'INTERFAZ DE CONEXION DE VISUAL A SQL ventas'
    Public consql As String
    Public nusuario As String
    Public depa As String
    Public claveUser As Integer
    Public tipoPueso As Integer 'VARIBLE PARA VER EL TIPO DE PUESTO, ESTO POR SI HAY VARIOS ROLES'

    Public Sub conectar()
        conexion = New ADODB.Connection
        With conexion
            .Provider = "sqloledb"
            .ConnectionString = "INITIAL CATALOG=FarmSAntonio;SERVER=DESKTOP-7P5KUCB\SQLEXPRESS;INTEGRATED SECURITY=SSPI;PERSIST SECURITY INFO=TRUE"

            Try
                .Open()
                MessageBox.Show("Conexion correcta")


            Catch ex As Exception
                MessageBox.Show("Conexion fallida gg " + ex.ToString())

            End Try


        End With
    End Sub
    Public Sub conectacomp()
        conexionc = New ADODB.Connection
        With conexionc
            .Provider = "sqloledb"
            .ConnectionString = "INITIAL CATALOG=FarmSAntonioCompras;SERVER=DESKTOP-7P5KUCB\SQLEXPRESS;INTEGRATED SECURITY=SSPI;PERSIST SECURITY INFO=TRUE"
            Try
                .Open()
                'MessageBox.Show("Conexión Compras")

            Catch ex As Exception
                MessageBox.Show("Conexión fallidagg" + ex.ToString())
            End Try


        End With
    End Sub
    Public Sub conectavta()
        conexionv = New ADODB.Connection
        With conexionv
            .Provider = "sqloledb"
            .ConnectionString = "INITIAL CATALOG=FarmSAntonioVentas;SERVER=DESKTOP-7P5KUCB\SQLEXPRESS;INTEGRATED SECURITY=SSPI;PERSIST SECURITY INFO=TRUE"
            Try
                .Open()
                'MessageBox.Show("Conexión Ventas")

            Catch ex As Exception
                MessageBox.Show("Conexión fallidagg" + ex.ToString())
            End Try


        End With
    End Sub
    Public Sub darclave(ByVal u As String, ByVal c As String)
        consultaUser = New ADODB.Recordset
        consultaUser = conexionv.Execute("select cvemp from usuarios where nusuario='" & u & "' and contrasena='" & c & "'")
        If Not consultaUser.EOF Then
            claveUser = consultaUser.Fields(0).Value
        End If
    End Sub



End Module
