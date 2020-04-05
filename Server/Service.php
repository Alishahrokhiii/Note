<?php
if (!isset($_GET["action"])){
    echo "invalid Request";
    exit;
}

$action = $_GET["action"];

if($action == "insert")
{
    $conn = getConnection();
    $jsonString = file_get_contents('php://input');
    $data = json_decode($jsonString,true);
    $task_title = $data["task_title"];
    $task_desc = $data["task_desc"];
    $task_done = $data["task_done"];

    $sql = "INSERT INTO task (task_title,task_desc,task_done) values ('$task_title','$task_desc','$task_done')";
    if (mysqli_query($conn,$sql)){
        $last_id = mysqli_insert_id($conn);
        echo $last_id;
    } else {
        echo "erorr:  ". $sql  . "<br>" . mysqli_error($conn);
    }
  ///  $result = $conn->query($sql);

   /// echo $result;
}else if($action == "select"){

$conn = getConnection();

    $sql = "SELECT * FROM task";
    $result = $conn->query($sql);

    $output = array();

    if ($result->num_rows > 0) {

        // output data of each row
        while($row = $result->fetch_assoc()) {

            $record = array();
            $record["task_id"] = $row["task_id"];
            $record["task_title"] = $row["task_title"];
            $record["task_desc"] = $row["task_desc"];
            $record["task_done"] = $row["task_done"];

            array_push($output,$record);
        }

    } else {
        echo "0 results";
    }

    echo json_encode($output);

    $conn->close();

}else if($action == "update"){
    $conn = getConnection();
    $jsonString = file_get_contents('php://input');
    $data = json_decode($jsonString,true);
    $task_id = $data["task_id"];
    $task_title = $data["task_title"];
    $task_desc = $data["task_desc"];
    $task_done = $data["task_done"];

    $sql = "UPDATE task SET task_title ='$task_title',task_desc ='$task_desc',task_done ='$task_done' WHERE task_id='task_id' ";
    if (mysqli_query($conn,$sql)){
        echo "recourd updated successfulluy";
    }else{
        echo "Erorr updating record:   " . mysqli_error($conn);
    }

}else if($action == "delete"){
    $conn = getConnection();
    $jsonString = file_get_contents('php://input');
    $data = json_decode($jsonString,true);
    $task_id = $data["task_id"];

    $sql = "DELETE FROM task WHERE task_id= '$task_id'";
    if (mysqli_query($conn,$sql)){
        echo "OK";
    }else{
        echo "Erorr updating record:   " . mysqli_error($conn);
    }

}
function getConnection(){
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
    return $conn;
}
?>