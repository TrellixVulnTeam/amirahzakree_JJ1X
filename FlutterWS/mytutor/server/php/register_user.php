<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}
include_once("dbconnect.php");
$name = $_POST['user_name'];
$email = $_POST['user_email'];
$password = $_POST['user_pass'];
$phoneNo = $_POST['user_phoneNo'];
$homeAdd = $_POST['user_homeAdd'];
$base64image = $_POST['image'];

$sqlinsert = "INSERT INTO `tbl_user`(`user_name`, `user_email`, `user_pass`, `user_phoneNo`, `user_homeAdd`) VALUES ('$name','$email','$password','$phoneNo','$homeAdd')";
if ($conn->query($sqlinsert) === TRUE) {
    $response = array('status' => 'success', 'data' => null);
    $filename = mysqli_insert_id($conn);
    $decoded_string = base64_decode($base64image);
    $path = '../assets/images/' . $filename . '.jpg';
    $is_written = file_put_contents($path, $decoded_string);
    sendJsonResponse($response);
} else {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
}

function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}
?>