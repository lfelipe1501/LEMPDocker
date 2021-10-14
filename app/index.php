<?php
$servername = "mariadb";
$username = "felipe";
$password = "Felipe01";
$dbname = "pruebas";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);
// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
} 

$sql = "SELECT id, mensaje, nulo FROM test_content";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    // output data of each row
    while($row = $result->fetch_assoc()) {
        echo " " . $row["mensaje"]. "<br>";
    }
} else {
    echo "0 results";
}
$conn->close();
?>
