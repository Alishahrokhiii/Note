<!DOCTYPE html>
<html>

<head>
    <style>
        table {
            border-collapse: collapse;
            width: 100%;
        }
        th,td {
            text-align: left;
            padding: 8px;
        }
        tr:nth-child(even){background-color: #f2f2f2}
        th{
            background-color: #4CAF50;
            color: white;
        }
    </style>
</head>
<body>
<?php
$servername = "localhost";
$username = "noteproject";
$password = "noteproject";
$dbname = "noteDB";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);
// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$sql = "SELECT * FROM task";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    echo "<table>";
    echo "<tr>";
    echo "<th>ID</th>";
    echo "<th>Title</th>";
    echo "<th>Description</th>";
    echo "<th>Task Done</th>";
    echo "</tr>";
    // output data of each row
    while($row = $result->fetch_assoc()) {
        echo "<tr>";
          echo "<td>" . $row["task_id"] . "</td>";
          echo "<td>" . $row["task_title"] . "</td>";
          echo "<td>" . $row["task_desc"] . "</td>";
          echo "<td>" . $row["task_done"] . "</td>";

          echo "</tr>";
    }
    echo "</table>";
} else {
    echo "0 results";
}



$conn->close();
?>
</body>
</html>
